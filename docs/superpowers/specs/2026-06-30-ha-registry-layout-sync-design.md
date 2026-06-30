# Home Assistant registry-backed layout sync - Design

Date: 2026-06-30
Branch: `main`
Status: Draft for review

## Problem

Hommie is an unofficial mobile client for Home Assistant, not a Lovelace wrapper.
It needs to render cached home structure while offline, but still respect Home
Assistant as the source of truth for areas and device/entity membership.

The fragile part is identity. `entity_id` values such as `light.kitchen_bulb`
are useful command addresses, but they can change when users rename entities in
Home Assistant. A Hommie layout that binds widgets directly to `entity_id` would
break or lose user customization when registry data changes.

## Goal

Use Home Assistant registries as the source of truth for home structure while
keeping Hommie-specific presentation settings local.

Home Assistant owns:

- areas and their names;
- device/entity membership in areas;
- current entity/device names;
- current `entity_id` values used for state and service calls;
- disabled registry state.

Hommie owns:

- widget existence in the local layout;
- widget size;
- widget ordering within the current area;
- widget type and local presentation overrides;
- missing-widget recovery.

## Core model

Split synced registry data from local layout data.

The registry mirror stores Home Assistant identity and metadata:

- entity registry stable identity: registry entry id and/or `{platform, unique_id}`;
- current `entity_id`;
- domain;
- device id;
- resolved area id;
- name/original name;
- disabled/hidden flags;
- last-seen metadata.

The layout stores user presentation intent:

- target kind: `entity` or `device`;
- target stable id, not `entity_id`;
- widget type;
- size;
- order within an area;
- last known area/name/type snapshots for recovery states.

Commands resolve through the registry mirror:

```text
widget target stable id
  -> current registry row
  -> current entity_id
  -> Home Assistant service call
```

This keeps widgets stable across entity renames while still using the current HA
address for control.

## Area mirroring policy

Hommie mirrors Home Assistant area membership.

When HA moves an entity/device from one area to another:

- keep the widget;
- keep size and local presentation settings;
- move the widget to the new HA area;
- assign `order = end of new area`;
- do not keep per-area position history.

If the target later moves back to a previous area, it is again placed at the end
of that current area. This deliberately avoids layout history complexity.

## Missing, disabled, and hidden states

Widget target resolution has distinct states:

- `active`: target exists in registry and can be rendered normally.
- `unavailable`: target exists, but no live state is available.
- `disabled`: target exists in registry with `disabled_by != null`; Hommie renders
  it as unavailable/disabled and disables commands.
- `missing`: target no longer exists in registry; Hommie keeps the widget and
  shows a missing card with `Rebind` and `Remove` actions.

Hidden registry entries are ignored for main Hommie rendering. `hidden_by` is a
Home Assistant/Lovelace presentation preference and should not remove or disable
a widget that Hommie already has. Later, add-widget or auto-discovery screens may
hide these entries by default or place them behind an advanced filter.

For missing widgets, Hommie preserves:

- size;
- order;
- last known area;
- last known display name;
- last known domain/type;
- last known `entity_id` or device id.

Commands are disabled until the widget is rebound to a valid target.

## Offline behavior

Offline UI renders from cached registry and layout data. Live state is an overlay:

- cached widgets and areas still render offline;
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
5. Recompute target resolution and area grouping after each successful registry
   refresh.
6. UI reads cached registry/layout projections, not raw WebSocket payloads.

Registry sync must not delete local widget configuration when a target disappears.
It only changes target resolution status.

## Data rules

- `entity_id` is mutable and should not be the primary widget binding.
- Area names are mutable display labels; area ids are the grouping identity.
- Entity/device renames update display metadata without changing widget identity.
- Entity/device area changes move widgets to the end of the new area.
- Entity/device removal creates a missing widget state, not an automatic layout
  deletion.
- Disabled entities render as unavailable.
- Hidden entities render normally in Hommie if already present.

## Testing

- Entity rename keeps the same widget and updates the current `entity_id`.
- Area rename updates the section title without losing widget order.
- Entity/device area move keeps size and places the widget at the end of the new
  area.
- Moving back to a previous area also places the widget at the end, with no
  history restoration.
- Removed registry target produces a missing widget with rebind/remove actions.
- Disabled registry target renders unavailable and does not allow commands.
- Hidden registry target still renders normally in the main home view.
- Offline mode renders cached layout and disables commands.
