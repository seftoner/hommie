"""
FastAPI web service that provides a REST API wrapper around the Home Assistant CLI (hass-cli).
This service allows remote execution of Home Assistant CLI commands through HTTP requests,
enabling programmatic interaction with Home Assistant through its command-line interface.
"""

from fastapi import FastAPI
from pydantic import BaseModel
import subprocess
import json
import os

app = FastAPI(
    title="Home Assistant CLI Web Service",
    description="A web service that provides HTTP access to Home Assistant CLI commands",
    version="1.0.0"
)

class CommandRequest(BaseModel):
    """
    Request model for CLI command execution.
    
    Attributes:
        command: The hass-cli command to execute (excluding the base command)
        token: Home Assistant authentication token
    """
    command: str
    token: str

class CommandResponse(BaseModel):
    """
    Response model for CLI command execution results.
    
    Attributes:
        stdout: Standard output from the command
        stderr: Standard error output from the command
        exit_code: Command execution exit code (0 for success)
    """
    stdout: str
    stderr: str
    exit_code: int

@app.post("/cli")
async def execute_command(req: CommandRequest):
    """
    Execute a Home Assistant CLI command and return its results.
    
    The endpoint constructs the full hass-cli command by combining:
    - Base command (hass-cli)
    - Server URL
    - Authentication token
    - JSON output format
    - User-provided command arguments
    
    Returns:
        CommandResponse containing command execution results
    """
    try:
        base_cmd = [
            "hass-cli",
            "--server", os.getenv('HASS_URL', 'http://homeassistant:8123'),
            "--token", req.token,
            "-o", "json"
        ]
        
        command_parts = req.command.split()
        full_command = base_cmd + command_parts

        process = subprocess.run(
            full_command,
            capture_output=True,
            text=True
        )
        
        return CommandResponse(
            stdout=process.stdout,
            stderr=process.stderr,
            exit_code=process.returncode
        )
    except Exception as e:
        return CommandResponse(
            stdout="",
            stderr=str(e),
            exit_code=1
        )
