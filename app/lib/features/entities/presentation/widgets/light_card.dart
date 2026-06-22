import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/entities/application/entity_service_controller.dart';
import 'package:hommie/features/entities/domain/entities/entity_state_value.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

/// On/off card for a `light` entity with an optimistic toggle.
class LightCard extends ConsumerStatefulWidget {
  const LightCard({super.key, required this.entity, required this.state});

  final HaEntity entity;
  final EntityStateValue? state;

  @override
  ConsumerState<LightCard> createState() => _LightCardState();
}

class _LightCardState extends ConsumerState<LightCard> {
  bool? _optimistic;

  bool get _isOn => _optimistic ?? widget.state?.isOn ?? false;
  bool get _unavailable => widget.state == null || widget.state!.isUnavailable;

  Future<void> _toggle() async {
    final previous = _isOn;
    setState(() => _optimistic = !previous);
    try {
      await ref
          .read(entityServiceControllerProvider)
          .call(widget.entity.entityId, 'toggle');
    } catch (_) {
      if (mounted) {
        setState(() => _optimistic = previous);
      }
    }
  }

  @override
  void didUpdateWidget(covariant LightCard old) {
    super.didUpdateWidget(old);
    // Drop the optimistic override once real state catches up.
    if (_optimistic != null && widget.state?.isOn == _optimistic) {
      _optimistic = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key('light_card.${widget.entity.entityId}'),
      child: ListTile(
        leading: Icon(
          Symbols.lightbulb_rounded,
          color: _isOn ? Colors.amber : Theme.of(context).disabledColor,
        ),
        title: Text(
          widget.entity.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(_unavailable ? 'Unavailable' : (_isOn ? 'On' : 'Off')),
        trailing: Switch(
          value: _isOn,
          onChanged: _unavailable ? null : (_) => unawaited(_toggle()),
        ),
      ),
    );
  }
}
