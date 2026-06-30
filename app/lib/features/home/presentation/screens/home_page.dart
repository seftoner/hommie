import 'package:flutter/material.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/presentation/handlers/entity_domain_handler.dart';
import 'package:hommie/features/entities/presentation/widgets/entity_card.dart';
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';
import 'package:hommie/features/home/presentation/widgets/home_tile_card.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([HomePageController])
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homePageControllerProvider);
    final handledDomains = ref.watch(entityDomainHandlersProvider).keys.toSet();
    final showTabs = state.tabs.length > 1;
    final hasRenderableContent =
        state.deviceSections.any(
          (section) => section.tiles.any(
            (tile) => _isRenderableTile(tile, handledDomains),
          ),
        ) ||
        state.sections.any(
          (section) => section.entities.any(
            (entity) => handledDomains.contains(entity.domain),
          ),
        );

    if (state.syncFailure != null && !hasRenderableContent) {
      return Scaffold(
        key: K.home.page,
        appBar: AppBar(title: Text(state.serverName)),
        body: const Center(child: Text('Unable to sync Home Assistant data')),
      );
    }

    if (state.isInitialSyncing &&
        state.sections.isEmpty &&
        !state.deviceSections.any((section) => section.tiles.isNotEmpty)) {
      return Scaffold(
        key: K.home.page,
        appBar: AppBar(title: Text(state.serverName)),
        body: Center(
          child: CircularProgressIndicator(key: K.home.loadingSpinner),
        ),
      );
    }

    if (!showTabs) {
      return Scaffold(
        key: K.home.page,
        body: CustomScrollView(
          slivers: [
            _appBar(context, state),
            ..._contentSlivers(
              deviceSections: state.deviceSections,
              fallbackSections: groupEntitiesByType(
                _entitiesFromSections(state.sections),
              ),
              handledDomains: handledDomains,
            ),
          ],
        ),
      );
    }

    return DefaultTabController(
      length: state.tabs.length,
      child: Scaffold(
        key: K.home.page,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            _appBar(
              context,
              state,
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  for (final tab in state.tabs)
                    switch (tab) {
                      HomeSummaryTab() => const Tab(text: 'Summary'),
                      HomeAreaTab(:final title) => Tab(text: title),
                    },
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              for (final tab in state.tabs)
                switch (tab) {
                  HomeSummaryTab() => CustomScrollView(
                    key: const PageStorageKey('home.summary'),
                    slivers: _contentSlivers(
                      deviceSections: state.deviceSections,
                      fallbackSections: groupEntitiesByType(
                        _entitiesFromSections(state.sections),
                      ),
                      handledDomains: handledDomains,
                    ),
                  ),
                  HomeAreaTab(:final areaId) => CustomScrollView(
                    key: PageStorageKey('home.area.$areaId'),
                    slivers: _contentSlivers(
                      deviceSections: state.deviceSectionsForArea(areaId),
                      fallbackSections: groupEntitiesByType(
                        _entitiesFromSections(state.sectionsForArea(areaId)),
                      ),
                      handledDomains: handledDomains,
                    ),
                  ),
                },
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _contentSlivers({
    required List<HomeDeviceSection> deviceSections,
    required List<AreaSection> fallbackSections,
    required Set<String> handledDomains,
  }) {
    final deviceSlivers = _deviceSectionSlivers(deviceSections, handledDomains);
    if (deviceSlivers != null) {
      return deviceSlivers;
    }

    return _entitySectionSlivers(fallbackSections, handledDomains);
  }

  List<Widget>? _deviceSectionSlivers(
    List<HomeDeviceSection> sections,
    Set<String> handledDomains,
  ) {
    final visible = [
      for (final section in sections)
        (
          section: section,
          tiles: section.tiles
              .where((tile) => _isRenderableTile(tile, handledDomains))
              .toList(),
        ),
    ];

    final renderable = visible.where((v) => v.tiles.isNotEmpty).toList();
    if (renderable.isEmpty) {
      return null;
    }

    return [
      for (final v in renderable)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          sliver: SliverList.list(
            children: [
              SectionGroup(title: v.section.title),
              for (final tile in v.tiles) HomeTileCard(tile: tile),
            ],
          ),
        ),
    ];
  }

  bool _isRenderableTile(HomeTile tile, Set<String> handledDomains) {
    if (tile.resolution != HomeTileResolution.active) {
      return true;
    }

    final primaryEntity = tile.primaryEntity;
    return primaryEntity != null &&
        handledDomains.contains(primaryEntity.domain);
  }

  SliverAppBar _appBar(
    BuildContext context,
    HomePageState state, {
    PreferredSizeWidget? bottom,
  }) {
    return SliverAppBar(
      title: Text(state.serverName),
      centerTitle: false,
      floating: true,
      pinned: true,
      bottom: bottom,
      actions: [
        IconButton(
          key: K.appScaffold.settingsButton,
          icon: const Icon(Symbols.settings_rounded),
          onPressed: () => const SettingsRouteData().push(context),
        ),
      ],
    );
  }

  /// Builds slivers for [sections], showing only entities whose domain has a
  /// registered handler (v1: lights). Empty areas show an empty state.
  List<Widget> _entitySectionSlivers(
    List<AreaSection> sections,
    Set<String> handledDomains,
  ) {
    final visible = [
      for (final section in sections)
        (
          section: section,
          entities: section.entities
              .where((e) => handledDomains.contains(e.domain))
              .toList(),
        ),
    ];

    final renderable = visible.where((v) => v.entities.isNotEmpty).toList();
    if (renderable.isEmpty) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: Text('No lights here yet')),
        ),
      ];
    }

    return [
      for (final v in renderable)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          sliver: SliverList.list(
            children: [
              SectionGroup(title: v.section.title),
              for (final entity in v.entities) EntityCard(entity: entity),
            ],
          ),
        ),
    ];
  }

  List<HaEntity> _entitiesFromSections(List<AreaSection> sections) => [
    for (final section in sections) ...section.entities,
  ];
}

class SectionGroup extends StatelessWidget {
  const SectionGroup({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        title,
        style: context.fonts.titleMedium?.copyWith(
          color: context.colors.onSurfaceVariant,
        ),
      ),
    );
  }
}
