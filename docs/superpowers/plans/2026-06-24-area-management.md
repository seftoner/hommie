# Area Management Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add Settings-based, name-only Home Assistant area creation, renaming, and deletion.

**Architecture:** Add a typed `api.areas` resource to `home_assistant_client`, then build app-side area providers around explicit server ids instead of duplicating scoped and active-session logic. Home remains a thin `serverScopeIdProvider` adapter; Settings uses `activeServerSessionProvider` without moving `ServerScopeHost`.

**Tech Stack:** Flutter, Dart, Riverpod codegen, GoRouter typed routes, Drift-backed repositories, `home_assistant_client` WebSocket API.

---

## File Structure

- Modify `packages/home_assistant_client/lib/src/protocol/types/hass_types.dart`
  - Add typed area registry DTO and create/update/delete response DTOs.
- Modify `packages/home_assistant_client/lib/src/api/home_assistant_api.dart`
  - Add `HomeAssistantApi.areas` and `HAAreasApi`.
- Modify `packages/home_assistant_client/lib/home_assistant_client.dart`
  - Export the area DTOs via the existing `hass_types.dart` export.
- Modify `packages/home_assistant_client/test/home_assistant_api_test.dart`
  - Test exact WebSocket payloads for list/create/rename/delete.
- Modify `app/lib/features/areas/infrastructure/repositories/areas_repository.dart`
  - Replace app-local raw message parsing with typed `api.areas.list()`.
- Create `app/lib/features/home/application/areas_for_server_provider.dart`
  - Explicit-server cache provider.
- Modify `app/lib/features/home/application/cached_areas_provider.dart`
  - Delegate to `areasForServerProvider(serverId).future.asStream()`.
- Create `app/lib/features/home/application/area_registry_sync_service.dart`
  - Shared remote list -> Drift sync service.
- Modify `app/lib/application/session/server_sync_coordinator.dart`
  - Use `areaRegistrySyncService.refresh(...)`.
- Create `app/lib/features/settings/application/areas_settings_state.dart`
  - Settings page state and typed failures.
- Create `app/lib/features/settings/application/active_server_areas_provider.dart`
  - Active-session Settings adapter.
- Create `app/lib/features/settings/application/areas_settings_controller.dart`
  - Create/rename/delete controller.
- Create `app/lib/features/settings/presentation/screens/areas_page.dart`
  - Areas CRUD page.
- Modify `app/lib/features/settings/presentation/screens/settings_page.dart`
  - Add `Areas` row with no subtitle.
- Modify `app/lib/router/routes.dart`
  - Add `/settings/areas`.
- Modify generated files via `dart run build_runner build --delete-conflicting-outputs`.

## Task 1: Typed Areas API In `home_assistant_client`

**Files:**
- Modify: `packages/home_assistant_client/lib/src/protocol/types/hass_types.dart`
- Modify: `packages/home_assistant_client/lib/src/api/home_assistant_api.dart`
- Test: `packages/home_assistant_client/test/home_assistant_api_test.dart`

- [ ] **Step 1: Add failing tests for typed area list/create/rename/delete**

Add these tests inside `group('HomeAssistantApi', () { ... })` in `packages/home_assistant_client/test/home_assistant_api_test.dart`:

```dart
    test('areas.list sends area registry list over WebSocket', () async {
      final harness = await _webSocketHarness();
      addTearDown(harness.close);

      final api = HomeAssistantApi.fromConnection(harness.connection);
      final future = api.areas.list();

      final sent = await harness.socket.nextSentWhere(
        (message) =>
            message is HARequestMessage &&
            message.type == 'config/area_registry/list',
      );
      expect(sent.toPayload(id: 2), {
        'id': 2,
        'type': 'config/area_registry/list',
      });

      harness.socket.addIncoming({
        'id': 2,
        'type': 'result',
        'success': true,
        'result': [
          {
            'created_at': 1.0,
            'modified_at': 2.0,
            'area_id': 'kitchen',
            'name': 'Kitchen',
            'aliases': <String>[],
            'labels': <String>[],
            'icon': 'mdi:countertop',
            'picture': null,
          },
        ],
      });

      final areas = await future;
      expect(areas.single.areaId, 'kitchen');
      expect(areas.single.name, 'Kitchen');
      expect(areas.single.icon, 'mdi:countertop');
    });

    test('areas.create sends area registry create over WebSocket', () async {
      final harness = await _webSocketHarness();
      addTearDown(harness.close);

      final api = HomeAssistantApi.fromConnection(harness.connection);
      final future = api.areas.create(name: 'Office');

      final sent = await harness.socket.nextSentWhere(
        (message) =>
            message is HARequestMessage &&
            message.type == 'config/area_registry/create',
      );
      expect(sent.toPayload(id: 2), {
        'id': 2,
        'type': 'config/area_registry/create',
        'name': 'Office',
      });

      harness.socket.addIncoming({
        'id': 2,
        'type': 'result',
        'success': true,
        'result': {
          'created_at': 1.0,
          'modified_at': 1.0,
          'area_id': 'office',
          'name': 'Office',
          'aliases': <String>[],
          'labels': <String>[],
        },
      });

      expect((await future).areaId, 'office');
    });

    test('areas.rename sends area registry update over WebSocket', () async {
      final harness = await _webSocketHarness();
      addTearDown(harness.close);

      final api = HomeAssistantApi.fromConnection(harness.connection);
      final future = api.areas.rename(areaId: 'office', name: 'Work room');

      final sent = await harness.socket.nextSentWhere(
        (message) =>
            message is HARequestMessage &&
            message.type == 'config/area_registry/update',
      );
      expect(sent.toPayload(id: 2), {
        'id': 2,
        'type': 'config/area_registry/update',
        'area_id': 'office',
        'name': 'Work room',
      });

      harness.socket.addIncoming({
        'id': 2,
        'type': 'result',
        'success': true,
        'result': {
          'created_at': 1.0,
          'modified_at': 3.0,
          'area_id': 'office',
          'name': 'Work room',
          'aliases': <String>[],
          'labels': <String>[],
        },
      });

      expect((await future).name, 'Work room');
    });

    test('areas.delete sends area registry delete over WebSocket', () async {
      final harness = await _webSocketHarness();
      addTearDown(harness.close);

      final api = HomeAssistantApi.fromConnection(harness.connection);
      final future = api.areas.delete(areaId: 'office');

      final sent = await harness.socket.nextSentWhere(
        (message) =>
            message is HARequestMessage &&
            message.type == 'config/area_registry/delete',
      );
      expect(sent.toPayload(id: 2), {
        'id': 2,
        'type': 'config/area_registry/delete',
        'area_id': 'office',
      });

      harness.socket.addIncoming({
        'id': 2,
        'type': 'result',
        'success': true,
        'result': null,
      });

      await expectLater(future, completes);
    });
```

- [ ] **Step 2: Run tests to verify they fail**

Run:

```bash
cd packages/home_assistant_client
dart test test/home_assistant_api_test.dart
```

Expected: compile failures because `api.areas` and `AreaRegistryEntry` do not exist in the package API.

- [ ] **Step 3: Add typed area models**

In `packages/home_assistant_client/lib/src/protocol/types/hass_types.dart`, add:

```dart
final class HassArea {
  const HassArea({
    required this.createdAt,
    required this.modifiedAt,
    required this.areaId,
    required this.name,
    this.floorId,
    this.humidityEntityId,
    this.icon,
    this.picture,
    this.temperatureEntityId,
    this.aliases = const [],
    this.labels = const [],
  });

  final double createdAt;
  final double modifiedAt;
  final String areaId;
  final String name;
  final String? floorId;
  final String? humidityEntityId;
  final String? icon;
  final String? picture;
  final String? temperatureEntityId;
  final List<String> aliases;
  final List<String> labels;

  factory HassArea.fromJson(Map<String, dynamic> json) {
    return HassArea(
      createdAt: (json['created_at'] as num?)?.toDouble() ?? 0,
      modifiedAt: (json['modified_at'] as num?)?.toDouble() ?? 0,
      areaId: json['area_id'] as String,
      name: json['name'] as String,
      floorId: json['floor_id'] as String?,
      humidityEntityId: json['humidity_entity_id'] as String?,
      icon: json['icon'] as String?,
      picture: json['picture'] as String?,
      temperatureEntityId: json['temperature_entity_id'] as String?,
      aliases: (json['aliases'] as List<dynamic>? ?? const [])
          .cast<String>(),
      labels: (json['labels'] as List<dynamic>? ?? const []).cast<String>(),
    );
  }
}
```

- [ ] **Step 4: Add `HAAreasApi`**

In `packages/home_assistant_client/lib/src/api/home_assistant_api.dart`, add the `areas` resource field:

```dart
  late final HAAreasApi areas;
```

Update `_initResources()`:

```dart
  void _initResources() {
    config = HAConfigApi._(this);
    states = HAStatesApi._(this);
    services = HAServicesApi._(this);
    entities = HAEntitiesApi._(this);
    events = HAEventsApi._(this);
    areas = HAAreasApi._(this);
  }
```

Add this class before `HAConfigApi`:

```dart
final class HAAreasApi {
  const HAAreasApi._(this._api);

  final HomeAssistantApi _api;

  Future<List<HassArea>> list() async {
    final payload = await _api._requireWebSocket().sendJson({
      'type': 'config/area_registry/list',
    });
    return (payload as List<dynamic>)
        .map((item) => HassArea.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<HassArea> create({required String name}) async {
    final payload = await _api._requireWebSocket().sendJson({
      'type': 'config/area_registry/create',
      'name': name,
    });
    return HassArea.fromJson(payload as Map<String, dynamic>);
  }

  Future<HassArea> rename({
    required String areaId,
    required String name,
  }) async {
    final payload = await _api._requireWebSocket().sendJson({
      'type': 'config/area_registry/update',
      'area_id': areaId,
      'name': name,
    });
    return HassArea.fromJson(payload as Map<String, dynamic>);
  }

  Future<void> delete({required String areaId}) async {
    await _api._requireWebSocket().sendJson({
      'type': 'config/area_registry/delete',
      'area_id': areaId,
    });
  }
}
```

- [ ] **Step 5: Run package tests**

Run:

```bash
cd packages/home_assistant_client
dart test test/home_assistant_api_test.dart
```

Expected: all tests in `home_assistant_api_test.dart` pass.

- [ ] **Step 6: Commit**

```bash
git add packages/home_assistant_client/lib/src/protocol/types/hass_types.dart packages/home_assistant_client/lib/src/api/home_assistant_api.dart packages/home_assistant_client/test/home_assistant_api_test.dart
git commit -m "feat: add typed area registry api"
```

## Task 2: Shared Area Cache Provider And Refresh Service

**Files:**
- Create: `app/lib/features/home/application/areas_for_server_provider.dart`
- Create: `app/lib/features/home/application/area_registry_sync_service.dart`
- Modify: `app/lib/features/home/application/cached_areas_provider.dart`
- Modify: `app/lib/features/areas/infrastructure/repositories/areas_repository.dart`
- Modify: `app/lib/application/session/server_sync_coordinator.dart`
- Test: `app/test/features/home/application/areas_for_server_provider_test.dart`
- Test: `app/test/features/home/application/area_registry_sync_service_test.dart`

- [ ] **Step 1: Write failing test for explicit-server cache provider**

Create `app/test/features/home/application/areas_for_server_provider_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/home/application/areas_for_server_provider.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';

class _FakeAreaRepository implements IAreaRepository {
  int? watchedServerId;

  @override
  Stream<List<Area>> watchByServer(int serverId) {
    watchedServerId = serverId;
    return Stream.value(const [Area(id: 'kitchen', name: 'Kitchen')]);
  }

  @override
  Future<List<Area>> getByServer(int serverId) async => const [];

  @override
  Future<Area?> getByHaId({required int serverId, required String haId}) async =>
      null;

  @override
  Future<void> upsert({required int serverId, required Area area}) async {}

  @override
  Future<void> syncAll({
    required int serverId,
    required List<Area> areas,
  }) async {}
}

void main() {
  test('areasForServer watches repository by explicit server id', () async {
    final repo = _FakeAreaRepository();
    final container = ProviderContainer(
      overrides: [areaRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);

    final areas = await container.read(areasForServerProvider(42).future);

    expect(repo.watchedServerId, 42);
    expect(areas.single.name, 'Kitchen');
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run:

```bash
cd app
flutter test test/features/home/application/areas_for_server_provider_test.dart
```

Expected: compile failure because `areas_for_server_provider.dart` does not exist.

- [ ] **Step 3: Implement explicit-server cache provider**

Create `app/lib/features/home/application/areas_for_server_provider.dart`:

```dart
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'areas_for_server_provider.g.dart';

@Riverpod(dependencies: [areaRepository])
Stream<List<Area>> areasForServer(Ref ref, int serverId) {
  final repo = ref.watch(areaRepositoryProvider);
  return repo.watchByServer(serverId);
}
```

Modify `app/lib/features/home/application/cached_areas_provider.dart`:

```dart
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/home/application/areas_for_server_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cached_areas_provider.g.dart';

@Riverpod(dependencies: [serverScopeId, areasForServer])
Stream<List<Area>> cachedAreas(Ref ref) {
  final serverId = ref.watch(serverScopeIdProvider);
  return ref.watch(areasForServerProvider(serverId).future).asStream();
}
```

- [ ] **Step 4: Generate provider code and run provider test**

Run:

```bash
cd app
dart run build_runner build --delete-conflicting-outputs
flutter test test/features/home/application/areas_for_server_provider_test.dart
```

Expected: provider test passes.

- [ ] **Step 5: Write failing test for refresh service**

Create `app/test/features/home/application/area_registry_sync_service_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/home/application/area_registry_sync_service.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';

class _Connection implements IHAConnection {
  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) {
    expect(message, isA<HARequestMessage>());
    expect((message as HARequestMessage).type, 'config/area_registry/list');
    return Future.value([
      {
        'created_at': 1.0,
        'modified_at': 1.0,
        'area_id': 'office',
        'name': 'Office',
        'aliases': <String>[],
        'labels': <String>[],
      },
    ]);
  }

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    throw UnimplementedError();
  }
}

class _AreaRepository implements IAreaRepository {
  int? syncedServerId;
  List<Area>? syncedAreas;

  @override
  Future<void> syncAll({
    required int serverId,
    required List<Area> areas,
  }) async {
    syncedServerId = serverId;
    syncedAreas = areas;
  }

  @override
  Stream<List<Area>> watchByServer(int serverId) => Stream.value(const []);

  @override
  Future<List<Area>> getByServer(int serverId) async => const [];

  @override
  Future<Area?> getByHaId({required int serverId, required String haId}) async =>
      null;

  @override
  Future<void> upsert({required int serverId, required Area area}) async {}
}

void main() {
  test('refresh fetches remote areas and syncs repository', () async {
    final repo = _AreaRepository();
    final container = ProviderContainer(
      overrides: [areaRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);

    await container.read(areaRegistrySyncServiceProvider).refresh(
          serverId: 7,
          connection: _Connection(),
        );

    expect(repo.syncedServerId, 7);
    expect(repo.syncedAreas!.single.id, 'office');
    expect(repo.syncedAreas!.single.name, 'Office');
  });
}
```

- [ ] **Step 6: Run test to verify it fails**

Run:

```bash
cd app
flutter test test/features/home/application/area_registry_sync_service_test.dart
```

Expected: compile failure because `area_registry_sync_service.dart` does not exist.

- [ ] **Step 7: Implement refresh service and typed app area repository mapping**

Create `app/lib/features/home/application/area_registry_sync_service.dart`:

```dart
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'area_registry_sync_service.g.dart';

@Riverpod(dependencies: [areaRepository])
AreaRegistrySyncService areaRegistrySyncService(Ref ref) {
  return AreaRegistrySyncService(ref);
}

class AreaRegistrySyncService {
  AreaRegistrySyncService(this._ref);

  final Ref _ref;

  Future<void> refresh({
    required int serverId,
    required IHAConnection connection,
  }) async {
    final api = HomeAssistantApi.fromConnection(connection);
    final areas = await api.areas.list();
    await _ref
        .read(areaRepositoryProvider)
        .syncAll(serverId: serverId, areas: areas.map(_toDomain).toList());
  }

  Area _toDomain(HassArea area) {
    return Area(
      id: area.areaId,
      name: area.name,
      icon: area.icon,
      picture: area.picture,
      aliases: area.aliases,
      labels: area.labels,
    );
  }
}
```

Modify `app/lib/features/areas/infrastructure/repositories/areas_repository.dart` to use typed `api.areas.list()`:

```dart
import 'package:fpdart/fpdart.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/domain/repositories/i_areas_repository.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';

class AreasRepository implements IAreasRepository {
  final IHAConnection _haWebsocketsConnection;

  AreasRepository(this._haWebsocketsConnection);

  @override
  Future<Either<Exception, List<Area>>> getAreas() async {
    try {
      logger.i('Get list of areas');
      final result = await HomeAssistantApi.fromConnection(
        _haWebsocketsConnection,
      ).areas.list();

      return Right(result.map((entry) => entry.toDomain()).toList());
    } catch (e) {
      return Left(Exception(e));
    }
  }
}

extension HassAreaMapper on HassArea {
  Area toDomain() {
    return Area(
      id: areaId,
      name: name,
      icon: icon,
      picture: picture,
      aliases: aliases,
      labels: labels,
    );
  }
}
```

Modify `app/lib/application/session/server_sync_coordinator.dart`:

```dart
import 'package:hommie/features/home/application/area_registry_sync_service.dart';
```

Update provider dependencies:

```dart
@Riverpod(
  keepAlive: true,
  dependencies: [
    ActiveServerSession,
    areaRepository,
    entityRepository,
    areaRegistrySyncService,
  ],
)
```

Replace `_syncAreas` body:

```dart
  Future<void> _syncAreas(
    int serverId,
    IHAConnection connection,
    int revision,
  ) async {
    if (!_isCurrent(serverId, connection, revision)) {
      return;
    }

    await ref.read(areaRegistrySyncServiceProvider).refresh(
          serverId: serverId,
          connection: connection,
        );
  }
```

- [ ] **Step 8: Generate code and run tests**

Run:

```bash
cd app
dart run build_runner build --delete-conflicting-outputs
flutter test test/features/home/application/areas_for_server_provider_test.dart test/features/home/application/area_registry_sync_service_test.dart test/application/session/server_sync_coordinator_test.dart
```

Expected: all listed tests pass.

- [ ] **Step 9: Commit**

```bash
git add app/lib/features/home/application/areas_for_server_provider.dart app/lib/features/home/application/areas_for_server_provider.g.dart app/lib/features/home/application/cached_areas_provider.dart app/lib/features/home/application/cached_areas_provider.g.dart app/lib/features/home/application/area_registry_sync_service.dart app/lib/features/home/application/area_registry_sync_service.g.dart app/lib/features/areas/infrastructure/repositories/areas_repository.dart app/lib/application/session/server_sync_coordinator.dart app/lib/application/session/server_sync_coordinator.g.dart app/test/features/home/application/areas_for_server_provider_test.dart app/test/features/home/application/area_registry_sync_service_test.dart
git commit -m "refactor: share area cache and refresh flow"
```

## Task 3: Settings Area State And Mutation Controller

**Files:**
- Create: `app/lib/features/settings/application/areas_settings_state.dart`
- Create: `app/lib/features/settings/application/active_server_areas_provider.dart`
- Create: `app/lib/features/settings/application/areas_settings_controller.dart`
- Test: `app/test/features/settings/application/active_server_areas_provider_test.dart`
- Test: `app/test/features/settings/application/areas_settings_controller_test.dart`

- [ ] **Step 1: Write failing test for active-session adapter**

Create `app/test/features/settings/application/active_server_areas_provider_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/settings/application/active_server_areas_provider.dart';

class _Connection implements IHAConnection {
  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) => Future.value(null);

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    throw UnimplementedError();
  }
}

class _AreaRepository implements IAreaRepository {
  @override
  Stream<List<Area>> watchByServer(int serverId) {
    return Stream.value([Area(id: 'server-$serverId', name: 'Kitchen')]);
  }

  @override
  Future<List<Area>> getByServer(int serverId) async => const [];

  @override
  Future<Area?> getByHaId({required int serverId, required String haId}) async =>
      null;

  @override
  Future<void> syncAll({
    required int serverId,
    required List<Area> areas,
  }) async {}

  @override
  Future<void> upsert({required int serverId, required Area area}) async {}
}

void main() {
  test('returns cached active-server areas and editable online state', () async {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 5, name: 'Home'),
            connection: _Connection(),
          ),
        ),
        areaRepositoryProvider.overrideWithValue(_AreaRepository()),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(activeServerAreasProvider.future);

    expect(state.canEdit, isTrue);
    expect(state.areas.single.id, 'server-5');
  });

  test('returns cached active-server areas read-only while offline', () async {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const OfflineServerSession(
            activeServer: Server(id: 5, name: 'Home'),
          ),
        ),
        areaRepositoryProvider.overrideWithValue(_AreaRepository()),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(activeServerAreasProvider.future);

    expect(state.canEdit, isFalse);
    expect(state.areas.single.name, 'Kitchen');
  });
}
```

- [ ] **Step 2: Run adapter test to verify it fails**

Run:

```bash
cd app
flutter test test/features/settings/application/active_server_areas_provider_test.dart
```

Expected: compile failure because the provider and state file do not exist.

- [ ] **Step 3: Implement Settings area state and adapter**

Create `app/lib/features/settings/application/areas_settings_state.dart`:

```dart
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
  const AreasSettingsCommandFailure(Object cause)
      : super('Failed to update areas: $cause');
}
```

Create `app/lib/features/settings/application/active_server_areas_provider.dart`:

```dart
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/home/application/areas_for_server_provider.dart';
import 'package:hommie/features/settings/application/areas_settings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_server_areas_provider.g.dart';

@Riverpod(dependencies: [ActiveServerSession, areasForServer])
Future<ActiveServerAreasState> activeServerAreas(Ref ref) async {
  final session = ref.watch(activeServerSessionProvider);
  final server = session.server;
  final serverId = server?.id;
  if (serverId == null) {
    return const ActiveServerAreasState(
      areas: [],
      canEdit: false,
      hasActiveServer: false,
    );
  }

  final areas = await ref.watch(areasForServerProvider(serverId).future);
  return ActiveServerAreasState(
    areas: [...areas]..sort((a, b) => a.name.compareTo(b.name)),
    canEdit: session is OnlineServerSession,
    hasActiveServer: true,
  );
}
```

- [ ] **Step 4: Generate code and run adapter test**

Run:

```bash
cd app
dart run build_runner build --delete-conflicting-outputs
flutter test test/features/settings/application/active_server_areas_provider_test.dart
```

Expected: adapter tests pass.

- [ ] **Step 5: Write failing tests for mutation controller**

Create `app/test/features/settings/application/areas_settings_controller_test.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/settings/application/areas_settings_controller.dart';
import 'package:hommie/features/settings/application/areas_settings_state.dart';

class _Connection implements IHAConnection {
  final sentTypes = <String>[];

  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) {
    final type = (message as HARequestMessage).type;
    sentTypes.add(type);
    if (type == 'config/area_registry/list') {
      return Future.value([
        {
          'created_at': 1.0,
          'modified_at': 1.0,
          'area_id': 'office',
          'name': 'Office',
          'aliases': <String>[],
          'labels': <String>[],
        },
      ]);
    }
    return Future.value({
      'created_at': 1.0,
      'modified_at': 1.0,
      'area_id': 'office',
      'name': 'Office',
      'aliases': <String>[],
      'labels': <String>[],
    });
  }

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    throw UnimplementedError();
  }
}

class _AreaRepository implements IAreaRepository {
  List<Area> synced = const [];

  @override
  Future<void> syncAll({
    required int serverId,
    required List<Area> areas,
  }) async {
    synced = areas;
  }

  @override
  Stream<List<Area>> watchByServer(int serverId) => Stream.value(synced);

  @override
  Future<List<Area>> getByServer(int serverId) async => synced;

  @override
  Future<Area?> getByHaId({required int serverId, required String haId}) async =>
      null;

  @override
  Future<void> upsert({required int serverId, required Area area}) async {}
}

void main() {
  test('create sends command then refreshes cache', () async {
    final connection = _Connection();
    final repo = _AreaRepository();
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: connection,
          ),
        ),
        areaRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(areasSettingsControllerProvider.notifier)
        .create('Office');

    expect(connection.sentTypes, [
      'config/area_registry/create',
      'config/area_registry/list',
    ]);
    expect(repo.synced.single.name, 'Office');
  });

  test('rename sends command then refreshes cache', () async {
    final connection = _Connection();
    final repo = _AreaRepository();
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: connection,
          ),
        ),
        areaRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(areasSettingsControllerProvider.notifier)
        .rename(areaId: 'office', name: 'Work room');

    expect(connection.sentTypes, [
      'config/area_registry/update',
      'config/area_registry/list',
    ]);
  });

  test('delete sends command then refreshes cache', () async {
    final connection = _Connection();
    final repo = _AreaRepository();
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: const Server(id: 1, name: 'Home'),
            connection: connection,
          ),
        ),
        areaRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(areasSettingsControllerProvider.notifier)
        .delete(areaId: 'office');

    expect(connection.sentTypes, [
      'config/area_registry/delete',
      'config/area_registry/list',
    ]);
  });

  test('offline create returns unavailable failure', () async {
    final container = ProviderContainer(
      overrides: [
        activeServerSessionProvider.overrideWithValue(
          const OfflineServerSession(
            activeServer: Server(id: 1, name: 'Home'),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(areasSettingsControllerProvider.notifier).create('Office'),
      throwsA(isA<AreasSettingsUnavailable>()),
    );
  });
}
```

- [ ] **Step 6: Run controller test to verify it fails**

Run:

```bash
cd app
flutter test test/features/settings/application/areas_settings_controller_test.dart
```

Expected: compile failure because `areas_settings_controller.dart` does not exist.

- [ ] **Step 7: Implement mutation controller**

Create `app/lib/features/settings/application/areas_settings_controller.dart`:

```dart
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/home/application/area_registry_sync_service.dart';
import 'package:hommie/features/settings/application/areas_settings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'areas_settings_controller.g.dart';

@Riverpod(
  dependencies: [ActiveServerSession, areaRegistrySyncService],
)
class AreasSettingsController extends _$AreasSettingsController {
  @override
  FutureOr<void> build() {}

  Future<void> create(String name) {
    return _run((api) => api.areas.create(name: name.trim()));
  }

  Future<void> rename({
    required String areaId,
    required String name,
  }) {
    return _run(
      (api) => api.areas.rename(areaId: areaId, name: name.trim()),
    );
  }

  Future<void> delete({required String areaId}) {
    return _run((api) => api.areas.delete(areaId: areaId));
  }

  Future<void> _run(Future<void> Function(HomeAssistantApi api) command) async {
    final session = ref.read(activeServerSessionProvider);
    if (session case OnlineServerSession(:final activeServer, :final connection)
        when activeServer.id != null) {
      state = const AsyncLoading();
      try {
        final api = HomeAssistantApi.fromConnection(connection);
        await command(api);
        await ref.read(areaRegistrySyncServiceProvider).refresh(
              serverId: activeServer.id!,
              connection: connection,
            );
        state = const AsyncData(null);
      } catch (error, stackTrace) {
        final failure = AreasSettingsCommandFailure(error);
        state = AsyncError(failure, stackTrace);
        throw failure;
      }
      return;
    }

    const failure = AreasSettingsUnavailable();
    state = AsyncError(failure, StackTrace.current);
    throw failure;
  }
}
```

- [ ] **Step 8: Generate code and run application tests**

Run:

```bash
cd app
dart run build_runner build --delete-conflicting-outputs
flutter test test/features/settings/application/active_server_areas_provider_test.dart test/features/settings/application/areas_settings_controller_test.dart
```

Expected: all listed tests pass.

- [ ] **Step 9: Commit**

```bash
git add app/lib/features/settings/application/areas_settings_state.dart app/lib/features/settings/application/active_server_areas_provider.dart app/lib/features/settings/application/active_server_areas_provider.g.dart app/lib/features/settings/application/areas_settings_controller.dart app/lib/features/settings/application/areas_settings_controller.g.dart app/test/features/settings/application/active_server_areas_provider_test.dart app/test/features/settings/application/areas_settings_controller_test.dart
git commit -m "feat: add area settings application flow"
```

## Task 4: Settings Areas UI And Route

**Files:**
- Create: `app/lib/features/settings/presentation/screens/areas_page.dart`
- Modify: `app/lib/features/settings/presentation/screens/settings_page.dart`
- Modify: `app/lib/router/routes.dart`
- Test: `app/test/features/settings/presentation/settings_page_test.dart`
- Test: `app/test/features/settings/presentation/areas_page_test.dart`

- [ ] **Step 1: Add failing Settings row test**

In `app/test/features/settings/presentation/settings_page_test.dart`, add:

```dart
  testWidgets('shows areas settings row without subtitle', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          serverLifecycleControllerProvider.overrideWith(
            _FakeServerLifecycleController.new,
          ),
        ],
        child: const MaterialApp(home: SettingsPage()),
      ),
    );

    expect(find.text('Areas'), findsOneWidget);
    expect(
      find.text('Create, rename, and delete Home Assistant areas'),
      findsNothing,
    );
  });
```

Before adding this test, read `app/test/features/settings/presentation/settings_page_test.dart` and reuse its existing `ProviderScope` overrides. Add only the two expectations shown in this step to the existing Settings page test group.

- [ ] **Step 2: Run Settings row test to verify it fails**

Run:

```bash
cd app
flutter test test/features/settings/presentation/settings_page_test.dart
```

Expected: test fails because no `Areas` row exists.

- [ ] **Step 3: Add Settings row and route skeleton**

Modify `app/lib/features/settings/presentation/screens/settings_page.dart` by adding this tile after `Servers` or before `Sensors`:

```dart
          const Divider(),
          ListTile(
            leading: const Icon(Symbols.home_work_rounded),
            title: const Text('Areas'),
            trailing: const Icon(Symbols.chevron_right_rounded),
            onTap: () => const AreasRouteData().push(context),
          ),
```

Modify `app/lib/router/routes.dart` imports:

```dart
import 'package:hommie/features/settings/presentation/screens/areas_page.dart';
```

Add route under Settings routes:

```dart
    TypedGoRoute<AreasRouteData>(path: 'areas'),
```

Add route class:

```dart
class AreasRouteData extends GoRouteData with $AreasRouteData {
  const AreasRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AreasPage();
  }
}
```

Create temporary skeleton `app/lib/features/settings/presentation/screens/areas_page.dart`:

```dart
import 'package:flutter/material.dart';

class AreasPage extends StatelessWidget {
  const AreasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(title: Text('Areas')),
      body: SizedBox.shrink(),
    );
  }
}
```

- [ ] **Step 4: Generate routes and run Settings test**

Run:

```bash
cd app
dart run build_runner build --delete-conflicting-outputs
flutter test test/features/settings/presentation/settings_page_test.dart
```

Expected: Settings row test passes.

- [ ] **Step 5: Write failing Areas page tests**

Create `app/test/features/settings/presentation/areas_page_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/settings/application/active_server_areas_provider.dart';
import 'package:hommie/features/settings/application/areas_settings_controller.dart';
import 'package:hommie/features/settings/application/areas_settings_state.dart';
import 'package:hommie/features/settings/presentation/screens/areas_page.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class _NoopAreasController extends AreasSettingsController {
  @override
  FutureOr<void> build() {}
}

void main() {
  testWidgets('lists cached areas sorted by name', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeServerAreasProvider.overrideWith(
            (ref) async => const ActiveServerAreasState(
              areas: [
                Area(id: 'office', name: 'Office'),
                Area(id: 'kitchen', name: 'Kitchen'),
              ],
              canEdit: true,
              hasActiveServer: true,
            ),
          ),
          areasSettingsControllerProvider.overrideWith(
            _NoopAreasController.new,
          ),
        ],
        child: const MaterialApp(home: AreasPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Areas'), findsOneWidget);
    expect(find.text('Kitchen'), findsOneWidget);
    expect(find.text('Office'), findsOneWidget);
    expect(find.byIcon(Symbols.add_rounded), findsOneWidget);
  });

  testWidgets('renders cached areas read-only while offline', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeServerAreasProvider.overrideWith(
            (ref) async => const ActiveServerAreasState(
              areas: [Area(id: 'kitchen', name: 'Kitchen')],
              canEdit: false,
              hasActiveServer: true,
            ),
          ),
          areasSettingsControllerProvider.overrideWith(
            _NoopAreasController.new,
          ),
        ],
        child: const MaterialApp(home: AreasPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Kitchen'), findsOneWidget);
    expect(find.text('Connect to Home Assistant to edit areas'), findsOneWidget);
    expect(
      tester.widget<IconButton>(find.byIcon(Symbols.add_rounded)).onPressed,
      isNull,
    );
  });

  testWidgets('delete confirmation explains entities are not deleted', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeServerAreasProvider.overrideWith(
            (ref) async => const ActiveServerAreasState(
              areas: [Area(id: 'kitchen', name: 'Kitchen')],
              canEdit: true,
              hasActiveServer: true,
            ),
          ),
          areasSettingsControllerProvider.overrideWith(
            _NoopAreasController.new,
          ),
        ],
        child: const MaterialApp(home: AreasPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Symbols.more_vert_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(
      find.text('Delete area "Kitchen"? Devices and entities will not be deleted.'),
      findsOneWidget,
    );
  });
}
```

- [ ] **Step 6: Run Areas page tests to verify they fail**

Run:

```bash
cd app
flutter test test/features/settings/presentation/areas_page_test.dart
```

Expected: tests fail because `AreasPage` is only a skeleton.

- [ ] **Step 7: Implement Areas page**

Replace `app/lib/features/settings/presentation/screens/areas_page.dart` with:

```dart
import 'package:flutter/material.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/features/settings/application/active_server_areas_provider.dart';
import 'package:hommie/features/settings/application/areas_settings_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class AreasPage extends ConsumerWidget {
  const AreasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(activeServerAreasProvider);
    final controller = ref.watch(areasSettingsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Areas'),
        actions: [
          IconButton(
            icon: const Icon(Symbols.add_rounded),
            onPressed: state.valueOrNull?.canEdit == true && !controller.isLoading
                ? () => _showNameDialog(context, ref, title: 'Add area')
                : null,
          ),
        ],
      ),
      body: switch (state) {
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncError(:final error) => Center(child: Text('$error')),
        AsyncData(:final value) => _AreasList(state: value),
      },
    );
  }

  Future<void> _showNameDialog(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    Area? area,
  }) async {
    final textController = TextEditingController(text: area?.name ?? '');
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => _AreaNameDialog(
        title: title,
        controller: textController,
        originalName: area?.name,
        onSave: (name) async {
          if (area == null) {
            await ref.read(areasSettingsControllerProvider.notifier).create(name);
          } else {
            await ref
                .read(areasSettingsControllerProvider.notifier)
                .rename(areaId: area.id, name: name);
          }
        },
      ),
    );
  }
}

class _AreasList extends ConsumerWidget {
  const _AreasList({required this.state});

  final ActiveServerAreasState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!state.hasActiveServer) {
      return const Center(child: Text('No active server'));
    }

    if (state.areas.isEmpty) {
      return const Center(child: Text('No areas yet'));
    }

    return ListView(
      children: [
        if (!state.canEdit)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Connect to Home Assistant to edit areas'),
          ),
        for (final area in state.areas)
          ListTile(
            title: Text(area.name),
            trailing: PopupMenuButton<_AreaAction>(
              enabled: state.canEdit,
              icon: const Icon(Symbols.more_vert_rounded),
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: _AreaAction.rename,
                  child: Text('Rename'),
                ),
                PopupMenuItem(
                  value: _AreaAction.delete,
                  child: Text('Delete'),
                ),
              ],
              onSelected: (action) async {
                switch (action) {
                  case _AreaAction.rename:
                    await AreasPage()._showNameDialog(
                      context,
                      ref,
                      title: 'Rename area',
                      area: area,
                    );
                  case _AreaAction.delete:
                    await _confirmDelete(context, ref, area);
                }
              },
            ),
          ),
      ],
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Area area,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete area'),
        content: Text(
          'Delete area "${area.name}"? Devices and entities will not be deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(areasSettingsControllerProvider.notifier)
          .delete(areaId: area.id);
    }
  }
}

enum _AreaAction { rename, delete }

class _AreaNameDialog extends StatefulWidget {
  const _AreaNameDialog({
    required this.title,
    required this.controller,
    required this.onSave,
    this.originalName,
  });

  final String title;
  final TextEditingController controller;
  final String? originalName;
  final Future<void> Function(String name) onSave;

  @override
  State<_AreaNameDialog> createState() => _AreaNameDialogState();
}

class _AreaNameDialogState extends State<_AreaNameDialog> {
  bool _saving = false;
  String? _error;

  bool get _canSave {
    final value = widget.controller.text.trim();
    return value.isNotEmpty && value != widget.originalName?.trim() && !_saving;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: widget.controller,
        autofocus: true,
        decoration: InputDecoration(
          labelText: 'Name',
          errorText: _error,
        ),
        onChanged: (_) => setState(() {}),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _canSave ? _save : null,
          child: _saving
              ? const SizedBox.square(
                  dimension: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.onSave(widget.controller.text.trim());
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = '$error';
        });
      }
    }
  }
}
```

- [ ] **Step 8: Run UI tests**

Run:

```bash
cd app
flutter test test/features/settings/presentation/settings_page_test.dart test/features/settings/presentation/areas_page_test.dart
```

Expected: tests pass.

- [ ] **Step 9: Generate routes and run route-sensitive tests**

Run:

```bash
cd app
dart run build_runner build --delete-conflicting-outputs
flutter test test/features/settings/presentation/settings_page_test.dart test/features/settings/presentation/areas_page_test.dart
```

Expected: tests pass and `app/lib/router/routes.g.dart` includes `AreasRouteData`.

- [ ] **Step 10: Commit**

```bash
git add app/lib/features/settings/presentation/screens/areas_page.dart app/lib/features/settings/presentation/screens/settings_page.dart app/lib/router/routes.dart app/lib/router/routes.g.dart app/test/features/settings/presentation/settings_page_test.dart app/test/features/settings/presentation/areas_page_test.dart
git commit -m "feat: add settings areas page"
```

## Task 5: Final Verification And Cleanup

**Files:**
- Review generated files changed by Tasks 1-4.
- Review `.superpowers/` stays untracked.

- [ ] **Step 1: Run package tests**

Run:

```bash
cd packages/home_assistant_client
dart test
```

Expected: all package tests pass.

- [ ] **Step 2: Run app targeted tests**

Run:

```bash
cd app
flutter test test/features/home/application/areas_for_server_provider_test.dart test/features/home/application/area_registry_sync_service_test.dart test/features/settings/application/active_server_areas_provider_test.dart test/features/settings/application/areas_settings_controller_test.dart test/features/settings/presentation/settings_page_test.dart test/features/settings/presentation/areas_page_test.dart test/application/session/server_sync_coordinator_test.dart
```

Expected: all targeted app tests pass.

- [ ] **Step 3: Run app analyzer**

Run:

```bash
cd app
flutter analyze
```

Expected: `No issues found!`

- [ ] **Step 4: Run package analyzer**

Run:

```bash
cd packages/home_assistant_client
dart analyze
```

Expected: no issues.

- [ ] **Step 5: Review scope guardrails**

Run:

```bash
rg "serverScopeConnectionProvider|serverScopeIdProvider|serverScopeServerProvider" app/lib/features/settings app/test/features/settings
```

Expected: no matches. Settings area management must use `activeServerSessionProvider`, not `serverScope*`.

Run:

```bash
rg "config/area_registry" app/lib packages/home_assistant_client/lib
```

Expected: app uses typed `api.areas` through repositories/services; raw `config/area_registry/*` message strings should live in `home_assistant_client` typed API tests/implementation, not ordinary Settings UI code.

- [ ] **Step 6: Check git status**

Run:

```bash
git status --short
```

Expected: only intended implementation files are modified or staged. `.superpowers/` may be untracked from brainstorming and should remain unstaged.

- [ ] **Step 7: Leave the tree clean**

Run:

```bash
git status --short
```

Expected: no tracked implementation files remain modified. `.superpowers/` may remain untracked from brainstorming and should not be staged.
