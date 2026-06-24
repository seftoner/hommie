import 'package:flutter/widgets.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/handlers/light_domain_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entity_domain_handler.g.dart';

/// Per-domain presentation plug-in. Add a device type later by registering a new
/// handler in [entityDomainHandlers] — sync, state, grouping and operations stay
/// unchanged.
abstract class EntityDomainHandler {
  const EntityDomainHandler();

  /// The HA domain this handler renders (e.g. "light").
  String get domain;

  /// Builds the card for [entity] given its (possibly null) live [state].
  Widget buildCard(HaEntity entity, EntityStateValue? state);
}

/// Registry of domain handlers keyed by domain. v1 registers only `light`.
@riverpod
Map<String, EntityDomainHandler> entityDomainHandlers(Ref ref) {
  final handlers = <EntityDomainHandler>[const LightDomainHandler()];
  return {for (final handler in handlers) handler.domain: handler};
}
