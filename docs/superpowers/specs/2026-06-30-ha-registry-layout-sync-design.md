# Home Assistant device-first registry layout sync - Design

Date: 2026-06-30
Branch: `main`
Status: Draft for review

## Problem

Hommie is an unofficial mobile client for Home Assistant, not a Lovelace wrapper.
It needs to render cached home structure while offline, but still respect Home
Assistant as the source of truth for areas and device/entity membership.

The fragile part is identity and presentation. `entity_id` values such as
`light.kitchen_bulb` are useful command addresses, but they can change when
users rename entities in Home Assistant. A Hommie layout that binds tiles
directly to `entity_id` would break or lose user customization when registry
data changes.

The user-facing model should also not expose every Home Assistant entity as an
equal top-level tile. A physical device often has many entities: one control,
several sensors, diagnostic entities, and configuration entities. Google Home
and Apple Home-style clients present the device first, then expose secondary
entities in details. Hommie should use that shape while keeping an escape hatch
for Home Assistant's flexible entity model.

## Goal

Use Home Assistant registries as the source of truth for home structure while
keeping Hommie-specific presentation settings local. The main home view is
device-first:

- a normal tile represents a Home Assistant device;
- the tile's primary control is computed from the device's entities;
- secondary entities live in details or compact metadata;
- standalone entity tiles exist for device-less things such as scenes, scripts,
  helpers, groups, and other useful entities without a device.

Home Assistant owns:

- areas and their names;
- device/entity membership in areas;
- current entity/device names;
- current `entity_id` values used for state and service calls;
- disabled registry state.

Hommie owns:

- tile size;
- tile ordering within the current area;
- local hidden/suppressed state;
- tile type and local presentation overrides;
- primary entity override when the computed default is wrong;
- missing-tile recovery.

## Core model

Split synced registry data from local layout data.

The registry mirror stores Home Assistant identity and metadata:

- device registry stable identity: `device.id`;
- device name/name-by-user, area id, disabled state, manufacturer/model metadata;
- entity registry stable identity: registry entry id and/or `{platform, unique_id}`;
- current `entity_id`;
- domain;
- device id;
- resolved area id;
- name/original name;
- disabled/hidden flags;
- last-seen metadata.

The local layout stores Hommie presentation intent as overrides on top of the
current registry mirror:

- target kind: `device` by default, `entity` for device-less or intentionally
  entity-specific tiles;
- target stable id: HA `device_id` for device tiles, entity registry id for
  entity tiles;
- tile type;
- size;
- order within an area;
- locally hidden/suppressed flag;
- primary entity override for device tiles;
- last known area/name/type snapshots for recovery states.

Device tile commands resolve through the registry mirror:

```text
device tile target stable id
  -> current device registry row
  -> candidate entities for that device
  -> primary entity
  -> current entity_id
  -> Home Assistant service call
```

Entity tile commands are the same path starting at the entity registry id:

```text
entity tile target stable id
  -> current entity registry row
  -> current entity_id
  -> Home Assistant service call
```

This keeps tiles stable across entity renames while still using the current HA
address for control.

## Tile types

### Device tile

The default tile type. It binds to HA `device_id`, not to one entity. A device
tile represents the object a normal user recognizes: a lamp, switch, thermostat,
fan, lock, speaker, TV, sensor device, or similar.

Primary entity is computed from the device's current entities:

1. Ignore entities with `entity_category` `config` or `diagnostic`.
2. Ignore disabled entities.
3. Prefer controllable domains over passive domains.
4. Use a deterministic domain priority, for example:
   `light`, `switch`, `climate`, `cover`, `fan`, `media_player`, `lock`,
   `vacuum`, `button`, `sensor`, `binary_sensor`.
5. If the user sets a primary entity override, use it while it still resolves.

Secondary entities stay available for a device detail screen or compact metadata,
but they do not become separate top-level tiles by default.

### Entity tile

Entity tiles are reserved for things that do not have a useful HA device:

- scenes;
- scripts;
- helpers such as `input_boolean`, `input_select`, `input_number`;
- groups;
- device-less sensors or controls;
- any entity the user explicitly wants as a separate tile.

Entity tiles bind to entity registry identity, not `entity_id`. If a legacy or
YAML-defined entity has no registry identity, Hommie may support a degraded
`entity_id` binding and mark it as rename-fragile.

## Area mirroring policy

Hommie mirrors Home Assistant area membership.

When HA moves an entity/device from one area to another:

- keep the tile;
- keep size and local presentation settings;
- move the tile to the new HA area;
- assign `order = end of new area`;
- do not keep per-area position history.

If the target later moves back to a previous area, it is again placed at the end
of that current area. This deliberately avoids layout history complexity.

Device tiles use the device's resolved area. Entity tiles use the entity's own
area if set, otherwise the parent device's area if it has one, otherwise the
Unassigned section.

## Default home generation

The home model is generated continuously from the registry mirror, then Hommie
applies local overrides.

New HA devices should appear automatically in their HA area as device tiles,
unless the user has locally hidden/suppressed that target. New device-less
user-facing entities should appear in an "Available to add" pool or a later
explicit discovery surface; they should not flood the main home view.

Local layout rows are overrides, not the complete source of visible things:

- size/order override for visible tiles;
- locally hidden/suppressed target;
- primary entity override;
- local display overrides;
- missing/rebind metadata.

This gives a Google Home/HomeKit-like default while preserving user control.

## Missing, disabled, and hidden states

Tile target resolution has distinct states:

- `active`: target exists in registry and can be rendered normally.
- `unavailable`: target exists, but no live state is available.
- `disabled`: target exists in registry with `disabled_by != null` or the device
  target is disabled; Hommie renders it as unavailable/disabled and disables
  commands.
- `missing`: target no longer exists in registry; Hommie keeps the tile and
  shows a missing card with `Rebind` and `Remove` actions.

Hidden registry entries are ignored for main Hommie rendering. `hidden_by` is a
Home Assistant/Lovelace presentation preference and should not remove or disable
a tile that Hommie already has. Add-tile or discovery screens should hide
these entries by default or place them behind an advanced filter.

For missing tiles, Hommie preserves:

- size;
- order;
- last known area;
- last known display name;
- last known domain/type;
- last known `entity_id` or device id.

Commands are disabled until the tile is rebound to a valid target.

## Offline behavior

Offline UI renders from cached registry and layout data. Live state is an overlay:

- cached tiles and areas still render offline;
- last-known state may be shown as stale if persisted;
- controls are disabled when no active connection is available;
- sync resumes on reconnect and registry update events.

Hommie should not queue smart-home commands while offline in this design.

## Sync flow

`ServerSyncCoordinator` remains the owner of registry sync:

1. Start when the active server session is online.
2. Fetch area, device, and entity registries.
3. Write normalized registry rows to Drift by `serverId`.
4. Subscribe to `area_registry_updated`, `device_registry_updated`, and
   `entity_registry_updated`.
5. Recompute device tiles, entity tile candidates, target resolution, and area
   grouping after each successful registry refresh.
6. UI reads cached registry/layout projections, not raw WebSocket payloads.

Registry sync must not delete local tile configuration when a target disappears.
It only changes target resolution status.

## Data rules

- `entity_id` is mutable and should not be the primary tile binding.
- Device tiles bind to HA `device_id`.
- Entity tiles bind to entity registry identity.
- Area names are mutable display labels; area ids are the grouping identity.
- Entity/device renames update display metadata without changing tile identity.
- Entity/device area changes move tiles to the end of the new area.
- Entity/device removal creates a missing tile state, not an automatic layout
  deletion.
- Disabled entities or devices render as unavailable.
- Hidden entities render normally in Hommie if already present.
- New devices appear automatically unless locally hidden/suppressed.
- Device-less entities use entity tiles and are added deliberately, not as noisy
  automatic top-level tiles.

## Testing

- Entity rename keeps the same tile and updates the current `entity_id`.
- Device rename keeps the same tile and updates the displayed name.
- Area rename updates the section title without losing tile order.
- Entity/device area move keeps size and places the tile at the end of the new
  area.
- Moving back to a previous area also places the tile at the end, with no
  history restoration.
- Removed registry target produces a missing tile with rebind/remove actions.
- Disabled registry target renders unavailable and does not allow commands.
- Hidden registry target still renders normally in the main home view.
- Offline mode renders cached layout and disables commands.
- Device tile primary entity is recomputed when device entities change.
- Primary entity override wins while the overridden entity still resolves.
- New device appears in its HA area unless locally hidden/suppressed.
- Device-less entity does not become an automatic top-level tile unless added.
