import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/entities/application/entity_states_provider.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/handlers/entity_domain_handler.dart';

/// Renders an entity via its domain handler. Returns an empty widget when the
/// entity's domain has no registered handler (skipped in v1 for non-lights).
class EntityCard extends ConsumerWidget {
  const EntityCard({super.key, required this.entity});

  final HaEntity entity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handler = ref.watch(entityDomainHandlersProvider)[entity.domain];
    if (handler == null) {
      return const SizedBox.shrink();
    }
    final state = ref.watch(
      entityStatesProvider.select((m) => m[entity.entityId]),
    );
    return handler.buildCard(entity, state);
  }
}
