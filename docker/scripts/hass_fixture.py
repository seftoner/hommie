"""Idempotent deterministic config, independent of HA private APIs."""
import os
import sys
import yaml
from yaml.nodes import MappingNode, SequenceNode
TEST_FIXTURE_MARKER = "# hommie integration test fixture"

def _write_test_fixture_config(config_dir: str) -> None:
    """Append deterministic entities used by integration tests."""
    configuration_path = os.path.join(config_dir, "configuration.yaml")
    existing = ""
    if os.path.exists(configuration_path):
        with open(configuration_path, "r", encoding="utf-8") as config_file:
            existing = config_file.read()

    document = yaml.compose(existing or 'default_config:\n')
    if not isinstance(document, MappingNode):
        raise ValueError('configuration.yaml must be a mapping')
    keys = [key.value for key, _ in document.value]
    if len(keys) != len(set(keys)):
        raise ValueError('Duplicate configuration keys require explicit repair before fixture setup')
    if TEST_FIXTURE_MARKER in existing:
        return

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
    additions = yaml.compose(fixture)
    for key, value in additions.value:
        matches = [current for name, current in document.value if name.value == key.value]
        if not matches:
            document.value.append((key, value))
            continue
        current = matches[0]
        if current.tag != value.tag or type(current) is not type(value):
            raise ValueError(f'Cannot safely merge {key.value}; includes or conflicting types require explicit configuration')
        if isinstance(current, MappingNode):
            names = {name.value for name, _ in current.value}
            if any(name.value in names for name, _ in value.value):
                raise ValueError(f'Fixture name collision in {key.value}')
        elif not isinstance(current, SequenceNode):
            raise ValueError(f'Cannot safely merge {key.value}')
        current.value.extend(value.value)
    # Parse and validate every merge before touching the preserved file.
    temporary = configuration_path + '.hommie.tmp'
    with open(temporary, 'w', encoding='utf-8') as config_file:
        config_file.write(yaml.serialize(document))
        config_file.write('\n' + TEST_FIXTURE_MARKER + '\n')
    os.replace(temporary, configuration_path)


if __name__ == "__main__":
    _write_test_fixture_config(sys.argv[1])
