"""Independent, bounded hass-cli control for the local E2E fixture."""
import os
import subprocess
from fastapi import FastAPI
from pydantic import BaseModel, ConfigDict, Field
from starlette.concurrency import run_in_threadpool

app = FastAPI(title="Home Assistant CLI Web Service", version="2.0.0")


class CommandRequest(BaseModel):
    model_config = ConfigDict(extra="forbid")
    args: list[str] = Field(min_length=1)
    token: str = Field(min_length=1)


class CommandResponse(BaseModel):
    stdout: str
    stderr: str
    exit_code: int


@app.get("/health")
async def health():
    return {"status": "ok"}


def _execute(req):
    command = ["hass-cli", "--server", os.environ.get("HASS_URL", "http://homeassistant:8123"), "-o", "json", *req.args]
    env = {**os.environ, "HASS_TOKEN": req.token}
    try:
        result = subprocess.run(command, capture_output=True, text=True, env=env, timeout=20)
        return CommandResponse(stdout=result.stdout.replace(req.token, "[REDACTED]"),
                               stderr=result.stderr.replace(req.token, "[REDACTED]"), exit_code=result.returncode)
    except subprocess.TimeoutExpired:
        return CommandResponse(stdout="", stderr="CLI timed out; mutation completion unknown. Reconcile before retrying.", exit_code=124)
    except OSError:
        return CommandResponse(stdout="", stderr="CLI process could not execute", exit_code=127)


@app.post("/cli", response_model=CommandResponse)
async def execute_command(req: CommandRequest):
    return await run_in_threadpool(_execute, req)
