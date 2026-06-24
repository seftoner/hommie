# Area Management Design

Date: 2026-06-24

## Context

Hommie already syncs Home Assistant areas into the local Drift cache. On an
online session, `ServerSyncCoordinator` fetches `config/area_registry/list`,
writes the result through `areaRepository.syncAll`, and subscribes to
`area_registry_updated` so future remote changes refresh the cache. The Home
screen reads areas from that cache through the scoped `cachedAreasProvider`.

This feature adds Settings-based area management: create, rename, and delete
Home Assistant areas. The first version is name-only. It will not expose icon,
picture, aliases, labels, floors, or linked temperature/humidity entities.

## Product Decisions

- Area management lives under Settings, not directly on the Home tab.
- The Settings row is titled `Areas` and has no subtitle.
- The Areas page uses a dedicated page with an add action and per-row overflow
  actions.
- Offline or unavailable sessions show cached areas read-only.
- Deleting an area uses a simple confirmation and explains that devices and
  entities are not deleted.
- Home Assistant remains the source of truth. Hommie does not optimistically
  mutate Drift before a remote command succeeds.

## Architecture

### Typed Home Assistant Client

Add a typed areas resource to `packages/home_assistant_client`:

```dart
api.areas.list();
api.areas.create(name: name);
api.areas.rename(areaId: areaId, name: name);
api.areas.delete(areaId: areaId);
```

The resource sends WebSocket messages:

- `config/area_registry/list`
- `config/area_registry/create`
- `config/area_registry/update`
- `config/area_registry/delete`

It parses Home Assistant area registry entries into exported typed models. App
code should stop defining raw area registry list messages once this resource is
available.

### Shared Area Application Layer

Avoid duplicating Home-scoped and Settings-scoped area logic by separating
server-specific primitives from the source of server context.

Add an explicit-server cache provider:

```dart
areasForServerProvider(int serverId)
```

This watches `areaRepository.watchByServer(serverId)`. It does not depend on
`serverScope*` providers or `activeServerSessionProvider`.

Add a shared refresh service:

```dart
areaRegistrySyncService.refresh({
  required int serverId,
  required IHAConnection connection,
});
```

The service calls `HomeAssistantApi.fromConnection(connection).areas.list()`
and writes the result through `areaRepository.syncAll`. It is used by both
`ServerSyncCoordinator` and the Settings mutation controller after successful
create, rename, or delete commands.

Keep Home as a thin scoped adapter:

```dart
cachedAreasProvider
```

It reads `serverScopeIdProvider` and delegates to `areasForServerProvider`.
This preserves the current Home route scope and avoids changing
`ServerScopeHost`.

Add a Settings-specific active-session adapter:

```dart
activeServerAreasProvider
```

It reads `activeServerSessionProvider`. When an active server id exists, it
watches `areasForServerProvider(serverId)` and exposes whether editing is
enabled. Editing is enabled only for `OnlineServerSession`.

Add a Settings mutation controller:

```dart
areasSettingsControllerProvider
```

The controller reads `activeServerSessionProvider`. For online sessions it
calls the typed `api.areas.create`, `api.areas.rename`, or `api.areas.delete`,
then invokes `areaRegistrySyncService.refresh`. For offline, connecting,
revoked, or missing sessions it returns a typed unavailable failure.

## UI Design

### Settings

Add a `ListTile` to Settings:

- Leading icon: area or room-style Material symbol if available.
- Title: `Areas`.
- No subtitle.
- Trailing chevron.
- Tap opens `/settings/areas`.

### Areas Page

The Areas page:

- App bar title: `Areas`.
- App bar add action.
- Body lists cached areas sorted by name.
- Each row shows the area name and a trailing overflow menu.
- Overflow menu actions: `Rename`, `Delete`.
- Empty state: `No areas yet`, with add available only when online.
- Offline/unavailable state: cached list remains visible, but add and row
  menus are disabled. Show a short message that connecting to Home Assistant is
  required to edit areas.

Create flow:

1. User taps add.
2. Dialog opens with one text field for area name.
3. Save is disabled for blank or whitespace-only names.
4. On save, the controller creates the area remotely, refreshes the cache, and
   closes the dialog.
5. If the command fails, keep the dialog open and show an error.

Rename flow:

1. User opens row overflow and taps Rename.
2. Dialog opens with the current name prefilled.
3. Save is disabled when the name is blank or unchanged.
4. On save, the controller renames the area remotely, refreshes the cache, and
   closes the dialog.
5. If the command fails, keep the dialog open and show an error.

Delete flow:

1. User opens row overflow and taps Delete.
2. Confirmation text: `Delete area "Kitchen"? Devices and entities will not be
   deleted.`
3. On confirmation, the controller deletes the area remotely and refreshes the
   cache.
4. If the command fails, keep the current cache and show an error.

## Error Handling

- Offline, connecting, revoked, and no-connection states disable all edit
  actions.
- If an unavailable action is somehow invoked, return a typed unavailable
  failure rather than throwing raw provider errors.
- Home Assistant command failures do not update Drift. The user sees the error
  and can retry.
- If a command succeeds but the follow-up refresh fails, show a message that the
  area changed in Home Assistant but Hommie could not refresh yet. The existing
  area registry subscription or the next sync will update the cache.
- Delete does not block non-empty areas in v1.

## Testing

### `home_assistant_client`

- `api.areas.list` sends `config/area_registry/list` and parses typed area
  entries.
- `api.areas.create` sends `config/area_registry/create` with the name.
- `api.areas.rename` sends `config/area_registry/update` with `area_id` and
  name.
- `api.areas.delete` sends `config/area_registry/delete` with `area_id`.
- Calls fail through the existing WebSocket unavailable transport behavior when
  constructed without a WebSocket connection.

### App Application Layer

- `areasForServerProvider` watches by explicit server id.
- Home `cachedAreasProvider` delegates through `areasForServerProvider`.
- `activeServerAreasProvider` returns cached areas and editability from the
  active session.
- `areaRegistrySyncService.refresh` calls typed areas list and writes
  `areaRepository.syncAll`.
- `areasSettingsController` calls typed create, rename, and delete commands,
  then refreshes.
- Offline mutation attempts return unavailable failure.

### UI

- Settings page includes an `Areas` row with no subtitle.
- Areas page lists cached areas sorted by name.
- Add and rename dialogs validate blank names.
- Rename save is disabled for unchanged names.
- Offline Areas page renders cached areas read-only.
- Delete confirmation states that devices and entities are not deleted.

## Out Of Scope

- Editing icon, picture, aliases, labels, floors, or linked environmental
  entities.
- Moving devices/entities between areas.
- Optimistic local area mutation.
- Changing the `ServerScopeHost` boundary.
- Adding a Home-tab shortcut to area management.
- Full localization wiring; copy should still be kept centralized enough to
  move to generated localization strings later.
