/// Live state of an entity (volatile; not persisted).
class EntityStateValue {
  final String state; // "on", "off", "unavailable", ...
  final Map<String, dynamic> attributes;

  const EntityStateValue({required this.state, this.attributes = const {}});

  bool get isOn => state == 'on';
  bool get isUnavailable => state == 'unavailable' || state == 'unknown';
}
