import 'package:hommie/core/domain/entities/area.dart';

class ActiveServerAreasState {
  const ActiveServerAreasState({
    required this.areas,
    required this.canEdit,
    required this.hasActiveServer,
  });

  final List<Area> areas;
  final bool canEdit;
  final bool hasActiveServer;
}

sealed class AreasSettingsFailure implements Exception {
  const AreasSettingsFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

final class AreasSettingsUnavailable extends AreasSettingsFailure {
  const AreasSettingsUnavailable()
    : super('Connect to Home Assistant to edit areas.');
}

final class AreasSettingsCommandFailure extends AreasSettingsFailure {
  const AreasSettingsCommandFailure(this.cause)
    : super('Failed to update areas: $cause');

  final Object cause;
}
