import asyncio
import subprocess
import time
import unittest
from unittest.mock import patch

from pydantic import ValidationError
from hass_cli_web import CommandRequest, execute_command, health


class BridgeTests(unittest.IsolatedAsyncioTestCase):
    async def test_arguments_with_spaces_are_not_split(self):
        args = ['raw', 'ws', 'config/area_registry/create', '--json={"name":"Kitchen 台 所"}']
        with patch('hass_cli_web.subprocess.run', return_value=subprocess.CompletedProcess([], 0, '{"success":true}', '')) as run:
            result = await execute_command(CommandRequest(args=args, token='sentinel-secret'))
        self.assertEqual(result.exit_code, 0)
        self.assertEqual(run.call_args.args[0][-4:], args)
        self.assertNotIn('sentinel-secret', run.call_args.args[0])
        self.assertEqual(run.call_args.kwargs['env']['HASS_TOKEN'], 'sentinel-secret')
        self.assertEqual(run.call_args.kwargs['timeout'], 20)

    def test_string_command_is_rejected(self):
        with self.assertRaises(ValidationError):
            CommandRequest(command='raw ws anything', args=['raw'], token='x')

    async def test_timeout_has_no_automatic_mutation_retry(self):
        with patch('hass_cli_web.subprocess.run', side_effect=subprocess.TimeoutExpired(['sentinel-secret'], 20)) as run:
            result = await execute_command(CommandRequest(args=['raw', 'ws', 'create'], token='sentinel-secret'))
        self.assertEqual(run.call_count, 1)
        self.assertEqual(result.exit_code, 124)
        self.assertIn('unknown', result.stderr.lower())
        self.assertNotIn('sentinel-secret', result.stderr)

    async def test_process_error_and_output_do_not_expose_credentials(self):
        with patch('hass_cli_web.subprocess.run', return_value=subprocess.CompletedProcess([], 1, '', 'sentinel-secret rejected')):
            result = await execute_command(CommandRequest(args=['raw'], token='sentinel-secret'))
        self.assertNotIn('sentinel-secret', result.stderr)

    async def test_health_remains_responsive_during_slow_command(self):
        def slow(*args, **kwargs):
            time.sleep(0.2)
            return subprocess.CompletedProcess([], 0, '{}', '')
        with patch('hass_cli_web.subprocess.run', side_effect=slow):
            start = time.monotonic()
            task = asyncio.create_task(execute_command(CommandRequest(args=['raw'], token='x')))
            await asyncio.sleep(0.01)
            result = await health()
            self.assertLess(time.monotonic() - start, 0.1)
            self.assertEqual(result['status'], 'ok')
            await task


if __name__ == '__main__':
    unittest.main()
