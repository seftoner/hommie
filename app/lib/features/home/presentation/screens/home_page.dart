import 'package:flutter/material.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/entities/presentation/handlers/entity_domain_handler.dart';
import 'package:hommie/features/entities/presentation/widgets/entity_card.dart';
import 'package:hommie/features/home/application/home_page_controller.dart';
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
    final hasRenderableEntities = state.sections.any(
      (section) => section.entities.any(
        (entity) => handledDomains.contains(entity.domain),
      ),
    );

    if (state.syncFailure != null && !hasRenderableEntities) {
      return Scaffold(
        key: K.home.page,
        appBar: AppBar(title: Text(state.serverName)),
        body: const Center(child: Text('Unable to sync Home Assistant data')),
      );
    }

    if (state.isInitialSyncing && state.sections.isEmpty) {
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
            ..._sectionSlivers(state.sections, handledDomains, summary: true),
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
                    slivers: _sectionSlivers(
                      state.sections,
                      handledDomains,
                      summary: true,
                    ),
                  ),
                  HomeAreaTab(:final areaId) => CustomScrollView(
                    key: PageStorageKey('home.area.$areaId'),
                    slivers: _sectionSlivers(
                      state.sectionsForArea(areaId),
                      handledDomains,
                      summary: false,
                    ),
                  ),
                },
            ],
          ),
        ),
      ),
    );
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
  List<Widget> _sectionSlivers(
    List<AreaSection> sections,
    Set<String> handledDomains, {
    required bool summary,
  }) {
    final visible = [
      for (final section in sections)
        (
          section: section,
          entities: section.entities
              .where((e) => handledDomains.contains(e.domain))
              .toList(),
        ),
    ];

    final hasAny = visible.any((v) => v.entities.isNotEmpty);
    if (!hasAny) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: Text('No lights here yet')),
        ),
      ];
    }

    return [
      for (final v in visible)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          sliver: SliverList.list(
            children: [
              if (summary) RoomGroup(roomName: v.section.title),
              if (v.entities.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('No lights here yet'),
                )
              else
                for (final entity in v.entities) EntityCard(entity: entity),
            ],
          ),
        ),
    ];
  }
}

class RoomGroup extends StatelessWidget {
  const RoomGroup({super.key, required this.roomName});

  final String roomName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        roomName,
        style: context.fonts.titleMedium?.copyWith(
          color: context.colors.onSurfaceVariant,
        ),
      ),
    );
  }
}
