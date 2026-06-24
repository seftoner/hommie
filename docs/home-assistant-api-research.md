# Home Assistant API Research — WebSocket vs REST

Research for a Flutter HA client.

**Sources:**
- WebSocket types: extracted from `core/homeassistant/` via `vol.Required("type")` and `websocket_command({"type":` patterns — **340 server-verified types**
- REST endpoints: extracted from `url =` class attributes across all `HomeAssistantView` subclasses in core
- Mobile App webhook API: extracted from `core/homeassistant/components/mobile_app/webhook.py`
- Additional WS types used by external integration repos (ZHA, Z-Wave JS, Matter, Insteon) noted separately

HA server tested: `http://localhost:8123` (demo instance). Testing date: 2026-06-23.

---

## TL;DR for Flutter Client

**Use WebSocket for everything.** Testing confirmed that areas, floors, labels, devices, entity registry, panels, Lovelace, repairs, system health, backup info, and all registry writes have **no REST endpoint** — they are WebSocket-only. Maintaining two transports adds complexity for zero benefit on the things that matter.

### Verified REST GET endpoints (16 confirmed working)

| Operation | REST | Requires | WebSocket equivalent |
|---|---|---|---|
| Health check | `GET /api/` | — | — |
| Core run state | `GET /api/core/state` | — | — |
| HA configuration | `GET /api/config` | — | `get_config` |
| All entity states | `GET /api/states` | — | `get_states` |
| Single entity state | `GET /api/states/{entity_id}` | — | — (no WS single-fetch) |
| Event listeners | `GET /api/events` | — | — |
| All services | `GET /api/services` | — | `get_services` |
| Loaded components | `GET /api/components` | — | — |
| Error log | `GET /api/error_log` | — | `system_log/list` |
| Logbook | `GET /api/logbook` | optional `?entity_id=` | `logbook/get_events` |
| List calendar entities | `GET /api/calendars` | — | — |
| Calendar events | `GET /api/calendars/{entity_id}` | `?start=` and `?end=` (ISO8601) | `calendar/event/subscribe` |
| History | `GET /api/history/period` | `?filter_entity_id=` required | `history/history_during_period` |
| Config entries (integrations) | `GET /api/config/config_entries/entry` | — | `config_entries/get` |
| Available integration handlers | `GET /api/config/config_entries/flow_handlers` | — | — |
| Camera still image | `GET /api/camera_proxy/{entity_id}` | — | — |

### Things that look like REST but are NOT (all 404)

These were assumed to have REST endpoints based on documentation, but **live server testing confirmed they don't exist**. Use WebSocket.

| Assumed REST path | Actual | Use WebSocket instead |
|---|---|---|
| `GET /api/panels` | **404** | `get_panels` |
| `GET /api/areas` | **404** | `config/area_registry/list` |
| `GET /api/floors` | **404** | `config/floor_registry/list` |
| `GET /api/labels` | **404** | `config/label_registry/list` |
| `GET /api/devices` | **404** | `config/device_registry/list` |
| `GET /api/entity_registry` | **404** | `config/entity_registry/list_for_display` |
| `GET /api/shopping_list` | **404** | `shopping_list/items` |
| `GET /api/repairs/issues` | **404** | `repairs/list_issues` |
| `GET /api/lovelace/config` | **404** | `lovelace/config` |
| `GET /api/system_health` | **404** | `system_health/info` |
| `GET /api/backup/info` | **404** | `backup/info` |
| `GET /api/config/config_entries/entry/{id}` | **405 DELETE only** | `config_entries/get_single` |

### POST-only REST endpoints (return 405 on GET)

| Operation | REST |
|---|---|
| Call a service | `POST /api/services/{domain}/{service}` |
| Fire an event | `POST /api/events/{event_type}` |
| Render template | `POST /api/template` |
| Conversation / Assist | `POST /api/conversation/process` |
| Check config files | `POST /api/config/core/check_config` |
| Handle intent | `POST /api/intent/handle` |

**Everything else** (Lovelace, energy, blueprints, automations, scripts, traces, all registry writes, all integrations configs, all subscriptions) is WebSocket-only.

---

## REST API — All Endpoints

Extracted from core source. Authentication: `Authorization: Bearer <token>` on every request.

### Core / State

| Method | Path | Purpose |
|---|---|---|
| GET | `/api/` | Returns `{"message": "API running."}` — health check |
| GET | `/api/core/state` | Core state (running/starting/stopping) |
| GET | `/api/config` | Full HA configuration object |
| GET | `/api/states` | All entity states |
| GET | `/api/states/{entity_id}` | Single entity state |
| POST | `/api/states/{entity_id}` | Set state directly (bypasses entity platform) |
| GET | `/api/services` | All available services |
| POST | `/api/services/{domain}/{service}` | Call a service |
| GET | `/api/events` | List registered event listeners |
| POST | `/api/events/{event_type}` | Fire an event |
| GET | `/api/components` | List loaded components |
| GET | `/api/error_log` | System error log |
| GET | `/api/stream` | SSE stream of all events |
| POST | `/api/template` | Render a Jinja2 template |

### Config Entries (Integrations)

| Method | Path | Purpose |
|---|---|---|
| GET | `/api/config/config_entries/entry` | List all config entries |
| GET | `/api/config/config_entries/entry/{entry_id}` | Single config entry |
| POST | `/api/config/config_entries/entry/{entry_id}/reload` | Reload integration |
| POST | `/api/config/config_entries/flow` | Start config flow (setup integration) |
| GET | `/api/config/config_entries/flow/{flow_id}` | Config flow status |
| POST | `/api/config/config_entries/flow_handlers` | List available flow handlers |
| GET/POST | `/api/config/config_entries/options/flow` | Integration options flow |
| GET/POST | `/api/config/config_entries/subentries/flow` | Subentry flow |
| POST | `/api/config/core/check_config` | Check configuration files |

### History & Logbook

| Method | Path | Purpose |
|---|---|---|
| GET | `/api/history/period` | State history for a time period |
| GET | `/api/logbook` | Logbook events |

### Calendar

| Method | Path | Purpose |
|---|---|---|
| GET | `/api/calendars` | List calendar entities |
| GET/POST/PUT/DELETE | `/api/calendars/{entity_id}` | Calendar events for entity |

### Media / Camera / Image

| Method | Path | Purpose |
|---|---|---|
| GET | `/api/camera_proxy/{entity_id}` | Camera still image |
| GET | `/api/camera_proxy_stream/{entity_id}` | Camera MJPEG stream |
| GET | `/api/image_proxy/{entity_id}` | Image entity proxy |
| GET | `/api/image/serve/{image_id}/{filename}` | Serve uploaded image |
| POST | `/api/image/upload` | Upload image |
| GET | `/api/media_player_proxy/{entity_id}` | Media proxy |
| POST | `/api/file_upload` | Upload a file |

### HLS / Streaming

| Method | Path | Purpose |
|---|---|---|
| GET | `/api/hls/{token}/master_playlist.m3u8` | HLS master playlist |
| GET | `/api/hls/{token}/playlist.m3u8` | HLS playlist |
| GET | `/api/hls/{token}/segment/{sequence}.m4s` | HLS segment |

### Conversation / STT / TTS

| Method | Path | Purpose |
|---|---|---|
| POST | `/api/conversation/process` | Conversational AI |
| POST | `/api/stt/{provider}` | Speech-to-text |
| POST | `/api/tts_get_url` | Get TTS audio URL |
| GET | `/api/tts_proxy/{token}` | Serve TTS audio |
| POST | `/api/intent/handle` | Handle an intent directly |

### Diagnostics / Repairs

| Method | Path | Purpose |
|---|---|---|
| GET | `/api/diagnostics/{d_type}/{d_id}` | Diagnostics download |
| GET/POST | `/api/repairs/issues/fix` | Start repair fix flow |
| GET/POST/DELETE | `/api/repairs/issues/fix/{flow_id}` | Repair flow steps |

### Backup

| Method | Path | Purpose |
|---|---|---|
| GET | `/api/backup/download/{backup_id}` | Download a backup |
| POST | `/api/backup/upload` | Upload a backup |

### Shopping List

| Method | Path | Purpose |
|---|---|---|
| GET | `/api/shopping_list` | List items |
| POST | `/api/shopping_list/item` | Add item |
| PUT | `/api/shopping_list/item/{item_id}` | Update item |
| POST | `/api/shopping_list/clear_completed` | Clear completed |

### Media Source

| Method | Path | Purpose |
|---|---|---|
| POST | `/api/media_source/local_source/upload` | Upload to local media |

### Onboarding

| Method | Path | Purpose |
|---|---|---|
| GET/POST | `/api/onboarding` | Onboarding step |
| POST | `/api/onboarding/users` | Create first user |
| POST | `/api/onboarding/core_config` | Set initial config |
| POST | `/api/onboarding/integration` | Create initial integration |

### Integration-specific REST (partial list)

| Path | Integration |
|---|---|
| `/api/cloud/*` | Nabu Casa cloud |
| `/api/hassio/{path}` | Supervisor / add-ons |
| `/api/notify.html5` | HTML5 push notifications |
| `/api/homekit/pairingqr` | HomeKit |
| `/api/analytics/devices` | Analytics reporting |
| `/api/zwave_js/firmware/upload/{device_id}` | Z-Wave JS |
| `/api/{username}/lights` | Hue emulation |
| `/api/mobile_app/registrations` | Mobile App |
| `/api/ios/*` | iOS companion |

---

## Mobile App Webhook API

A third transport, separate from REST and WebSocket. Used by the official companion apps and relevant for any Flutter client that wants to behave like a companion app (send sensors, location, receive push notifications).

### How it works

1. **Register the device** — `POST /api/mobile_app/registrations` with device info. Response contains a `webhook_id`.
2. **All subsequent calls** — `POST /api/webhook/{webhook_id}` with JSON body `{"type": "<command>", "data": {...}}`.

No `Authorization` header needed after registration — the `webhook_id` acts as the credential. Optionally enable end-to-end encryption with the `enable_encryption` command (uses libsodium SecretBox).

### Registration — `POST /api/mobile_app/registrations`

```json
{
  "app_id": "io.homeassistant.flutter",
  "app_name": "My Flutter App",
  "app_version": "1.0.0",
  "device_id": "<unique-device-uuid>",
  "device_name": "Roman's iPhone",
  "manufacturer": "Apple",
  "model": "iPhone 16",
  "os_name": "iOS",
  "os_version": "18.0",
  "supports_encryption": false
}
```

Response includes `webhook_id`, `cloudhook_url` (if cloud active), `remote_ui_url`.

### Webhook Commands — `POST /api/webhook/{webhook_id}`

All commands follow the same envelope:
```json
{ "type": "<command>", "data": { ... } }
```

| Command | Purpose | Key `data` fields |
|---|---|---|
| `get_config` | HA config + device entity list | _(no data needed)_ |
| `get_zones` | All zone states | _(no data needed)_ |
| `call_service` | Call any HA service | `domain`, `service`, `service_data` |
| `fire_event` | Fire a HA event | `event_type`, `event_data` |
| `conversation_process` | Send text to Assist | `text`, `language`, `conversation_id` |
| `render_template` | Render Jinja2 templates | `{"key": {"template": "...", "variables": {}}}` (multiple named templates) |
| `stream_camera` | Get camera stream URLs | `camera_entity_id` → returns `hls_path`, `mjpeg_path` |
| `update_location` | Push GPS location | `gps`, `gps_accuracy`, `speed`, `altitude`, `course` |
| `update_registration` | Update device info | `app_version`, `device_name`, `manufacturer`, `model`, `os_version` |
| `register_sensor` | Create a sensor entity on HA | `name`, `unique_id`, `type` (`sensor`/`binary_sensor`), `state`, `device_class`, `unit_of_measurement` |
| `update_sensor_states` | Batch-update sensor values | Array of `{type, unique_id, state, attributes}` |
| `enable_encryption` | Turn on E2E encryption | _(no data)_ → response contains `secret` |
| `scan_tag` | Fire a tag scan event | `tag_id` |
| `live_activity_token` | iOS Live Activity start | `token`, `expires_at`, `attributes_type` |
| `live_activity_dismissed` | iOS Live Activity end | `token` |

### WebSocket (push notifications)

After registering, subscribe to push notifications over the existing WebSocket connection:

```json
{ "type": "mobile_app/push_notification_channel", "webhook_id": "...", "support_confirm": true }
```

Confirm receipt with:
```json
{ "type": "mobile_app/push_notification_confirm", "webhook_id": "...", "confirm_id": "..." }
```

### What `get_config` returns (webhook version)

Different from `GET /api/config` — this is device-scoped and includes:
- `latitude`, `longitude`, `elevation`
- `unit_system`, `location_name`, `time_zone`
- `components` (loaded integrations list)
- `version`
- `hass_device_id` (the device registry ID for this device)
- `entities` — map of `unique_id → {disabled: bool}` for all entities belonging to this device
- `cloudhook_url`, `remote_ui_url` (if Nabu Casa cloud active)

---

## WebSocket Message Catalog — Server-Verified (340 types)

Extracted from `core/homeassistant/` source. Types in **bold** also have a REST equivalent above.

**Legend:** (SUB) = `subscribeMessage` / persistent subscription; (EVT) = `subscribeEvents`; no marker = one-shot request

### AI Task
`ai_task/preferences/get` · `ai_task/preferences/set`

### Analytics
`analytics` · `analytics/preferences`

### Application Credentials
`application_credentials/config` · `application_credentials/config_entry`

### Assist Pipeline
`assist_pipeline/device/capture` · `assist_pipeline/device/list` · `assist_pipeline/language/list` · `assist_pipeline/pipeline_debug/get` · `assist_pipeline/pipeline_debug/list`
(SUB) `assist_pipeline/run`

### Assist Satellite
`assist_satellite/get_configuration` · `assist_satellite/set_wake_words` · `assist_satellite/test_connection`
(SUB) `assist_satellite/intercept_wake_word`

### Auth
`auth/current_user` · `auth/delete_all_refresh_tokens` · `auth/delete_refresh_token` · `auth/depose_mfa` · `auth/long_lived_access_token` · `auth/refresh_token_set_expiry` · `auth/refresh_tokens` · `auth/setup_mfa` · `auth/sign_path`

### Auth Provider (Local)
`config/auth/create` · `config/auth/delete` · `config/auth/list` · `config/auth/update`
`config/auth_provider/homeassistant/change_password` · `config/auth_provider/homeassistant/create` · `config/auth_provider/homeassistant/delete`

### Automation
`automation/config`

### Backup
`backup/agents/info` · `backup/can_decrypt_on_download` · `backup/config/info` · `backup/config/update` · `backup/delete` · `backup/details` · `backup/end` · `backup/generate` · `backup/generate_with_automatic_settings` · `backup/info` · `backup/restore` · `backup/start`
(SUB) `backup/subscribe_events`

### Blueprint
`blueprint/delete` · `blueprint/import` · `blueprint/list` · `blueprint/save` · `blueprint/substitute`

### Bluetooth
(SUB) `bluetooth/subscribe_advertisements` · `bluetooth/subscribe_connection_allocations` · `bluetooth/subscribe_scanner_details` · `bluetooth/subscribe_scanner_state`

### Calendar
`calendar/event/create` · `calendar/event/delete` · `calendar/event/update`
(SUB) `calendar/event/subscribe`

### Camera
`camera/capabilities` · `camera/get_prefs` · `camera/stream` · `camera/update_prefs` · `camera/webrtc/candidate` · `camera/webrtc/get_client_config`
(SUB) `camera/webrtc/offer`

### Cloud (Nabu Casa)
`cloud/alexa/entities` · `cloud/alexa/entities/get` · `cloud/alexa/sync` · `cloud/cloudhook/create` · `cloud/cloudhook/delete` · `cloud/google_assistant/entities` · `cloud/google_assistant/entities/get` · `cloud/google_assistant/entities/update` · `cloud/remote/connect` · `cloud/remote/disconnect` · `cloud/remove_data` · `cloud/status` · `cloud/subscription` · `cloud/tts/info` · `cloud/update_prefs` · `cloud/webrtc/ice_servers`

### Config — Area Registry
`config/area_registry/create` · `config/area_registry/delete` · **`config/area_registry/list`** · `config/area_registry/reorder` · `config/area_registry/update`

### Config — Category Registry
`config/category_registry/create` · `config/category_registry/delete` · `config/category_registry/list` · `config/category_registry/update`

### Config — Core
`config/core/detect` · `config/core/update`

### Config — Device Registry
**`config/device_registry/list`** · `config/device_registry/remove_config_entry` · `config/device_registry/update`

### Config — Entity Registry
`config/entity_registry/get` · `config/entity_registry/get_automatic_entity_ids` · `config/entity_registry/get_entries` · `config/entity_registry/list` · **`config/entity_registry/list_for_display`** · `config/entity_registry/remove` · `config/entity_registry/update`

### Config — Floor Registry
`config/floor_registry/create` · `config/floor_registry/delete` · **`config/floor_registry/list`** · `config/floor_registry/reorder` · `config/floor_registry/update`

### Config — Label Registry
`config/label_registry/create` · `config/label_registry/delete` · **`config/label_registry/list`** · `config/label_registry/update`

### Config Entries (Integrations)
`config_entries/disable` · `config_entries/flow/progress` · **`config_entries/get`** · `config_entries/get_single` · `config_entries/ignore_flow` · `config_entries/subentries/delete` · `config_entries/subentries/list` · `config_entries/subentries/update` · `config_entries/update`
(SUB) `config_entries/flow/subscribe` · `config_entries/subscribe`

### Conversation / Assist
`conversation/agent/homeassistant/debug` · `conversation/agent/homeassistant/language_scores` · `conversation/agent/list` · `conversation/prepare` · **`conversation/process`** · `conversation/sentences/list`
(SUB) `conversation/chat_log/subscribe` · `conversation/chat_log/subscribe_index`

### Core Utilities
**`get_config`** · **`get_panels`** · **`get_services`** · **`get_states`** · `execute_script` · `extract_from_target` · **`fire_event`** · `get_conditions_for_target` · `get_services_for_target` · `get_triggers_for_target` · `ping` · **`render_template`** · `subscribe_bootstrap_integrations` · `subscribe_condition` · `subscribe_trigger` · `test_condition` · `unsubscribe_events` · `validate_config`
(SUB) `subscribe_entities` · `subscribe_events`

### Device Automation
`device_automation/action/capabilities` · `device_automation/action/list` · `device_automation/condition/capabilities` · `device_automation/condition/list` · `device_automation/trigger/capabilities` · `device_automation/trigger/list`

### DHCP
(SUB) `dhcp/subscribe_discovery`

### Diagnostics
`diagnostics/get` · `diagnostics/list`

### Dynalite (KNX bridge)
`dynalite/get-config` · `dynalite/save-config`

### Energy
`energy/fossil_energy_consumption` · `energy/get_prefs` · `energy/info` · `energy/save_prefs` · `energy/solar_forecast` · `energy/validate`

### Energy (grid cost types — used in energy dashboard)
`battery` · `gas` · `grid` · `solar` · `water`

### Entity
`entity/source`

### Frontend / UI
`frontend/get_icons` · `frontend/get_system_data` · `frontend/get_themes` · `frontend/get_translations` · `frontend/get_user_data` · `frontend/get_version` · `frontend/set_system_data` · `frontend/set_user_data` · `frontend/update_panel`
(SUB) `frontend/subscribe_extra_js` · `frontend/subscribe_system_data` · `frontend/subscribe_user_data`

### Group
(SUB) `group/start_preview`

### Hardware
`hardware/info`
(SUB) `hardware/subscribe_system_status`

### Hassio / Supervisor
`hassio/update/config/info` · `hassio/update/config/update`

### History
`history/history_during_period`
(SUB) `history/stream`

### History Stats
(SUB) `history_stats/start_preview`

### Home Assistant Expose (voice assistants)
`homeassistant/expose_entity` · `homeassistant/expose_entity/list` · `homeassistant/expose_new_entities/get` · `homeassistant/expose_new_entities/set`

### Integration
`integration/descriptions` · `integration/setup_info` · `integration/wait`

### KNX
`knx/create_device` · `knx/create_entity` · `knx/delete_entity` · `knx/delete_expose` · `knx/get_base_data` · `knx/get_entities_by_group` · `knx/get_entity_config` · `knx/get_expose_config` · `knx/get_expose_groups` · `knx/get_knx_project` · `knx/get_schema` · `knx/get_time_server_config` · `knx/group_monitor_info` · `knx/group_telegrams` · `knx/project_file_process` · `knx/project_file_remove` · `knx/query_telegrams` · `knx/update_entity` · `knx/update_expose` · `knx/update_time_server_config` · `knx/validate_entity` · `knx/validate_expose`
(SUB) `knx/subscribe_telegrams`

### Labs (feature flags)
`labs/list` · `labs/update`
(SUB) `labs/subscribe`

### LCN
`lcn/devices` · `lcn/devices/add` · `lcn/devices/delete` · `lcn/devices/scan` · `lcn/entities` · `lcn/entities/add` · `lcn/entities/delete`

### Logbook
`logbook/get_events`
(SUB) `logbook/event_stream`

### Logger
`logger/integration_log_level` · `logger/log_info` · `logger/log_level`

### Lovelace / Dashboards
`lovelace/config` · `lovelace/config/delete` · `lovelace/config/save` · `lovelace/info`
*(Dashboard list/create/update/delete and resource CRUD are in separate frontend-side lovelace WS handlers — not found in core grep, may live in the lovelace component)*

### Manifest
`manifest/get` · `manifest/list`

### Media Player
`media_player/browse_media` · `media_player/search_media`

### Media Source
`media_source/browse_media` · `media_source/local_source/remove` · `media_source/resolve_media`

### Mobile App
(SUB) `mobile_app/push_notification_channel` · `mobile_app/push_notification_confirm`

### Mold Indicator
(SUB) `mold_indicator/start_preview`

### MQTT
`mqtt/device/debug_info`
(SUB) `mqtt/subscribe`

### Network
`network` · `network/configure` · `network/url`

### Number / Sensor
`number/device_class_convertible_units` · `sensor/device_class_convertible_units` · `sensor/numeric_device_classes`

### OTBR (OpenThread Border Router)
`otbr/create_network` · `otbr/info` · `otbr/set_channel` · `otbr/set_network`

### Persistent Notifications
`persistent_notification/get`
(SUB) `persistent_notification/subscribe`

### Radio Frequency
`radio_frequency/list`

### Recorder / Statistics
`recorder/adjust_sum_statistics` · `recorder/change_statistics_unit` · `recorder/clear_statistics` · `recorder/get_statistics_metadata` · `recorder/import_statistics` · `recorder/info` · `recorder/list_statistic_ids` · `recorder/statistic_during_period` · `recorder/statistics_during_period` · `recorder/update_statistics_issues` · `recorder/update_statistics_metadata` · `recorder/validate_statistics`

### Repairs
`repairs/get_issue_data` · `repairs/ignore_issue` · `repairs/list_issues`

### Script
`script/config`

### Search
`search/related`

### Shopping List
`shopping_list/items` · `shopping_list/items/add` · `shopping_list/items/clear` · `shopping_list/items/remove` · `shopping_list/items/reorder` · `shopping_list/items/update`
*(Also available via REST: `/api/shopping_list`)*

### SSDP
(SUB) `ssdp/subscribe_discovery`

### Statistics
(SUB) `statistics/start_preview`

### STT (Speech-to-Text)
`stt/engine/list`

### System Health
`system_health/info`

### System Log
**`system_log/list`**

### Template
(SUB) `template/start_preview`

### Thread
`thread/add_dataset_tlv` · `thread/delete_dataset` · `thread/get_dataset_tlv` · `thread/list_datasets` · `thread/set_preferred_border_agent` · `thread/set_preferred_dataset`
(SUB) `thread/discover_routers`

### Threshold
(SUB) `threshold/start_preview`

### Time/Date
(SUB) `time_date/start_preview`

### TODO
`todo/item/list` · `todo/item/move`
(SUB) `todo/item/subscribe`

### Trace
`trace/contexts` · `trace/get` · `trace/list`
`trace/debug/breakpoint/clear` · `trace/debug/breakpoint/list` · `trace/debug/breakpoint/set` · `trace/debug/continue` · `trace/debug/step` · `trace/debug/stop`
(SUB) `trace/debug/breakpoint/subscribe`

### TTS (Text-to-Speech)
`tts/engine/get` · `tts/engine/list` · `tts/engine/voices`

### Condition/Trigger Platforms
(SUB) `condition_platforms/subscribe` · `trigger_platforms/subscribe`

### Update
`update/release_notes`

### USB
`usb/list_serial_ports` · `usb/scan`

### Vacuum
`vacuum/get_segments`

### Wake Word
`wake_word/info`

### Weather
`weather/convertible_units`
(SUB) `weather/subscribe_forecast`

### WebRTC
`web_rtc/ice_servers`

### Webhook
`webhook/handle` · `webhook/list`

### Wyoming
`wyoming/info`

### Zeroconf
(SUB) `zeroconf/subscribe_discovery`

### ZHA (Zigbee) — partial (core only has `zha/devices/permit`)
`zha/devices/permit`
*(Full ZHA WS API lives in the `zha` integration; see External Integrations section below)*

---

## External Integration WS Types (not in core grep)

These integrations live in separate repos or are large enough that not all their types appear in the core `homeassistant/` directory. Confirmed via frontend source analysis.

### ZHA (Zigbee Home Automation)
`zha/configuration` · `zha/configuration/update` · `zha/device` · `zha/devices` · `zha/devices/bind` · `zha/devices/bindable` · `zha/devices/clusters` · `zha/devices/clusters/attributes` · `zha/devices/clusters/attributes/value` · `zha/devices/clusters/commands` · `zha/devices/groupable` · `zha/devices/unbind` · `zha/group` · `zha/group/add` · `zha/group/members/add` · `zha/group/members/remove` · `zha/group/remove` · `zha/groups` · `zha/groups/bind` · `zha/groups/unbind` · `zha/network/backups/create` · `zha/network/backups/list` · `zha/network/backups/restore` · `zha/network/change_channel` · `zha/network/settings`
(SUB) `zha/devices/reconfigure` · `zha/topology/update`

### Z-Wave JS
`zwave_js/abort_firmware_update` · `zwave_js/begin_rebuilding_routes` · `zwave_js/cancel_secure_bootstrap_s2` · `zwave_js/data_collection_status` · `zwave_js/get_config_parameters` · `zwave_js/get_log_config` · `zwave_js/get_node_firmware_update_capabilities` · `zwave_js/get_provisioning_entries` · `zwave_js/get_raw_config_parameter` · `zwave_js/grant_security_classes` · `zwave_js/hard_reset_controller` · `zwave_js/invoke_cc_api` · `zwave_js/is_any_ota_firmware_update_in_progress` · `zwave_js/is_node_firmware_update_in_progress` · `zwave_js/lookup_device` · `zwave_js/network_status` · `zwave_js/node_alerts` · `zwave_js/node_capabilities` · `zwave_js/node_metadata` · `zwave_js/parse_qr_code_string` · `zwave_js/provision_smart_start_node` · `zwave_js/rebuild_node_routes` · `zwave_js/stop_exclusion` · `zwave_js/stop_inclusion` · `zwave_js/stop_rebuilding_routes` · `zwave_js/supports_feature` · `zwave_js/try_parse_dsk_from_qr_code_string` · `zwave_js/unprovision_smart_start_node` · `zwave_js/update_data_collection_preference` · `zwave_js/update_log_config` · `zwave_js/validate_dsk_and_enter_pin`
(SUB) `zwave_js/add_node` · `zwave_js/backup_nvm` · `zwave_js/node_status` · `zwave_js/refresh_node_info` · `zwave_js/remove_failed_node` · `zwave_js/restore_nvm` · `zwave_js/subscribe_controller_statistics` · `zwave_js/subscribe_firmware_update_status` · `zwave_js/subscribe_log_updates` · `zwave_js/subscribe_new_devices` · `zwave_js/subscribe_node_statistics` · `zwave_js/subscribe_node_status` · `zwave_js/subscribe_rebuild_routes_progress` · `zwave_js/subscribe_s2_inclusion`

### Matter
`matter/commission` · `matter/commission_on_network` · `matter/interview_node` · `matter/node_diagnostics` · `matter/open_commissioning_window` · `matter/ping_node` · `matter/remove_matter_fabric` · `matter/set_thread` · `matter/set_wifi_credentials`

### Insteon
`insteon/aldb/*` · `insteon/config/*` · `insteon/device/*` · `insteon/properties/*` · `insteon/scenes/*`

---

## Event Subscriptions (via `subscribe_events`)

Sent as `{ type: "subscribe_events", event_type: "..." }`. Only admin users can subscribe to arbitrary events; non-admin users are restricted to the allowlist.

| Event type | Purpose |
|---|---|
| `state_changed` | Any entity state change — the core real-time feed |
| `area_registry_updated` | Area added / changed / removed |
| `category_registry_updated` | Category registry changes |
| `data_entry_flow_progress_update` | Config flow (integration setup) progress |
| `entity_registry_updated` | Entity added / changed / removed |
| `floor_registry_updated` | Floor registry changes |
| `label_registry_updated` | Label registry changes |
| `labs_updated` | Feature flags changed |
| `repairs_issue_registry_updated` | Repair issues changed |
| `update` | HA software update available |
| `persistent_notifications_updated` | Notification added / dismissed |

---

## Testing Log

Tested against `http://localhost:8123` (demo instance) on 2026-06-23.

| Endpoint | Method | Result | Notes |
|---|---|---|---|
| `/api/` | GET | ✅ 200 | `{"message":"API running."}` |
| `/api/core/state` | GET | ✅ 200 | |
| `/api/config` | GET | ✅ 200 | |
| `/api/states` | GET | ✅ 200 | |
| `/api/states/{entity_id}` | GET | ✅ 200 | |
| `/api/events` | GET | ✅ 200 | |
| `/api/services` | GET | ✅ 200 | |
| `/api/components` | GET | ✅ 200 | |
| `/api/error_log` | GET | ✅ 200 | |
| `/api/logbook` | GET | ✅ 200 | |
| `/api/logbook?entity_id=light.bed_light` | GET | ✅ 200 | |
| `/api/calendars` | GET | ✅ 200 | |
| `/api/calendars/{entity_id}?start=...&end=...` | GET | ✅ 200 | Both `start` and `end` params required |
| `/api/history/period?filter_entity_id={id}` | GET | ✅ 200 | `filter_entity_id` is required; bare path returns 400 |
| `/api/history/period` | GET | ❌ 400 | `{"message":"filter_entity_id is missing"}` |
| `/api/config/config_entries/entry` | GET | ✅ 200 | |
| `/api/config/config_entries/flow_handlers` | GET | ✅ 200 | Returns list of 782 handler domains |
| `/api/camera_proxy/{entity_id}` | GET | ✅ 200 | Returns JPEG image bytes |
| `/api/panels` | GET | ❌ 404 | WebSocket-only: `get_panels` |
| `/api/areas` | GET | ❌ 404 | WebSocket-only: `config/area_registry/list` |
| `/api/floors` | GET | ❌ 404 | WebSocket-only: `config/floor_registry/list` |
| `/api/labels` | GET | ❌ 404 | WebSocket-only: `config/label_registry/list` |
| `/api/devices` | GET | ❌ 404 | WebSocket-only: `config/device_registry/list` |
| `/api/entity_registry` | GET | ❌ 404 | WebSocket-only: `config/entity_registry/list_for_display` |
| `/api/shopping_list` | GET | ❌ 404 | Component not loaded on this instance |
| `/api/repairs/issues` | GET | ❌ 404 | WebSocket-only: `repairs/list_issues` |
| `/api/lovelace/config` | GET | ❌ 404 | WebSocket-only: `lovelace/config` |
| `/api/system_health` | GET | ❌ 404 | WebSocket-only: `system_health/info` |
| `/api/backup/info` | GET | ❌ 404 | WebSocket-only: `backup/info` (backup IS loaded as config entry) |
| `/api/diagnostics/integration/demo` | GET | ❌ 400 | Format unclear; WS `diagnostics/get` preferred |
| `/api/config/config_entries/entry/{id}` | GET | ❌ 405 | `Allow: DELETE` only — use list endpoint |
| `/api/config/core/check_config` | POST | — 405 on GET | POST-only |
| `/api/intent/handle` | POST | — 405 on GET | POST-only |
| `/api/conversation/process` | POST | — 405 on GET | POST-only |
| `/api/template` | POST | — 405 on GET | POST-only |
