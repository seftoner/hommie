import 'package:drift/drift.dart';

/// Enum for device display size in the home view configuration.
///
/// Used by [DeviceHomeConfigs] to determine how large a device tile should
/// be rendered in the UI (e.g., a single tile vs. a double-width tile).
enum DeviceDisplaySizeDb {
  /// Small display size - typically renders as a single tile
  small,

  /// Large display size - typically renders as a double-width tile
  big,
}

/// Database table for Home Assistant server connection details.
///
/// **Primary Entity:** Stores configuration for Home Assistant server instances.
///
/// **Relationships:**
/// - One-to-many with [AreaEntities] (cascade delete)
/// - One-to-one with [HomeViewConfigs] (cascade delete)
///
/// **Usage:**
/// - Managed by `DriftServerRepository` in features/servers
/// - Queried by `DriftServerEntityRepository` in features/home
/// - Used to track active server via `isActive` flag
///
/// **Key Features:**
/// - Auto-incrementing primary key `id`
/// - Stores server name, URL, and optional version
/// - Only one server should have `isActive = true` at a time
/// - Version is populated from Home Assistant API after connection
///
/// **Example:**
/// ```dart
/// ServerEntitiesCompanion(
///   name: Value('Home'),
///   url: Value('http://homeassistant.local:8123'),
///   isActive: Value(true),
///   version: Value('2024.11.3'),
/// )
/// ```
class ServerEntities extends Table {
  /// Auto-incrementing primary key
  IntColumn get id => integer().autoIncrement()();

  /// User-defined name for the server (e.g., "Home", "Office")
  TextColumn get name => text()();

  /// Indicates whether this server is currently active.
  /// Only one server should be active at a time.
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  /// Full URL to the Home Assistant instance (e.g., "http://homeassistant.local:8123")
  TextColumn get url => text()();

  /// Home Assistant version string (e.g., "2024.11.3"), populated after successful connection
  TextColumn get version => text().nullable()();
}

/// Database table for Home Assistant Area entities.
///
/// **Primary Entity:** Represents logical groupings of devices in Home Assistant,
/// typically corresponding to physical locations (e.g., "Living Room", "Kitchen").
///
/// **Relationships:**
/// - Many-to-one with [ServerEntities] (cascade delete on server deletion)
/// - Many-to-many with [DeviceEntities] via [DeviceAreaConfigs] (cascade delete on configs)
/// - Referenced by [AreaHomeConfigs] for home view positioning
///
/// **Usage:**
/// - Managed by `DriftAreaRepository` in features/home
/// - Synced from Home Assistant API
/// - Used to organize devices by room/location
/// - Supports custom backgrounds and images for UI customization
///
/// **Key Features:**
/// - `haId` is the unique identifier from Home Assistant (not the local DB id)
/// - `haId` must be unique across all areas
/// - Optional `background` and `image` for custom UI theming
/// - Cascading delete: deleting a server removes all its areas
/// - Cascading delete: deleting an area removes all its device associations via [DeviceAreaConfigs]
///
/// **Example:**
/// ```dart
/// AreaEntitiesCompanion(
///   haId: Value('living_room'),
///   name: Value('Living Room'),
///   background: Value('#FF5733'),
///   serverId: Value(1),
/// )
/// ```
class AreaEntities extends Table {
  /// Auto-incrementing primary key (local database ID)
  IntColumn get id => integer().autoIncrement()();

  /// Home Assistant unique identifier (e.g., "living_room")
  TextColumn get haId => text()();

  /// Display name for the area (e.g., "Living Room")
  TextColumn get name => text()();

  /// Optional background color/gradient for UI (hex color or gradient string)
  TextColumn get background => text().nullable()();

  /// Optional custom image URL for area representation
  TextColumn get image => text().nullable()();

  /// Foreign key reference to [ServerEntities]
  /// Cascades: deleting a server deletes all its areas
  IntColumn get serverId =>
      integer().references(ServerEntities, #id, onDelete: KeyAction.cascade)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {serverId, haId},
  ];
}

/// Database table for Home Assistant Device entities.
///
/// **Primary Entity:** Represents physical or virtual devices in Home Assistant
/// (e.g., smart lights, TVs, switches, sensors).
///
/// **Relationships:**
/// - Many-to-one with [ServerEntities] (cascade delete on server deletion)
/// - Many-to-many with [AreaEntities] via [DeviceAreaConfigs]
/// - Referenced by [DeviceHomeConfigs] for home view display
///
/// **Usage:**
/// - Managed by `DriftDeviceRepository` in features/home
/// - Synced from Home Assistant API
/// - Joined with [AreaEntities] via [DeviceAreaConfigs] to get area information
/// - Filtered and displayed in home view based on configuration
/// - Device persists even if removed from all areas
///
/// **Key Features:**
/// - `haId` is the unique entity ID from Home Assistant (e.g., "light.living_room_lamp")
/// - `haId` must be unique across all devices
/// - `type` indicates device domain (e.g., "light", "switch", "media_player")
/// - Device lifecycle independent of area assignments
/// - Cascading delete: deleting a server removes all its devices
///
/// **Example:**
/// ```dart
/// DeviceEntitiesCompanion(
///   haId: Value('light.living_room_lamp'),
///   name: Value('Living Room Lamp'),
///   type: Value('light'),
///   serverId: Value(1),
/// )
/// ```
class DeviceEntities extends Table {
  /// Auto-incrementing primary key (local database ID)
  IntColumn get id => integer().autoIncrement()();

  /// Home Assistant entity ID (e.g., "light.living_room_lamp")
  TextColumn get haId => text().unique()();

  /// Display name for the device (e.g., "Living Room Lamp")
  TextColumn get name => text()();

  /// Device domain/type (e.g., "light", "switch", "media_player", "sensor")
  TextColumn get type => text()();

  /// Foreign key reference to [ServerEntities]
  /// Cascades: deleting a server deletes all its devices
  IntColumn get serverId =>
      integer().references(ServerEntities, #id, onDelete: KeyAction.cascade)();
}

/// Database table for Device-Area associations.
///
/// **Junction Table:** Links devices to areas in a many-to-many relationship.
/// Devices can exist without being assigned to any area, and areas can have
/// multiple devices.
///
/// **Relationships:**
/// - Many-to-one with [DeviceEntities] (cascade delete on device deletion)
/// - Many-to-one with [AreaEntities] (cascade delete on area deletion)
///
/// **Usage:**
/// - Managed by `DriftDeviceRepository` in features/home
/// - Created when syncing device area assignments from Home Assistant
/// - Allows devices to persist even when removed from an area
/// - Used to join devices with areas when querying device locations
///
/// **Key Features:**
/// - Unique constraint prevents duplicate device-area assignments
/// - Cascading delete: deleting an area removes all its device associations
/// - Cascading delete: deleting a device removes all its area associations
/// - Device lifecycle is independent - device persists after all associations deleted
///
/// **Example:**
/// ```dart
/// DeviceAreaConfigsCompanion(
///   deviceId: Value(1), // Living Room Lamp
///   areaId: Value(1), // Living Room
/// )
/// ```
class DeviceAreaConfigs extends Table {
  /// Auto-incrementing primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key reference to [DeviceEntities]
  /// Cascades: deleting a device removes all its area associations
  IntColumn get deviceId =>
      integer().references(DeviceEntities, #id, onDelete: KeyAction.cascade)();

  /// Foreign key reference to [AreaEntities]
  /// Cascades: deleting an area removes all its device associations
  IntColumn get areaId =>
      integer().references(AreaEntities, #id, onDelete: KeyAction.cascade)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {deviceId, areaId}, // Can't assign same device to same area twice
  ];
}

/// Database table for Home View root configuration.
///
/// **Configuration Root:** Top-level configuration for each server's home view layout.
///
/// **Relationships:**
/// - One-to-one with [ServerEntities] (cascade delete, unique constraint)
/// - One-to-many with [AreaHomeConfigs] (cascade delete)
///
/// **Usage:**
/// - Managed by `DriftHomeViewRepository` in features/home
/// - Acts as the root node for hierarchical home view configuration
/// - Each server has exactly one home view configuration
/// - Contains list of areas to display in order
///
/// **Key Features:**
/// - `serverId` is unique - enforces one config per server
/// - Cascading delete: deleting a server removes its home view config
/// - Child [AreaHomeConfigs] define which areas to show and in what order
///
/// **Hierarchy:**
/// ```
/// HomeViewConfigs (root)
///   └─ AreaHomeConfigs (which areas to show)
///        └─ DeviceHomeConfigs (which devices to show per area)
/// ```
///
/// **Example:**
/// ```dart
/// // Created automatically when configuring home view for a server
/// HomeViewConfigsCompanion(
///   serverId: Value(1),
/// )
/// ```
class HomeViewConfigs extends Table {
  /// Auto-incrementing primary key
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key reference to [ServerEntities]
  /// UNIQUE constraint enforces 1:1 relationship - one config per server
  /// Cascades: deleting a server deletes its home view configuration
  IntColumn get serverId => integer()
      .references(ServerEntities, #id, onDelete: KeyAction.cascade)
      .unique()();
}

/// Database table for Area visibility and ordering in Home View.
///
/// **Configuration Layer:** Defines which areas are displayed in the home view
/// and their display order.
///
/// **Relationships:**
/// - Many-to-one with [HomeViewConfigs] (cascade delete)
/// - Many-to-one with [AreaEntities] (cascade delete)
/// - One-to-many with [DeviceHomeConfigs] (cascade delete)
///
/// **Usage:**
/// - Managed by `DriftHomeViewRepository` in features/home
/// - Links areas to the home view configuration
/// - Controls area display order via `order` field
/// - Allows selective display (not all areas must be shown)
///
/// **Key Features:**
/// - `order` determines sort order in UI (lower = appears first)
/// - Cascading delete: deleting home config removes all area configs
/// - Cascading delete: deleting an area removes its config entry
/// - Multiple areas can be configured for one home view
///
/// **Example:**
/// ```dart
/// AreaHomeConfigsCompanion(
///   order: Value(0), // First area in home view
///   areaId: Value(1), // Living Room
///   homeConfigId: Value(1),
/// )
/// ```
class AreaHomeConfigs extends Table {
  /// Auto-incrementing primary key
  IntColumn get id => integer().autoIncrement()();

  /// Sort order in home view (lower number = displayed first)
  IntColumn get order => integer()();

  /// Foreign key reference to [AreaEntities]
  /// Cascades: deleting an area removes it from home view config
  IntColumn get areaId =>
      integer().references(AreaEntities, #id, onDelete: KeyAction.cascade)();

  /// Foreign key reference to [HomeViewConfigs]
  /// Cascades: deleting home config removes all area configurations
  IntColumn get homeConfigId =>
      integer().references(HomeViewConfigs, #id, onDelete: KeyAction.cascade)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {homeConfigId, areaId}, // Can't add same area twice
  ];
}

/// Database table for Device visibility, ordering, and display size in Home View.
///
/// **Configuration Layer:** Defines which devices are displayed within each area
/// section of the home view, their order, and display size.
///
/// **Relationships:**
/// - Many-to-one with [AreaHomeConfigs] (cascade delete)
/// - Many-to-one with [DeviceEntities] (cascade delete)
///
/// **Usage:**
/// - Managed by `DriftHomeViewRepository` in features/home
/// - Links devices to area configurations in home view
/// - Controls device display order via `order` field
/// - Controls device tile size via `size` field ([DeviceDisplaySizeDb])
/// - Allows selective display (not all devices in an area must be shown)
///
/// **Key Features:**
/// - `order` determines sort order within the area section
/// - `size` controls UI tile dimensions (small/big)
/// - Cascading delete: deleting area config removes all device configs
/// - Cascading delete: deleting a device removes its config entry
/// - Enables flexible, per-user home view customization
///
/// **Example:**
/// ```dart
/// DeviceHomeConfigsCompanion(
///   order: Value(0), // First device in area
///   size: Value(DeviceDisplaySizeDb.big), // Large tile
///   deviceId: Value(1), // Living Room TV
///   areaConfigId: Value(1), // Living Room area config
/// )
/// ```
class DeviceHomeConfigs extends Table {
  /// Auto-incrementing primary key
  IntColumn get id => integer().autoIncrement()();

  /// Sort order within the area section (lower number = displayed first)
  IntColumn get order => integer()();

  /// Display size for device tile ([DeviceDisplaySizeDb.small] or [DeviceDisplaySizeDb.big])
  IntColumn get size => intEnum<DeviceDisplaySizeDb>()();

  /// Foreign key reference to [DeviceEntities]
  /// Cascades: deleting a device removes it from home view config
  IntColumn get deviceId =>
      integer().references(DeviceEntities, #id, onDelete: KeyAction.cascade)();

  /// Foreign key reference to [AreaHomeConfigs]
  /// Cascades: deleting area config removes all device configurations
  IntColumn get areaConfigId =>
      integer().references(AreaHomeConfigs, #id, onDelete: KeyAction.cascade)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {areaConfigId, deviceId}, // Can't add same device twice
  ];
}
