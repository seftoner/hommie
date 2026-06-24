import 'package:flutter/widgets.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/handlers/entity_domain_handler.dart';
import 'package:hommie/features/entities/presentation/widgets/light_card.dart';

/// Handles the `light` domain: an on/off card with a toggle.
class LightDomainHandler extends EntityDomainHandler {
  const LightDomainHandler();

  @override
  String get domain => 'light';

  @override
  Widget buildCard(HaEntity entity, EntityStateValue? state) =>
      LightCard(entity: entity, state: state);
}
