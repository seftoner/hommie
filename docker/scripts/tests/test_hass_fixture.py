import importlib.util
import pathlib
import tempfile
import unittest
import yaml
spec = importlib.util.spec_from_file_location('fixture', '/scripts/hass_fixture.py')
fixture = importlib.util.module_from_spec(spec)
spec.loader.exec_module(fixture)

class FixtureTests(unittest.TestCase):
    def test_preserves_existing_entities_and_is_idempotent(self):
        with tempfile.TemporaryDirectory() as directory:
            path = pathlib.Path(directory) / 'configuration.yaml'
            path.write_text('input_boolean:\n  existing_helper:\n    name: Existing\nlight:\n  - platform: existing\n')
            fixture._write_test_fixture_config(directory)
            first = path.read_text()
            data = yaml.safe_load(first)
            self.assertIn('existing_helper', data['input_boolean'])
            self.assertEqual(data['light'][0]['platform'], 'existing')
            self.assertIn('kitchen_light_backing', data['input_boolean'])
            fixture._write_test_fixture_config(directory)
            self.assertEqual(path.read_text(), first)

    def test_include_is_preserved_or_rejected_without_writing(self):
        with tempfile.TemporaryDirectory() as directory:
            path = pathlib.Path(directory) / 'configuration.yaml'
            original = 'light: !include lights.yaml\n'
            path.write_text(original)
            with self.assertRaises(ValueError):
                fixture._write_test_fixture_config(directory)
            self.assertEqual(path.read_text(), original)

    def test_duplicate_keys_fail_without_overwriting(self):
        with tempfile.TemporaryDirectory() as directory:
            path = pathlib.Path(directory) / 'configuration.yaml'
            original = 'light: []\nlight: []\n'
            path.write_text(original)
            with self.assertRaises(ValueError):
                fixture._write_test_fixture_config(directory)
            self.assertEqual(path.read_text(), original)

    def test_unrelated_include_tag_survives(self):
        with tempfile.TemporaryDirectory() as directory:
            path = pathlib.Path(directory) / 'configuration.yaml'
            path.write_text('automation: !include automations.yaml\n')
            fixture._write_test_fixture_config(directory)
            node = yaml.compose(path.read_text())
            automation = next(value for key, value in node.value if key.value == 'automation')
            self.assertEqual(automation.tag, '!include')
            self.assertEqual(automation.value, 'automations.yaml')
