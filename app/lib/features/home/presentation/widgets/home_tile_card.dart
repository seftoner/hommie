import 'package:flutter/material.dart';
import 'package:hommie/features/entities/domain/entity_display_name.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/widgets/entity_card.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class HomeTileCard extends StatelessWidget {
  const HomeTileCard({super.key, required this.tile});

  final HomeTile tile;

  @override
  Widget build(BuildContext context) {
    if (tile.resolution == HomeTileResolution.active &&
        tile.primaryEntity != null) {
      return EntityCard(entity: tile.primaryEntity!);
    }

    return Card(
      key: Key('home_tile.${tile.kind.name}.${tile.targetId}'),
      child: ListTile(
        leading: Icon(_icon, color: Theme.of(context).disabledColor),
        title: Text(_title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(_statusLabel),
        trailing: tile.resolution == HomeTileResolution.missing
            ? Wrap(
                spacing: 8,
                children: [
                  TextButton(onPressed: () {}, child: const Text('Rebind')),
                  TextButton(onPressed: () {}, child: const Text('Remove')),
                ],
              )
            : null,
      ),
    );
  }

  IconData get _icon => switch (tile.resolution) {
    HomeTileResolution.disabled => Symbols.block_rounded,
    HomeTileResolution.missing => Symbols.link_off_rounded,
    HomeTileResolution.unavailable => Symbols.cloud_off_rounded,
    HomeTileResolution.active => Symbols.widgets_rounded,
  };

  String get _statusLabel => switch (tile.resolution) {
    HomeTileResolution.disabled => 'Disabled',
    HomeTileResolution.missing => 'Missing',
    HomeTileResolution.unavailable => 'Unavailable',
    HomeTileResolution.active => 'Ready',
  };

  String get _title {
    if (tile.resolution == HomeTileResolution.missing) {
      return tile.name;
    }
    final entity = _firstDisplayEntity;
    if (entity != null) {
      return resolveEntityDisplayName(entity);
    }
    return tile.name;
  }

  HaEntity? get _firstDisplayEntity =>
      tile.primaryEntity ??
      (tile.secondaryEntities.isEmpty ? null : tile.secondaryEntities.first);
}
