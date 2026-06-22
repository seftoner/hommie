import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';

void main() {
  test('isOn / isUnavailable derive from state', () {
    expect(const EntityStateValue(state: 'on').isOn, isTrue);
    expect(const EntityStateValue(state: 'off').isOn, isFalse);
    expect(const EntityStateValue(state: 'unavailable').isUnavailable, isTrue);
  });
}
