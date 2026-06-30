import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:test/test.dart';

void main() {
  test('adds and changes compressed entity states', () {
    var states = <String, EntityState>{};

    states = applyStatesUpdate(
      states,
      StatesUpdates(add: {'light.a': EntityState(state: 'off')}),
    );
    expect(states['light.a']!.state, 'off');

    states = applyStatesUpdate(
      states,
      StatesUpdates(
        change: {'light.a': EntityDiff(add: EntityState(state: 'on'))},
      ),
    );
    expect(states['light.a']!.state, 'on');
  });

  test('merges added attributes onto existing compressed entity state', () {
    var states = applyStatesUpdate(
      <String, EntityState>{},
      StatesUpdates(
        add: {
          'light.a': EntityState(state: 'on', attributes: {'brightness': 10}),
        },
      ),
    );

    states = applyStatesUpdate(
      states,
      StatesUpdates(
        change: {
          'light.a': EntityDiff(
            add: EntityState(attributes: {'color_temp': 300}),
          ),
        },
      ),
    );

    expect(states['light.a']!.state, 'on');
    expect(states['light.a']!.attributes, {
      'brightness': 10,
      'color_temp': 300,
    });
  });

  test('applies attribute removals from compressed state diffs', () {
    var states = <String, EntityState>{
      'climate.thermostat': EntityState(
        state: 'heat',
        attributes: {
          'aux_heat': 'on',
          'current_temperature': 20.5,
          'friendly_name': 'Thermostat',
        },
      ),
    };

    states = applyStatesUpdate(
      states,
      StatesUpdates(
        change: {
          'climate.thermostat': EntityDiff(
            remove: EntityStateRemove(['aux_heat']),
          ),
        },
      ),
    );

    expect(states['climate.thermostat']!.state, 'heat');
    expect(states['climate.thermostat']!.attributes, {
      'current_temperature': 20.5,
      'friendly_name': 'Thermostat',
    });
  });

  test('removes entities from compressed state updates', () {
    var states = applyStatesUpdate(
      <String, EntityState>{},
      StatesUpdates(add: {'light.a': EntityState(state: 'on')}),
    );

    states = applyStatesUpdate(
      states,
      const StatesUpdates(remove: ['light.a']),
    );

    expect(states.containsKey('light.a'), isFalse);
  });
}
