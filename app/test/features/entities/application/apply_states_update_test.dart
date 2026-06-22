import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/entities/application/entity_states_provider.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';

void main() {
  test('add then change updates state map', () {
    var map = <String, EntityStateValue>{};

    map = applyStatesUpdate(
      map,
      StatesUpdates(add: {'light.a': EntityState(state: 'off')}),
    );
    expect(map['light.a']!.isOn, isFalse);

    map = applyStatesUpdate(
      map,
      StatesUpdates(change: {'light.a': EntityDiff(add: EntityState(state: 'on'))}),
    );
    expect(map['light.a']!.isOn, isTrue);
  });

  test('change merges attributes onto existing state', () {
    var map = applyStatesUpdate(
      {},
      StatesUpdates(add: {
        'light.a': EntityState(state: 'on', attributes: {'brightness': 10}),
      }),
    );
    map = applyStatesUpdate(
      map,
      StatesUpdates(change: {
        'light.a': EntityDiff(add: EntityState(attributes: {'color_temp': 300})),
      }),
    );
    expect(map['light.a']!.state, 'on'); // state preserved when '+' omits it
    expect(map['light.a']!.attributes['brightness'], 10);
    expect(map['light.a']!.attributes['color_temp'], 300);
  });

  test('remove drops the entity', () {
    var map = applyStatesUpdate(
      {},
      StatesUpdates(add: {'light.a': EntityState(state: 'on')}),
    );
    map = applyStatesUpdate(map, const StatesUpdates(remove: ['light.a']));
    expect(map.containsKey('light.a'), isFalse);
  });
}
