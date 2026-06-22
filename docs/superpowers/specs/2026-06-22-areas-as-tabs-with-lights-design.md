# Areas-as-tabs with lights (v1) — Design

Date: 2026-06-22
Branch: `areas`
Status: Draft for review

## Problem

The Home screen shows **"No home view configured"** instead of areas. Root cause:
the screen body renders from `HomePageState.homeView` (`HomeViewConf`), and
`homeView` is **always null** because `DriftHomeViewRepository.save()` is never
called anywhere — `get()` returns null, so `_buildHomeViewSlivers`
(`home_page.dart`) short-circuits to the placeholder. Separately, no device/entity
data is ever synced from Home Assistant, so even a populated home view would have
nothing to show.

The area *registry* already syncs into Drift (`AreaRegistrySyncController`), but the
screen never uses it for content — only, conditionally, for tab labels.

## Goal & scope (v1)

- Render each HA **area** as a tab.
- Inside an area tab: that area's **lights** (`light.*` entities) as on/off cards
  with a working toggle.
- A **Summary** tab: all areas stacked (each a `RoomGroup` header + its light grid),
  followed by a trailing group of lights that have no area.
- Cache lights in Drift for an offline list; overlay live on/off state.

### Out of scope (later)

- Brightness/color and non-light domains.
- The full device ↔ entity hierarchy (richer per-device widgets).
- User customization: reorder, tile sizes, edit mode, hiding/reassigning lights.
  The `homeView*` tables and repository remain in place, untouched, for this future
  feature.

## Evaluation of the existing cache approach

The current pattern — persist the HA registry in Drift and keep it live via a
registry-updated subscription — is sound and worth extending. Issues found and
addressed by this design:

1. **Tabs built two ways.** `HomePageController.build()` does a one-shot
   `getByServer()` *and* a `ref.listen(cachedAreasProvider, _refreshFromAreas)`. Two
   paths that must agree. → Derive tabs from a single stream source.
2. **Sync errors vanish silently.** `AreaRegistrySyncController._sync()` swallows
   `getAreas()` failures. A failed first sync produces an empty screen with no signal.
   → Surface a sync status.
3. **Empty vs. not-yet-synced is indistinguishable.** → Distinguish loading from
   synced-but-empty in the UI.
4. **Render coupled to the never-populated `homeView`.** → Decouple; render from
   cached areas + cached lights + live state.
5. **`server.id!` null-assert** (`home_page_controller.dart`) can crash. → Handle
   gracefully.
6. **State subscription can outlive its connection** on reconnect. → Live-state
   provider depends on the scoped connection and re-subscribes when it changes.

## Architecture & data flow

```
HA WS ─┬─ area_registry ──► AreaRegistrySyncController ──► areaEntities (Drift)        [EXISTS]
       ├─ entity + device registry ──► LightsSyncController ──► deviceEntities +        [NEW]
       │                                                        deviceAreaConfigs (Drift)
       └─ subscribeEntities ──► lightStatesProvider (in-memory Map<entityId,bool>)      [NEW]

areaEntities (watch) ───────────────► tabs
deviceEntities ⋈ deviceAreaConfigs (watch) + lightStates ─► per-area light VMs ─► HomePage
card toggle ─► LightToggleController ─► callService(light.toggle)                       [NEW]
```

Rendering is driven by **Drift watches + the live state map**, never by `homeView`.

## Persistence (reuse existing tables — no migration)

`DeviceEntities` is already entity-level (`haId = "light.living_room_lamp"`,
`type = "light"`, `serverId`); `DeviceAreaConfigs` already maps device↔area.

- One `deviceEntities` row per light; one `deviceAreaConfigs` row mapping it to its
  resolved area (lights with no area get no mapping row).
- Extend `IDeviceRepository` + `DriftDeviceRepository`:
  - `Future<void> syncAll({required int serverId, required List<Device> lights})` —
    transactional diff (delete removed, upsert current, maintain area mapping),
    mirroring `DriftAreaRepository.syncAll`.
  - `Stream<List<Device>> watchByServer(int serverId)` (and/or `watchByArea`) for
    reactive rendering.
- Live on/off state is **not** persisted (volatile).

## Lights sync — `LightsSyncController` (new)

Mirrors `AreaRegistrySyncController`:

- Gated on `serverConnectionStateProvider == HAServerConnectionState.connected`.
- Subscribes to **`entity_registry_updated`** and **`device_registry_updated`**
  (either triggers a re-sync); runs an initial sync on first connect; stops on
  disconnect.
- Sync logic:
  1. Fetch entity registry list + device registry list (two new request messages +
     repository methods in infrastructure, paralleling `AreasMessage` /
     `AreasRepository`).
  2. Keep `light.*` entities.
  3. Resolve area: `entity.areaId ?? device(entity.deviceId).areaId`.
  4. Build `Device` list (id = entity_id, name = entity name → originalName →
     friendly name fallback, type = "light", areaId = resolved or empty).
  5. `deviceRepository.syncAll(serverId, lights)`.
- Surfaces failures via a sync-status value (not silently swallowed).

## Live state & toggle

- `lightStatesProvider` — server-scoped (depends on `serverScopeConnection`):
  `HACommands.subscribeEntities`, exposes `Map<entityId, bool isOn>` where
  `isOn = state == 'on'`. Re-subscribes when the scoped connection changes.
- `LightToggleController` — `HACommands.callService(domain:'light',
  service:'toggle', target:{entity_id})`; optimistic flip with revert on failure;
  truth reconciled from the subscription.
- `DeviceWidget` receives real `isOn` + `onChanged` (currently hardcoded
  `value: true` with empty callbacks). When state is unknown/offline → "unavailable",
  toggle disabled.

## Rendering changes

- `HomePageController`:
  - Derive `tabs` from a single source — `watch(cachedAreasProvider)` — dropping the
    dual one-shot read + listener.
  - Expose per-area light view models from the device watch + the live state map.
  - Remove the `server.id!` crash (handle missing id gracefully).
- `home_page.dart`:
  - Delete the `homeView == null → "No home view configured"` branch.
  - **Summary tab**: every cached area as `RoomGroup` + its light grid (empty areas
    show a "No lights here yet" empty state), then a trailing group of area-less
    lights.
  - **Area tab**: that area's lights (or empty state).
  - Loading (first sync in progress) → spinner; synced-but-empty → friendly empty
    state.

## Edge cases

- **Light with no area** → not in any area tab; appears in Summary's trailing group.
- **Area with no lights** → tab shown with empty state.
- **Offline** → cached lights still list; state map empty → cards "unavailable",
  toggles disabled; tabs still render from the area cache.
- **Reconnect / new connection object** → state provider re-subscribes; sync re-runs
  on reconnect.
- **First-ever launch, never synced** → loading state until first sync completes;
  then areas/empty as appropriate.
- **Sync failure** → surfaced via sync status; retried on next registry event /
  reconnect.

## Testing

- `DriftDeviceRepository.syncAll`: add / remove / rename diff against in-memory Drift;
  area mapping created/removed correctly.
- Area resolution: `entity.areaId` wins over device; device fallback; no-area case.
- `LightsSyncController`: sync-on-connect, stop-on-disconnect, re-sync on registry
  event.
- `LightToggleController`: optimistic update + revert on service-call failure.
- Widget: tabs render from cached areas; lights render per area; empty-area empty
  state; Summary shows area-less lights; toggle invokes the service.

## Phasing (for the implementation plan)

1. Repository + persistence: `IDeviceRepository.syncAll` + `watch*`,
   `DriftDeviceRepository` impl, tests.
2. Registry fetch: entity + device registry messages/repositories; area resolution.
3. `LightsSyncController` (+ sync status), wired into the Home screen like the area
   sync controller.
4. `lightStatesProvider` + `LightToggleController`.
5. Rendering: `HomePageController` rework (single-source tabs + light VMs),
   `home_page.dart` decoupled from `homeView`, real `DeviceWidget` state/toggle.
6. Edge-case polish: loading/empty/offline/unavailable states.
