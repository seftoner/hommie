# Areas-as-tabs with a generic entity foundation (lights first) — Design

Date: 2026-06-22
Branch: `areas`
Status: Draft for review

## Problem

The Home screen shows **"No home view configured"** instead of areas. Root cause:
the screen body renders from `HomePageState.homeView` (`HomeViewConf`), and
`homeView` is **always null** because `DriftHomeViewRepository.save()` is never
called — `get()` returns null, so `_buildHomeViewSlivers` (`home_page.dart`)
short-circuits to the placeholder. Separately, no entity/device data is ever synced
from Home Assistant, so even a populated home view would have nothing to show.

The area *registry* already syncs into Drift (`AreaRegistrySyncController`), but the
screen never uses it for content.

## Goal

Build a **generic, domain-agnostic entity foundation** so the app can support many
device types and entity operations over time, and render the first concrete domain —
**lights** — on top of it:

- Each HA **area** is a tab.
- Inside a tab: the area's entities, rendered by per-domain widgets. **v1 registers
  one domain handler: `light`** (on/off card + toggle). Other domains are cached but
  not yet rendered.
- A **Summary** tab: all areas stacked (each a `RoomGroup` header + its entities),
  followed by a trailing group of entities that have no area.

The design principle: **adding a new device type later = register a domain handler +
a widget.** Sync, state, area-grouping, and the operation path never change again.

### Out of scope (later)

- Domains beyond `light` (switch, cover, climate, …) — just unregistered handlers.
- The physical **device** layer (a `devices` table + device-grouping above entities).
  We cache each entity's `deviceId` now so this slots in cleanly later.
- User customization: reorder, tile sizes, edit mode, hiding/reassigning. The
  `homeView*` and `DeviceEntities` tables stay in place, dormant, for this future work.

## Evaluation of the existing cache approach

Persisting the HA registry in Drift and keeping it live via a registry-updated
subscription is sound and worth generalizing. Issues found and addressed here:

1. **Tabs built two ways** in `HomePageController.build()` (one-shot `getByServer()`
   + a `ref.listen`). → Derive tabs from a single stream source.
2. **Sync errors vanish silently** (`AreaRegistrySyncController._sync()` swallows
   failures), producing an empty screen with no signal. → Surface a sync status.
3. **Empty vs. not-yet-synced is indistinguishable.** → Distinguish loading from
   synced-but-empty.
4. **Render coupled to the never-populated `homeView`.** → Decouple; render from
   cached areas + cached entities + live state.
5. **`server.id!` null-assert** can crash. → Handle gracefully.
6. **State subscription can outlive its connection** on reconnect. → State provider
   depends on the scoped connection and re-subscribes when it changes.

## Architecture — generic entity layer

```
HA WS ─┬─ area_registry ────────────► AreaRegistrySyncController ──► areaEntities (Drift)   [EXISTS]
       ├─ entity + device registry ─► EntityRegistrySyncController ──► entities (Drift)      [NEW]
       └─ subscribeEntities ────────► entityStatesProvider                                   [NEW]
                                       (in-memory Map<entityId, EntityState>)

areaEntities (watch) ──────────────────────────────► tabs
entities (watch) grouped by area + entityStates ───► per-area entity VMs ─► HomePage
   each entity rendered via EntityDomainHandler for its domain (v1: light only)
card operation ─► EntityServiceController.call(entityId, service, data) ─► callService(...)   [NEW]
```

Five generic pieces; `light` is the only concrete plug-in in v1.

### 1. Entity registry cache (generic) — `EntityRegistrySyncController`

Mirrors `AreaRegistrySyncController`; domain-agnostic.

- Gated on `serverConnectionStateProvider == connected`; subscribes to
  **`entity_registry_updated`** and **`device_registry_updated`** (either triggers a
  re-sync); initial sync on connect; stops on disconnect; surfaces a sync status
  (no silent swallow).
- Sync logic:
  1. Fetch entity registry list + device registry list (new request messages +
     repository, paralleling `AreasMessage` / `AreasRepository`).
  2. Keep **all non-disabled, non-hidden** entities (every domain).
  3. Resolve `area = entity.areaId ?? device(entity.deviceId).areaId`.
  4. Map to `HaEntity { entityId, domain, name, deviceId?, areaHaId? }`
     (`domain` = entity_id prefix; `name` = entity name → originalName → friendly).
  5. `entityRepository.syncAll(serverId, entities)` (transactional diff:
     delete removed, upsert current).

### 2. Entity state store (generic) — `entityStatesProvider`

Server-scoped (depends on `serverScopeConnection`). `HACommands.subscribeEntities`
→ `Map<entityId, EntityState { state, attributes }>`. Re-subscribes when the scoped
connection changes. Live-only; not persisted.

### 3. Entity operations (generic) — `EntityServiceController`

`call(entityId, service, [data])` → `HACommands.callService(domain, service,
target: entityId, serviceData: data)`. One path for every present and future
operation. Optimistic where it makes sense (e.g. light toggle), reconciled by the
state subscription.

### 4. Domain capability registry (extensibility seam)

`Map<String domain, EntityDomainHandler>` exposed via a provider.

```
abstract class EntityDomainHandler {
  String get domain;                       // e.g. 'light'
  Widget buildCard(HaEntity e, EntityState? s);  // delegates ops to EntityServiceController
}
```

v1 registers only `LightDomainHandler` (`isOn = state == 'on'`; toggle →
`EntityServiceController.call(e.entityId, 'toggle')`) rendering a `LightCard`.
Adding a domain later = a new handler + widget; nothing else changes.

### 5. Rendering (generic)

- `HomePageController`: derive `tabs` from a single source — `watch(cachedAreas…)` —
  and expose entities grouped by area (entity watch + state map). Remove the
  `server.id!` crash.
- `home_page.dart`: delete the `homeView == null → "No home view configured"`
  branch. For each area: `RoomGroup` + a grid of its entities, where each entity is
  rendered by its domain handler. **Entities whose domain has no registered handler
  are skipped** (v1 → only lights appear). Empty areas show "No devices here yet".
  Summary lists all areas + a trailing group of area-less entities. Loading → spinner;
  synced-but-empty → friendly empty state.

## Persistence — new generic `entities` table (no migration; app not in production)

```
Entities:
  id        int autoIncrement PK
  serverId  int  → ServerEntities(id) cascade
  entityId  text                     // HA entity_id, e.g. "light.kitchen"
  name      text
  domain    text                     // "light", "switch", …
  deviceId  text nullable            // HA device id (for the future device layer)
  areaHaId  text nullable            // resolved area haId (denormalized; robust to area re-sync)
  entityCategory text nullable       // for future render filtering
  unique(serverId, entityId)
```

`areaHaId` is denormalized (matched against `areaEntities.haId`) so an area re-sync
that deletes/recreates rows can't cascade-delete entities. New repository
`IEntityRepository` + `DriftEntityRepository`:

- `Future<void> syncAll({required int serverId, required List<HaEntity> entities})`
  — transactional diff, mirroring `DriftAreaRepository.syncAll`.
- `Stream<List<HaEntity>> watchByServer(int serverId)` for reactive rendering.

The existing `DeviceEntities`/`DeviceAreaConfigs`/`homeView*` tables are left dormant
for the future device + customization features.

## Edge cases

- **Entity with an unregistered domain** → cached, not rendered in v1.
- **Entity with no area** → not in any area tab; appears in Summary's trailing group.
- **Area with no (renderable) entities** → tab shown with empty state.
- **Offline** → cached entity list still shows; state map empty → cards "unavailable",
  operations disabled; tabs still render from the area cache.
- **Reconnect / new connection object** → state provider re-subscribes; sync re-runs.
- **First-ever launch** → loading until first sync completes.
- **Sync failure** → surfaced via sync status; retried on next registry event / reconnect.

## Testing

- `DriftEntityRepository.syncAll`: add / remove / rename diff against in-memory Drift.
- Area resolution: `entity.areaId` wins over device; device fallback; no-area case.
- `EntityRegistrySyncController`: sync-on-connect, stop-on-disconnect, re-sync on event;
  disabled/hidden excluded.
- `EntityServiceController`: builds correct `callService` args; light toggle optimistic
  update + revert on failure.
- Domain registry: light handler resolves; unknown domain skipped.
- Widget: tabs from cached areas; lights render per area; empty-area empty state;
  Summary shows area-less entities; toggle invokes the service.

## Phasing (for the implementation plan)

1. Domain + persistence: `HaEntity`/`EntityState`, `entities` Drift table,
   `IEntityRepository` + `DriftEntityRepository` (`syncAll`, `watchByServer`) + tests.
2. Registry fetch: entity + device registry messages/repositories; area resolution.
3. `EntityRegistrySyncController` (+ sync status), wired into Home like the area sync.
4. `entityStatesProvider` + `EntityServiceController` (generic state + operations).
5. Domain handler registry + `LightDomainHandler`/`LightCard`.
6. Rendering: `HomePageController` rework (single-source tabs + entity-by-area VMs),
   `home_page.dart` decoupled from `homeView`, entities rendered via handlers.
7. Edge-case polish: loading/empty/offline/unavailable states.
