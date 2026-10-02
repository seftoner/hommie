"""Idempotent deterministic config, independent of HA private APIs."""
import os
import sys
TEST_FIXTURE_MARKER = "# hommie integration test fixture"

def _write_test_fixture_config(config_dir: str) -> None:
    """Append deterministic entities used by integration tests."""
    configuration_path = os.path.join(config_dir, "configuration.yaml")
    existing = ""
    if os.path.exists(configuration_path):
        with open(configuration_path, "r", encoding="utf-8") as config_file:
            existing = config_file.read()

    if TEST_FIXTURE_MARKER in existing:
        return

    if not existing.strip():
        existing = 'default_config:\n'
        with open(configuration_path, 'w', encoding='utf-8') as config_file:
            config_file.write(existing)

    fixture = f"""

{TEST_FIXTURE_MARKER}
input_boolean:
  kitchen_light_backing:
    name: Kitchen Light Backing

light:
  - platform: template
    lights:
      kitchen_light:
        unique_id: kitchen_light
        friendly_name: Kitchen Light
        value_template: "{{{{ is_state('input_boolean.kitchen_light_backing', 'on') }}}}"
        turn_on:
          service: input_boolean.turn_on
          target:
            entity_id: input_boolean.kitchen_light_backing
        turn_off:
          service: input_boolean.turn_off
          target:
            entity_id: input_boolean.kitchen_light_backing
"""
    with open(configuration_path, "a", encoding="utf-8") as config_file:
        config_file.write(fixture)


if __name__ == "__main__":
    _write_test_fixture_config(sys.argv[1])
