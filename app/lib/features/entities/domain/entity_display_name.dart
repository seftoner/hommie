import 'package:hommie/features/entities/domain/entities/ha_entity.dart';

const _knownAcronyms = {'rgb', 'rgbw', 'rgbww', 'cct', 'ip', 'ir', 'tv', 'usb'};

String resolveEntityDisplayName(HaEntity entity) {
  final name = _blankToNull(entity.name);
  if (name != null && name != entity.entityId) {
    return name;
  }
  return _displayNameFromEntityId(entity.entityId);
}

String resolveEntityRegistryDisplayName({
  required String? name,
  required String? originalName,
  required String entityId,
  String? deviceName,
}) {
  final customName = _blankToNull(name);
  if (customName != null) {
    return customName;
  }

  final fallbackDeviceName = _blankToNull(deviceName);
  final fallbackOriginalName = _blankToNull(originalName);
  if (fallbackDeviceName != null &&
      (fallbackOriginalName == null ||
          _isGenericOriginalName(fallbackOriginalName, entityId))) {
    return fallbackDeviceName;
  }

  return fallbackOriginalName ?? _displayNameFromEntityId(entityId);
}

String? _blankToNull(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}

String _displayNameFromEntityId(String entityId) {
  final objectId = entityId.contains('.')
      ? entityId.substring(entityId.indexOf('.') + 1)
      : entityId;
  final words = objectId
      .split(RegExp(r'[_\s]+'))
      .where((word) => word.isNotEmpty)
      .map(_formatWord)
      .toList();
  if (words.isEmpty) {
    return entityId;
  }
  return words.join(' ');
}

bool _isGenericOriginalName(String originalName, String entityId) {
  final domain = entityId.contains('.')
      ? entityId.substring(0, entityId.indexOf('.'))
      : entityId;
  return originalName.toLowerCase() == _formatDomain(domain).toLowerCase();
}

String _formatDomain(String domain) {
  final words = domain
      .split(RegExp(r'[_\s]+'))
      .where((word) => word.isNotEmpty)
      .map(_formatWord)
      .toList();
  if (words.isEmpty) {
    return domain;
  }
  return words.join(' ');
}

String _formatWord(String word) {
  final lower = word.toLowerCase();
  if (_knownAcronyms.contains(lower)) {
    return lower.toUpperCase();
  }
  return lower[0].toUpperCase() + lower.substring(1);
}
