// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ServerEntitiesTable extends ServerEntities
    with TableInfo<$ServerEntitiesTable, ServerEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServerEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, isActive, url, version];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'server_entities';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServerEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServerEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServerEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version'],
      ),
    );
  }

  @override
  $ServerEntitiesTable createAlias(String alias) {
    return $ServerEntitiesTable(attachedDatabase, alias);
  }
}

class ServerEntity extends DataClass implements Insertable<ServerEntity> {
  /// Auto-incrementing primary key
  final int id;

  /// User-defined name for the server (e.g., "Home", "Office")
  final String name;

  /// Indicates whether this server is currently active.
  /// Only one server should be active at a time.
  final bool isActive;

  /// Full URL to the Home Assistant instance (e.g., "http://homeassistant.local:8123")
  final String url;

  /// Home Assistant version string (e.g., "2024.11.3"), populated after successful connection
  final String? version;
  const ServerEntity({
    required this.id,
    required this.name,
    required this.isActive,
    required this.url,
    this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || version != null) {
      map['version'] = Variable<String>(version);
    }
    return map;
  }

  ServerEntitiesCompanion toCompanion(bool nullToAbsent) {
    return ServerEntitiesCompanion(
      id: Value(id),
      name: Value(name),
      isActive: Value(isActive),
      url: Value(url),
      version: version == null && nullToAbsent
          ? const Value.absent()
          : Value(version),
    );
  }

  factory ServerEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServerEntity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      url: serializer.fromJson<String>(json['url']),
      version: serializer.fromJson<String?>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
      'url': serializer.toJson<String>(url),
      'version': serializer.toJson<String?>(version),
    };
  }

  ServerEntity copyWith({
    int? id,
    String? name,
    bool? isActive,
    String? url,
    Value<String?> version = const Value.absent(),
  }) => ServerEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
    url: url ?? this.url,
    version: version.present ? version.value : this.version,
  );
  ServerEntity copyWithCompanion(ServerEntitiesCompanion data) {
    return ServerEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      url: data.url.present ? data.url.value : this.url,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServerEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('url: $url, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isActive, url, version);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServerEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.isActive == this.isActive &&
          other.url == this.url &&
          other.version == this.version);
}

class ServerEntitiesCompanion extends UpdateCompanion<ServerEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<String> url;
  final Value<String?> version;
  const ServerEntitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.url = const Value.absent(),
    this.version = const Value.absent(),
  });
  ServerEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.isActive = const Value.absent(),
    required String url,
    this.version = const Value.absent(),
  }) : name = Value(name),
       url = Value(url);
  static Insertable<ServerEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<String>? url,
    Expression<String>? version,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (url != null) 'url': url,
      if (version != null) 'version': version,
    });
  }

  ServerEntitiesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<bool>? isActive,
    Value<String>? url,
    Value<String?>? version,
  }) {
    return ServerEntitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      url: url ?? this.url,
      version: version ?? this.version,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServerEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('url: $url, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }
}

class $AreaEntitiesTable extends AreaEntities
    with TableInfo<$AreaEntitiesTable, AreaEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AreaEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _haIdMeta = const VerificationMeta('haId');
  @override
  late final GeneratedColumn<String> haId = GeneratedColumn<String>(
    'ha_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _backgroundMeta = const VerificationMeta(
    'background',
  );
  @override
  late final GeneratedColumn<String> background = GeneratedColumn<String>(
    'background',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES server_entities (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    haId,
    name,
    background,
    image,
    serverId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'area_entities';
  @override
  VerificationContext validateIntegrity(
    Insertable<AreaEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ha_id')) {
      context.handle(
        _haIdMeta,
        haId.isAcceptableOrUnknown(data['ha_id']!, _haIdMeta),
      );
    } else if (isInserting) {
      context.missing(_haIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('background')) {
      context.handle(
        _backgroundMeta,
        background.isAcceptableOrUnknown(data['background']!, _backgroundMeta),
      );
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {serverId, haId},
  ];
  @override
  AreaEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AreaEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      haId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ha_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      background: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}background'],
      ),
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      ),
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
    );
  }

  @override
  $AreaEntitiesTable createAlias(String alias) {
    return $AreaEntitiesTable(attachedDatabase, alias);
  }
}

class AreaEntity extends DataClass implements Insertable<AreaEntity> {
  /// Auto-incrementing primary key (local database ID)
  final int id;

  /// Home Assistant unique identifier (e.g., "living_room")
  final String haId;

  /// Display name for the area (e.g., "Living Room")
  final String name;

  /// Optional background color/gradient for UI (hex color or gradient string)
  final String? background;

  /// Optional custom image URL for area representation
  final String? image;

  /// Foreign key reference to [ServerEntities]
  /// Cascades: deleting a server deletes all its areas
  final int serverId;
  const AreaEntity({
    required this.id,
    required this.haId,
    required this.name,
    this.background,
    this.image,
    required this.serverId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ha_id'] = Variable<String>(haId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || background != null) {
      map['background'] = Variable<String>(background);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    map['server_id'] = Variable<int>(serverId);
    return map;
  }

  AreaEntitiesCompanion toCompanion(bool nullToAbsent) {
    return AreaEntitiesCompanion(
      id: Value(id),
      haId: Value(haId),
      name: Value(name),
      background: background == null && nullToAbsent
          ? const Value.absent()
          : Value(background),
      image: image == null && nullToAbsent
          ? const Value.absent()
          : Value(image),
      serverId: Value(serverId),
    );
  }

  factory AreaEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AreaEntity(
      id: serializer.fromJson<int>(json['id']),
      haId: serializer.fromJson<String>(json['haId']),
      name: serializer.fromJson<String>(json['name']),
      background: serializer.fromJson<String?>(json['background']),
      image: serializer.fromJson<String?>(json['image']),
      serverId: serializer.fromJson<int>(json['serverId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'haId': serializer.toJson<String>(haId),
      'name': serializer.toJson<String>(name),
      'background': serializer.toJson<String?>(background),
      'image': serializer.toJson<String?>(image),
      'serverId': serializer.toJson<int>(serverId),
    };
  }

  AreaEntity copyWith({
    int? id,
    String? haId,
    String? name,
    Value<String?> background = const Value.absent(),
    Value<String?> image = const Value.absent(),
    int? serverId,
  }) => AreaEntity(
    id: id ?? this.id,
    haId: haId ?? this.haId,
    name: name ?? this.name,
    background: background.present ? background.value : this.background,
    image: image.present ? image.value : this.image,
    serverId: serverId ?? this.serverId,
  );
  AreaEntity copyWithCompanion(AreaEntitiesCompanion data) {
    return AreaEntity(
      id: data.id.present ? data.id.value : this.id,
      haId: data.haId.present ? data.haId.value : this.haId,
      name: data.name.present ? data.name.value : this.name,
      background: data.background.present
          ? data.background.value
          : this.background,
      image: data.image.present ? data.image.value : this.image,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AreaEntity(')
          ..write('id: $id, ')
          ..write('haId: $haId, ')
          ..write('name: $name, ')
          ..write('background: $background, ')
          ..write('image: $image, ')
          ..write('serverId: $serverId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, haId, name, background, image, serverId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AreaEntity &&
          other.id == this.id &&
          other.haId == this.haId &&
          other.name == this.name &&
          other.background == this.background &&
          other.image == this.image &&
          other.serverId == this.serverId);
}

class AreaEntitiesCompanion extends UpdateCompanion<AreaEntity> {
  final Value<int> id;
  final Value<String> haId;
  final Value<String> name;
  final Value<String?> background;
  final Value<String?> image;
  final Value<int> serverId;
  const AreaEntitiesCompanion({
    this.id = const Value.absent(),
    this.haId = const Value.absent(),
    this.name = const Value.absent(),
    this.background = const Value.absent(),
    this.image = const Value.absent(),
    this.serverId = const Value.absent(),
  });
  AreaEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String haId,
    required String name,
    this.background = const Value.absent(),
    this.image = const Value.absent(),
    required int serverId,
  }) : haId = Value(haId),
       name = Value(name),
       serverId = Value(serverId);
  static Insertable<AreaEntity> custom({
    Expression<int>? id,
    Expression<String>? haId,
    Expression<String>? name,
    Expression<String>? background,
    Expression<String>? image,
    Expression<int>? serverId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (haId != null) 'ha_id': haId,
      if (name != null) 'name': name,
      if (background != null) 'background': background,
      if (image != null) 'image': image,
      if (serverId != null) 'server_id': serverId,
    });
  }

  AreaEntitiesCompanion copyWith({
    Value<int>? id,
    Value<String>? haId,
    Value<String>? name,
    Value<String?>? background,
    Value<String?>? image,
    Value<int>? serverId,
  }) {
    return AreaEntitiesCompanion(
      id: id ?? this.id,
      haId: haId ?? this.haId,
      name: name ?? this.name,
      background: background ?? this.background,
      image: image ?? this.image,
      serverId: serverId ?? this.serverId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (haId.present) {
      map['ha_id'] = Variable<String>(haId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (background.present) {
      map['background'] = Variable<String>(background.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AreaEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('haId: $haId, ')
          ..write('name: $name, ')
          ..write('background: $background, ')
          ..write('image: $image, ')
          ..write('serverId: $serverId')
          ..write(')'))
        .toString();
  }
}

class $DeviceEntitiesTable extends DeviceEntities
    with TableInfo<$DeviceEntitiesTable, DeviceEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _haIdMeta = const VerificationMeta('haId');
  @override
  late final GeneratedColumn<String> haId = GeneratedColumn<String>(
    'ha_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES server_entities (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, haId, name, type, serverId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_entities';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeviceEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ha_id')) {
      context.handle(
        _haIdMeta,
        haId.isAcceptableOrUnknown(data['ha_id']!, _haIdMeta),
      );
    } else if (isInserting) {
      context.missing(_haIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeviceEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      haId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ha_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
    );
  }

  @override
  $DeviceEntitiesTable createAlias(String alias) {
    return $DeviceEntitiesTable(attachedDatabase, alias);
  }
}

class DeviceEntity extends DataClass implements Insertable<DeviceEntity> {
  /// Auto-incrementing primary key (local database ID)
  final int id;

  /// Home Assistant entity ID (e.g., "light.living_room_lamp")
  final String haId;

  /// Display name for the device (e.g., "Living Room Lamp")
  final String name;

  /// Device domain/type (e.g., "light", "switch", "media_player", "sensor")
  final String type;

  /// Foreign key reference to [ServerEntities]
  /// Cascades: deleting a server deletes all its devices
  final int serverId;
  const DeviceEntity({
    required this.id,
    required this.haId,
    required this.name,
    required this.type,
    required this.serverId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ha_id'] = Variable<String>(haId);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['server_id'] = Variable<int>(serverId);
    return map;
  }

  DeviceEntitiesCompanion toCompanion(bool nullToAbsent) {
    return DeviceEntitiesCompanion(
      id: Value(id),
      haId: Value(haId),
      name: Value(name),
      type: Value(type),
      serverId: Value(serverId),
    );
  }

  factory DeviceEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceEntity(
      id: serializer.fromJson<int>(json['id']),
      haId: serializer.fromJson<String>(json['haId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      serverId: serializer.fromJson<int>(json['serverId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'haId': serializer.toJson<String>(haId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'serverId': serializer.toJson<int>(serverId),
    };
  }

  DeviceEntity copyWith({
    int? id,
    String? haId,
    String? name,
    String? type,
    int? serverId,
  }) => DeviceEntity(
    id: id ?? this.id,
    haId: haId ?? this.haId,
    name: name ?? this.name,
    type: type ?? this.type,
    serverId: serverId ?? this.serverId,
  );
  DeviceEntity copyWithCompanion(DeviceEntitiesCompanion data) {
    return DeviceEntity(
      id: data.id.present ? data.id.value : this.id,
      haId: data.haId.present ? data.haId.value : this.haId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceEntity(')
          ..write('id: $id, ')
          ..write('haId: $haId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('serverId: $serverId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, haId, name, type, serverId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceEntity &&
          other.id == this.id &&
          other.haId == this.haId &&
          other.name == this.name &&
          other.type == this.type &&
          other.serverId == this.serverId);
}

class DeviceEntitiesCompanion extends UpdateCompanion<DeviceEntity> {
  final Value<int> id;
  final Value<String> haId;
  final Value<String> name;
  final Value<String> type;
  final Value<int> serverId;
  const DeviceEntitiesCompanion({
    this.id = const Value.absent(),
    this.haId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.serverId = const Value.absent(),
  });
  DeviceEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String haId,
    required String name,
    required String type,
    required int serverId,
  }) : haId = Value(haId),
       name = Value(name),
       type = Value(type),
       serverId = Value(serverId);
  static Insertable<DeviceEntity> custom({
    Expression<int>? id,
    Expression<String>? haId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? serverId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (haId != null) 'ha_id': haId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (serverId != null) 'server_id': serverId,
    });
  }

  DeviceEntitiesCompanion copyWith({
    Value<int>? id,
    Value<String>? haId,
    Value<String>? name,
    Value<String>? type,
    Value<int>? serverId,
  }) {
    return DeviceEntitiesCompanion(
      id: id ?? this.id,
      haId: haId ?? this.haId,
      name: name ?? this.name,
      type: type ?? this.type,
      serverId: serverId ?? this.serverId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (haId.present) {
      map['ha_id'] = Variable<String>(haId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('haId: $haId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('serverId: $serverId')
          ..write(')'))
        .toString();
  }
}

class $DeviceAreaConfigsTable extends DeviceAreaConfigs
    with TableInfo<$DeviceAreaConfigsTable, DeviceAreaConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceAreaConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<int> deviceId = GeneratedColumn<int>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES device_entities (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _areaIdMeta = const VerificationMeta('areaId');
  @override
  late final GeneratedColumn<int> areaId = GeneratedColumn<int>(
    'area_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES area_entities (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, deviceId, areaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_area_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeviceAreaConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('area_id')) {
      context.handle(
        _areaIdMeta,
        areaId.isAcceptableOrUnknown(data['area_id']!, _areaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_areaIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {deviceId, areaId},
  ];
  @override
  DeviceAreaConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceAreaConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}device_id'],
      )!,
      areaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}area_id'],
      )!,
    );
  }

  @override
  $DeviceAreaConfigsTable createAlias(String alias) {
    return $DeviceAreaConfigsTable(attachedDatabase, alias);
  }
}

class DeviceAreaConfig extends DataClass
    implements Insertable<DeviceAreaConfig> {
  /// Auto-incrementing primary key
  final int id;

  /// Foreign key reference to [DeviceEntities]
  /// Cascades: deleting a device removes all its area associations
  final int deviceId;

  /// Foreign key reference to [AreaEntities]
  /// Cascades: deleting an area removes all its device associations
  final int areaId;
  const DeviceAreaConfig({
    required this.id,
    required this.deviceId,
    required this.areaId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['device_id'] = Variable<int>(deviceId);
    map['area_id'] = Variable<int>(areaId);
    return map;
  }

  DeviceAreaConfigsCompanion toCompanion(bool nullToAbsent) {
    return DeviceAreaConfigsCompanion(
      id: Value(id),
      deviceId: Value(deviceId),
      areaId: Value(areaId),
    );
  }

  factory DeviceAreaConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceAreaConfig(
      id: serializer.fromJson<int>(json['id']),
      deviceId: serializer.fromJson<int>(json['deviceId']),
      areaId: serializer.fromJson<int>(json['areaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deviceId': serializer.toJson<int>(deviceId),
      'areaId': serializer.toJson<int>(areaId),
    };
  }

  DeviceAreaConfig copyWith({int? id, int? deviceId, int? areaId}) =>
      DeviceAreaConfig(
        id: id ?? this.id,
        deviceId: deviceId ?? this.deviceId,
        areaId: areaId ?? this.areaId,
      );
  DeviceAreaConfig copyWithCompanion(DeviceAreaConfigsCompanion data) {
    return DeviceAreaConfig(
      id: data.id.present ? data.id.value : this.id,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      areaId: data.areaId.present ? data.areaId.value : this.areaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceAreaConfig(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('areaId: $areaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, deviceId, areaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceAreaConfig &&
          other.id == this.id &&
          other.deviceId == this.deviceId &&
          other.areaId == this.areaId);
}

class DeviceAreaConfigsCompanion extends UpdateCompanion<DeviceAreaConfig> {
  final Value<int> id;
  final Value<int> deviceId;
  final Value<int> areaId;
  const DeviceAreaConfigsCompanion({
    this.id = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.areaId = const Value.absent(),
  });
  DeviceAreaConfigsCompanion.insert({
    this.id = const Value.absent(),
    required int deviceId,
    required int areaId,
  }) : deviceId = Value(deviceId),
       areaId = Value(areaId);
  static Insertable<DeviceAreaConfig> custom({
    Expression<int>? id,
    Expression<int>? deviceId,
    Expression<int>? areaId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deviceId != null) 'device_id': deviceId,
      if (areaId != null) 'area_id': areaId,
    });
  }

  DeviceAreaConfigsCompanion copyWith({
    Value<int>? id,
    Value<int>? deviceId,
    Value<int>? areaId,
  }) {
    return DeviceAreaConfigsCompanion(
      id: id ?? this.id,
      deviceId: deviceId ?? this.deviceId,
      areaId: areaId ?? this.areaId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<int>(deviceId.value);
    }
    if (areaId.present) {
      map['area_id'] = Variable<int>(areaId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceAreaConfigsCompanion(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('areaId: $areaId')
          ..write(')'))
        .toString();
  }
}

class $HomeViewConfigsTable extends HomeViewConfigs
    with TableInfo<$HomeViewConfigsTable, HomeViewConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HomeViewConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES server_entities (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, serverId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'home_view_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<HomeViewConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HomeViewConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HomeViewConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
    );
  }

  @override
  $HomeViewConfigsTable createAlias(String alias) {
    return $HomeViewConfigsTable(attachedDatabase, alias);
  }
}

class HomeViewConfig extends DataClass implements Insertable<HomeViewConfig> {
  /// Auto-incrementing primary key
  final int id;

  /// Foreign key reference to [ServerEntities]
  /// UNIQUE constraint enforces 1:1 relationship - one config per server
  /// Cascades: deleting a server deletes its home view configuration
  final int serverId;
  const HomeViewConfig({required this.id, required this.serverId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<int>(serverId);
    return map;
  }

  HomeViewConfigsCompanion toCompanion(bool nullToAbsent) {
    return HomeViewConfigsCompanion(id: Value(id), serverId: Value(serverId));
  }

  factory HomeViewConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HomeViewConfig(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<int>(json['serverId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<int>(serverId),
    };
  }

  HomeViewConfig copyWith({int? id, int? serverId}) =>
      HomeViewConfig(id: id ?? this.id, serverId: serverId ?? this.serverId);
  HomeViewConfig copyWithCompanion(HomeViewConfigsCompanion data) {
    return HomeViewConfig(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HomeViewConfig(')
          ..write('id: $id, ')
          ..write('serverId: $serverId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, serverId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeViewConfig &&
          other.id == this.id &&
          other.serverId == this.serverId);
}

class HomeViewConfigsCompanion extends UpdateCompanion<HomeViewConfig> {
  final Value<int> id;
  final Value<int> serverId;
  const HomeViewConfigsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
  });
  HomeViewConfigsCompanion.insert({
    this.id = const Value.absent(),
    required int serverId,
  }) : serverId = Value(serverId);
  static Insertable<HomeViewConfig> custom({
    Expression<int>? id,
    Expression<int>? serverId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
    });
  }

  HomeViewConfigsCompanion copyWith({Value<int>? id, Value<int>? serverId}) {
    return HomeViewConfigsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HomeViewConfigsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId')
          ..write(')'))
        .toString();
  }
}

class $AreaHomeConfigsTable extends AreaHomeConfigs
    with TableInfo<$AreaHomeConfigsTable, AreaHomeConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AreaHomeConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _areaIdMeta = const VerificationMeta('areaId');
  @override
  late final GeneratedColumn<int> areaId = GeneratedColumn<int>(
    'area_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES area_entities (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _homeConfigIdMeta = const VerificationMeta(
    'homeConfigId',
  );
  @override
  late final GeneratedColumn<int> homeConfigId = GeneratedColumn<int>(
    'home_config_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES home_view_configs (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, order, areaId, homeConfigId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'area_home_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AreaHomeConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('area_id')) {
      context.handle(
        _areaIdMeta,
        areaId.isAcceptableOrUnknown(data['area_id']!, _areaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_areaIdMeta);
    }
    if (data.containsKey('home_config_id')) {
      context.handle(
        _homeConfigIdMeta,
        homeConfigId.isAcceptableOrUnknown(
          data['home_config_id']!,
          _homeConfigIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_homeConfigIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {homeConfigId, areaId},
  ];
  @override
  AreaHomeConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AreaHomeConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      areaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}area_id'],
      )!,
      homeConfigId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}home_config_id'],
      )!,
    );
  }

  @override
  $AreaHomeConfigsTable createAlias(String alias) {
    return $AreaHomeConfigsTable(attachedDatabase, alias);
  }
}

class AreaHomeConfig extends DataClass implements Insertable<AreaHomeConfig> {
  /// Auto-incrementing primary key
  final int id;

  /// Sort order in home view (lower number = displayed first)
  final int order;

  /// Foreign key reference to [AreaEntities]
  /// Cascades: deleting an area removes it from home view config
  final int areaId;

  /// Foreign key reference to [HomeViewConfigs]
  /// Cascades: deleting home config removes all area configurations
  final int homeConfigId;
  const AreaHomeConfig({
    required this.id,
    required this.order,
    required this.areaId,
    required this.homeConfigId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order'] = Variable<int>(order);
    map['area_id'] = Variable<int>(areaId);
    map['home_config_id'] = Variable<int>(homeConfigId);
    return map;
  }

  AreaHomeConfigsCompanion toCompanion(bool nullToAbsent) {
    return AreaHomeConfigsCompanion(
      id: Value(id),
      order: Value(order),
      areaId: Value(areaId),
      homeConfigId: Value(homeConfigId),
    );
  }

  factory AreaHomeConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AreaHomeConfig(
      id: serializer.fromJson<int>(json['id']),
      order: serializer.fromJson<int>(json['order']),
      areaId: serializer.fromJson<int>(json['areaId']),
      homeConfigId: serializer.fromJson<int>(json['homeConfigId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'order': serializer.toJson<int>(order),
      'areaId': serializer.toJson<int>(areaId),
      'homeConfigId': serializer.toJson<int>(homeConfigId),
    };
  }

  AreaHomeConfig copyWith({
    int? id,
    int? order,
    int? areaId,
    int? homeConfigId,
  }) => AreaHomeConfig(
    id: id ?? this.id,
    order: order ?? this.order,
    areaId: areaId ?? this.areaId,
    homeConfigId: homeConfigId ?? this.homeConfigId,
  );
  AreaHomeConfig copyWithCompanion(AreaHomeConfigsCompanion data) {
    return AreaHomeConfig(
      id: data.id.present ? data.id.value : this.id,
      order: data.order.present ? data.order.value : this.order,
      areaId: data.areaId.present ? data.areaId.value : this.areaId,
      homeConfigId: data.homeConfigId.present
          ? data.homeConfigId.value
          : this.homeConfigId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AreaHomeConfig(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('areaId: $areaId, ')
          ..write('homeConfigId: $homeConfigId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, order, areaId, homeConfigId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AreaHomeConfig &&
          other.id == this.id &&
          other.order == this.order &&
          other.areaId == this.areaId &&
          other.homeConfigId == this.homeConfigId);
}

class AreaHomeConfigsCompanion extends UpdateCompanion<AreaHomeConfig> {
  final Value<int> id;
  final Value<int> order;
  final Value<int> areaId;
  final Value<int> homeConfigId;
  const AreaHomeConfigsCompanion({
    this.id = const Value.absent(),
    this.order = const Value.absent(),
    this.areaId = const Value.absent(),
    this.homeConfigId = const Value.absent(),
  });
  AreaHomeConfigsCompanion.insert({
    this.id = const Value.absent(),
    required int order,
    required int areaId,
    required int homeConfigId,
  }) : order = Value(order),
       areaId = Value(areaId),
       homeConfigId = Value(homeConfigId);
  static Insertable<AreaHomeConfig> custom({
    Expression<int>? id,
    Expression<int>? order,
    Expression<int>? areaId,
    Expression<int>? homeConfigId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (order != null) 'order': order,
      if (areaId != null) 'area_id': areaId,
      if (homeConfigId != null) 'home_config_id': homeConfigId,
    });
  }

  AreaHomeConfigsCompanion copyWith({
    Value<int>? id,
    Value<int>? order,
    Value<int>? areaId,
    Value<int>? homeConfigId,
  }) {
    return AreaHomeConfigsCompanion(
      id: id ?? this.id,
      order: order ?? this.order,
      areaId: areaId ?? this.areaId,
      homeConfigId: homeConfigId ?? this.homeConfigId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (areaId.present) {
      map['area_id'] = Variable<int>(areaId.value);
    }
    if (homeConfigId.present) {
      map['home_config_id'] = Variable<int>(homeConfigId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AreaHomeConfigsCompanion(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('areaId: $areaId, ')
          ..write('homeConfigId: $homeConfigId')
          ..write(')'))
        .toString();
  }
}

class $DeviceHomeConfigsTable extends DeviceHomeConfigs
    with TableInfo<$DeviceHomeConfigsTable, DeviceHomeConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceHomeConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DeviceDisplaySizeDb, int> size =
      GeneratedColumn<int>(
        'size',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<DeviceDisplaySizeDb>(
        $DeviceHomeConfigsTable.$convertersize,
      );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<int> deviceId = GeneratedColumn<int>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES device_entities (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _areaConfigIdMeta = const VerificationMeta(
    'areaConfigId',
  );
  @override
  late final GeneratedColumn<int> areaConfigId = GeneratedColumn<int>(
    'area_config_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES area_home_configs (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    order,
    size,
    deviceId,
    areaConfigId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_home_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeviceHomeConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('area_config_id')) {
      context.handle(
        _areaConfigIdMeta,
        areaConfigId.isAcceptableOrUnknown(
          data['area_config_id']!,
          _areaConfigIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_areaConfigIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {areaConfigId, deviceId},
  ];
  @override
  DeviceHomeConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceHomeConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      size: $DeviceHomeConfigsTable.$convertersize.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}size'],
        )!,
      ),
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}device_id'],
      )!,
      areaConfigId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}area_config_id'],
      )!,
    );
  }

  @override
  $DeviceHomeConfigsTable createAlias(String alias) {
    return $DeviceHomeConfigsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DeviceDisplaySizeDb, int, int> $convertersize =
      const EnumIndexConverter<DeviceDisplaySizeDb>(DeviceDisplaySizeDb.values);
}

class DeviceHomeConfig extends DataClass
    implements Insertable<DeviceHomeConfig> {
  /// Auto-incrementing primary key
  final int id;

  /// Sort order within the area section (lower number = displayed first)
  final int order;

  /// Display size for device tile ([DeviceDisplaySizeDb.small] or [DeviceDisplaySizeDb.big])
  final DeviceDisplaySizeDb size;

  /// Foreign key reference to [DeviceEntities]
  /// Cascades: deleting a device removes it from home view config
  final int deviceId;

  /// Foreign key reference to [AreaHomeConfigs]
  /// Cascades: deleting area config removes all device configurations
  final int areaConfigId;
  const DeviceHomeConfig({
    required this.id,
    required this.order,
    required this.size,
    required this.deviceId,
    required this.areaConfigId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order'] = Variable<int>(order);
    {
      map['size'] = Variable<int>(
        $DeviceHomeConfigsTable.$convertersize.toSql(size),
      );
    }
    map['device_id'] = Variable<int>(deviceId);
    map['area_config_id'] = Variable<int>(areaConfigId);
    return map;
  }

  DeviceHomeConfigsCompanion toCompanion(bool nullToAbsent) {
    return DeviceHomeConfigsCompanion(
      id: Value(id),
      order: Value(order),
      size: Value(size),
      deviceId: Value(deviceId),
      areaConfigId: Value(areaConfigId),
    );
  }

  factory DeviceHomeConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceHomeConfig(
      id: serializer.fromJson<int>(json['id']),
      order: serializer.fromJson<int>(json['order']),
      size: $DeviceHomeConfigsTable.$convertersize.fromJson(
        serializer.fromJson<int>(json['size']),
      ),
      deviceId: serializer.fromJson<int>(json['deviceId']),
      areaConfigId: serializer.fromJson<int>(json['areaConfigId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'order': serializer.toJson<int>(order),
      'size': serializer.toJson<int>(
        $DeviceHomeConfigsTable.$convertersize.toJson(size),
      ),
      'deviceId': serializer.toJson<int>(deviceId),
      'areaConfigId': serializer.toJson<int>(areaConfigId),
    };
  }

  DeviceHomeConfig copyWith({
    int? id,
    int? order,
    DeviceDisplaySizeDb? size,
    int? deviceId,
    int? areaConfigId,
  }) => DeviceHomeConfig(
    id: id ?? this.id,
    order: order ?? this.order,
    size: size ?? this.size,
    deviceId: deviceId ?? this.deviceId,
    areaConfigId: areaConfigId ?? this.areaConfigId,
  );
  DeviceHomeConfig copyWithCompanion(DeviceHomeConfigsCompanion data) {
    return DeviceHomeConfig(
      id: data.id.present ? data.id.value : this.id,
      order: data.order.present ? data.order.value : this.order,
      size: data.size.present ? data.size.value : this.size,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      areaConfigId: data.areaConfigId.present
          ? data.areaConfigId.value
          : this.areaConfigId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceHomeConfig(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('size: $size, ')
          ..write('deviceId: $deviceId, ')
          ..write('areaConfigId: $areaConfigId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, order, size, deviceId, areaConfigId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceHomeConfig &&
          other.id == this.id &&
          other.order == this.order &&
          other.size == this.size &&
          other.deviceId == this.deviceId &&
          other.areaConfigId == this.areaConfigId);
}

class DeviceHomeConfigsCompanion extends UpdateCompanion<DeviceHomeConfig> {
  final Value<int> id;
  final Value<int> order;
  final Value<DeviceDisplaySizeDb> size;
  final Value<int> deviceId;
  final Value<int> areaConfigId;
  const DeviceHomeConfigsCompanion({
    this.id = const Value.absent(),
    this.order = const Value.absent(),
    this.size = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.areaConfigId = const Value.absent(),
  });
  DeviceHomeConfigsCompanion.insert({
    this.id = const Value.absent(),
    required int order,
    required DeviceDisplaySizeDb size,
    required int deviceId,
    required int areaConfigId,
  }) : order = Value(order),
       size = Value(size),
       deviceId = Value(deviceId),
       areaConfigId = Value(areaConfigId);
  static Insertable<DeviceHomeConfig> custom({
    Expression<int>? id,
    Expression<int>? order,
    Expression<int>? size,
    Expression<int>? deviceId,
    Expression<int>? areaConfigId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (order != null) 'order': order,
      if (size != null) 'size': size,
      if (deviceId != null) 'device_id': deviceId,
      if (areaConfigId != null) 'area_config_id': areaConfigId,
    });
  }

  DeviceHomeConfigsCompanion copyWith({
    Value<int>? id,
    Value<int>? order,
    Value<DeviceDisplaySizeDb>? size,
    Value<int>? deviceId,
    Value<int>? areaConfigId,
  }) {
    return DeviceHomeConfigsCompanion(
      id: id ?? this.id,
      order: order ?? this.order,
      size: size ?? this.size,
      deviceId: deviceId ?? this.deviceId,
      areaConfigId: areaConfigId ?? this.areaConfigId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(
        $DeviceHomeConfigsTable.$convertersize.toSql(size.value),
      );
    }
    if (deviceId.present) {
      map['device_id'] = Variable<int>(deviceId.value);
    }
    if (areaConfigId.present) {
      map['area_config_id'] = Variable<int>(areaConfigId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceHomeConfigsCompanion(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('size: $size, ')
          ..write('deviceId: $deviceId, ')
          ..write('areaConfigId: $areaConfigId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ServerEntitiesTable serverEntities = $ServerEntitiesTable(this);
  late final $AreaEntitiesTable areaEntities = $AreaEntitiesTable(this);
  late final $DeviceEntitiesTable deviceEntities = $DeviceEntitiesTable(this);
  late final $DeviceAreaConfigsTable deviceAreaConfigs =
      $DeviceAreaConfigsTable(this);
  late final $HomeViewConfigsTable homeViewConfigs = $HomeViewConfigsTable(
    this,
  );
  late final $AreaHomeConfigsTable areaHomeConfigs = $AreaHomeConfigsTable(
    this,
  );
  late final $DeviceHomeConfigsTable deviceHomeConfigs =
      $DeviceHomeConfigsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    serverEntities,
    areaEntities,
    deviceEntities,
    deviceAreaConfigs,
    homeViewConfigs,
    areaHomeConfigs,
    deviceHomeConfigs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'server_entities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('area_entities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'server_entities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('device_entities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'device_entities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('device_area_configs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'area_entities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('device_area_configs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'server_entities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('home_view_configs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'area_entities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('area_home_configs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'home_view_configs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('area_home_configs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'device_entities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('device_home_configs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'area_home_configs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('device_home_configs', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ServerEntitiesTableCreateCompanionBuilder =
    ServerEntitiesCompanion Function({
      Value<int> id,
      required String name,
      Value<bool> isActive,
      required String url,
      Value<String?> version,
    });
typedef $$ServerEntitiesTableUpdateCompanionBuilder =
    ServerEntitiesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<bool> isActive,
      Value<String> url,
      Value<String?> version,
    });

final class $$ServerEntitiesTableReferences
    extends BaseReferences<_$AppDatabase, $ServerEntitiesTable, ServerEntity> {
  $$ServerEntitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$AreaEntitiesTable, List<AreaEntity>>
  _areaEntitiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.areaEntities,
    aliasName: $_aliasNameGenerator(
      db.serverEntities.id,
      db.areaEntities.serverId,
    ),
  );

  $$AreaEntitiesTableProcessedTableManager get areaEntitiesRefs {
    final manager = $$AreaEntitiesTableTableManager(
      $_db,
      $_db.areaEntities,
    ).filter((f) => f.serverId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_areaEntitiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DeviceEntitiesTable, List<DeviceEntity>>
  _deviceEntitiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.deviceEntities,
    aliasName: $_aliasNameGenerator(
      db.serverEntities.id,
      db.deviceEntities.serverId,
    ),
  );

  $$DeviceEntitiesTableProcessedTableManager get deviceEntitiesRefs {
    final manager = $$DeviceEntitiesTableTableManager(
      $_db,
      $_db.deviceEntities,
    ).filter((f) => f.serverId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_deviceEntitiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HomeViewConfigsTable, List<HomeViewConfig>>
  _homeViewConfigsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.homeViewConfigs,
    aliasName: $_aliasNameGenerator(
      db.serverEntities.id,
      db.homeViewConfigs.serverId,
    ),
  );

  $$HomeViewConfigsTableProcessedTableManager get homeViewConfigsRefs {
    final manager = $$HomeViewConfigsTableTableManager(
      $_db,
      $_db.homeViewConfigs,
    ).filter((f) => f.serverId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _homeViewConfigsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ServerEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ServerEntitiesTable> {
  $$ServerEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> areaEntitiesRefs(
    Expression<bool> Function($$AreaEntitiesTableFilterComposer f) f,
  ) {
    final $$AreaEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.areaEntities,
      getReferencedColumn: (t) => t.serverId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.areaEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> deviceEntitiesRefs(
    Expression<bool> Function($$DeviceEntitiesTableFilterComposer f) f,
  ) {
    final $$DeviceEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceEntities,
      getReferencedColumn: (t) => t.serverId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.deviceEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> homeViewConfigsRefs(
    Expression<bool> Function($$HomeViewConfigsTableFilterComposer f) f,
  ) {
    final $$HomeViewConfigsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.homeViewConfigs,
      getReferencedColumn: (t) => t.serverId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HomeViewConfigsTableFilterComposer(
            $db: $db,
            $table: $db.homeViewConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ServerEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ServerEntitiesTable> {
  $$ServerEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServerEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServerEntitiesTable> {
  $$ServerEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  Expression<T> areaEntitiesRefs<T extends Object>(
    Expression<T> Function($$AreaEntitiesTableAnnotationComposer a) f,
  ) {
    final $$AreaEntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.areaEntities,
      getReferencedColumn: (t) => t.serverId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaEntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.areaEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> deviceEntitiesRefs<T extends Object>(
    Expression<T> Function($$DeviceEntitiesTableAnnotationComposer a) f,
  ) {
    final $$DeviceEntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceEntities,
      getReferencedColumn: (t) => t.serverId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceEntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.deviceEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> homeViewConfigsRefs<T extends Object>(
    Expression<T> Function($$HomeViewConfigsTableAnnotationComposer a) f,
  ) {
    final $$HomeViewConfigsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.homeViewConfigs,
      getReferencedColumn: (t) => t.serverId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HomeViewConfigsTableAnnotationComposer(
            $db: $db,
            $table: $db.homeViewConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ServerEntitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServerEntitiesTable,
          ServerEntity,
          $$ServerEntitiesTableFilterComposer,
          $$ServerEntitiesTableOrderingComposer,
          $$ServerEntitiesTableAnnotationComposer,
          $$ServerEntitiesTableCreateCompanionBuilder,
          $$ServerEntitiesTableUpdateCompanionBuilder,
          (ServerEntity, $$ServerEntitiesTableReferences),
          ServerEntity,
          PrefetchHooks Function({
            bool areaEntitiesRefs,
            bool deviceEntitiesRefs,
            bool homeViewConfigsRefs,
          })
        > {
  $$ServerEntitiesTableTableManager(
    _$AppDatabase db,
    $ServerEntitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServerEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServerEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServerEntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String?> version = const Value.absent(),
              }) => ServerEntitiesCompanion(
                id: id,
                name: name,
                isActive: isActive,
                url: url,
                version: version,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<bool> isActive = const Value.absent(),
                required String url,
                Value<String?> version = const Value.absent(),
              }) => ServerEntitiesCompanion.insert(
                id: id,
                name: name,
                isActive: isActive,
                url: url,
                version: version,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ServerEntitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                areaEntitiesRefs = false,
                deviceEntitiesRefs = false,
                homeViewConfigsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (areaEntitiesRefs) db.areaEntities,
                    if (deviceEntitiesRefs) db.deviceEntities,
                    if (homeViewConfigsRefs) db.homeViewConfigs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (areaEntitiesRefs)
                        await $_getPrefetchedData<
                          ServerEntity,
                          $ServerEntitiesTable,
                          AreaEntity
                        >(
                          currentTable: table,
                          referencedTable: $$ServerEntitiesTableReferences
                              ._areaEntitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ServerEntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).areaEntitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.serverId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (deviceEntitiesRefs)
                        await $_getPrefetchedData<
                          ServerEntity,
                          $ServerEntitiesTable,
                          DeviceEntity
                        >(
                          currentTable: table,
                          referencedTable: $$ServerEntitiesTableReferences
                              ._deviceEntitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ServerEntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).deviceEntitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.serverId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (homeViewConfigsRefs)
                        await $_getPrefetchedData<
                          ServerEntity,
                          $ServerEntitiesTable,
                          HomeViewConfig
                        >(
                          currentTable: table,
                          referencedTable: $$ServerEntitiesTableReferences
                              ._homeViewConfigsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ServerEntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).homeViewConfigsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.serverId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ServerEntitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServerEntitiesTable,
      ServerEntity,
      $$ServerEntitiesTableFilterComposer,
      $$ServerEntitiesTableOrderingComposer,
      $$ServerEntitiesTableAnnotationComposer,
      $$ServerEntitiesTableCreateCompanionBuilder,
      $$ServerEntitiesTableUpdateCompanionBuilder,
      (ServerEntity, $$ServerEntitiesTableReferences),
      ServerEntity,
      PrefetchHooks Function({
        bool areaEntitiesRefs,
        bool deviceEntitiesRefs,
        bool homeViewConfigsRefs,
      })
    >;
typedef $$AreaEntitiesTableCreateCompanionBuilder =
    AreaEntitiesCompanion Function({
      Value<int> id,
      required String haId,
      required String name,
      Value<String?> background,
      Value<String?> image,
      required int serverId,
    });
typedef $$AreaEntitiesTableUpdateCompanionBuilder =
    AreaEntitiesCompanion Function({
      Value<int> id,
      Value<String> haId,
      Value<String> name,
      Value<String?> background,
      Value<String?> image,
      Value<int> serverId,
    });

final class $$AreaEntitiesTableReferences
    extends BaseReferences<_$AppDatabase, $AreaEntitiesTable, AreaEntity> {
  $$AreaEntitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ServerEntitiesTable _serverIdTable(_$AppDatabase db) =>
      db.serverEntities.createAlias(
        $_aliasNameGenerator(db.areaEntities.serverId, db.serverEntities.id),
      );

  $$ServerEntitiesTableProcessedTableManager get serverId {
    final $_column = $_itemColumn<int>('server_id')!;

    final manager = $$ServerEntitiesTableTableManager(
      $_db,
      $_db.serverEntities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_serverIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DeviceAreaConfigsTable, List<DeviceAreaConfig>>
  _deviceAreaConfigsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.deviceAreaConfigs,
        aliasName: $_aliasNameGenerator(
          db.areaEntities.id,
          db.deviceAreaConfigs.areaId,
        ),
      );

  $$DeviceAreaConfigsTableProcessedTableManager get deviceAreaConfigsRefs {
    final manager = $$DeviceAreaConfigsTableTableManager(
      $_db,
      $_db.deviceAreaConfigs,
    ).filter((f) => f.areaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _deviceAreaConfigsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AreaHomeConfigsTable, List<AreaHomeConfig>>
  _areaHomeConfigsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.areaHomeConfigs,
    aliasName: $_aliasNameGenerator(
      db.areaEntities.id,
      db.areaHomeConfigs.areaId,
    ),
  );

  $$AreaHomeConfigsTableProcessedTableManager get areaHomeConfigsRefs {
    final manager = $$AreaHomeConfigsTableTableManager(
      $_db,
      $_db.areaHomeConfigs,
    ).filter((f) => f.areaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _areaHomeConfigsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AreaEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $AreaEntitiesTable> {
  $$AreaEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get haId => $composableBuilder(
    column: $table.haId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get background => $composableBuilder(
    column: $table.background,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  $$ServerEntitiesTableFilterComposer get serverId {
    final $$ServerEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.serverEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServerEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.serverEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> deviceAreaConfigsRefs(
    Expression<bool> Function($$DeviceAreaConfigsTableFilterComposer f) f,
  ) {
    final $$DeviceAreaConfigsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceAreaConfigs,
      getReferencedColumn: (t) => t.areaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceAreaConfigsTableFilterComposer(
            $db: $db,
            $table: $db.deviceAreaConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> areaHomeConfigsRefs(
    Expression<bool> Function($$AreaHomeConfigsTableFilterComposer f) f,
  ) {
    final $$AreaHomeConfigsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.areaHomeConfigs,
      getReferencedColumn: (t) => t.areaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaHomeConfigsTableFilterComposer(
            $db: $db,
            $table: $db.areaHomeConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AreaEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $AreaEntitiesTable> {
  $$AreaEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get haId => $composableBuilder(
    column: $table.haId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get background => $composableBuilder(
    column: $table.background,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  $$ServerEntitiesTableOrderingComposer get serverId {
    final $$ServerEntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.serverEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServerEntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.serverEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AreaEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AreaEntitiesTable> {
  $$AreaEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get haId =>
      $composableBuilder(column: $table.haId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get background => $composableBuilder(
    column: $table.background,
    builder: (column) => column,
  );

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  $$ServerEntitiesTableAnnotationComposer get serverId {
    final $$ServerEntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.serverEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServerEntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.serverEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> deviceAreaConfigsRefs<T extends Object>(
    Expression<T> Function($$DeviceAreaConfigsTableAnnotationComposer a) f,
  ) {
    final $$DeviceAreaConfigsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.deviceAreaConfigs,
          getReferencedColumn: (t) => t.areaId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DeviceAreaConfigsTableAnnotationComposer(
                $db: $db,
                $table: $db.deviceAreaConfigs,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> areaHomeConfigsRefs<T extends Object>(
    Expression<T> Function($$AreaHomeConfigsTableAnnotationComposer a) f,
  ) {
    final $$AreaHomeConfigsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.areaHomeConfigs,
      getReferencedColumn: (t) => t.areaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaHomeConfigsTableAnnotationComposer(
            $db: $db,
            $table: $db.areaHomeConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AreaEntitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AreaEntitiesTable,
          AreaEntity,
          $$AreaEntitiesTableFilterComposer,
          $$AreaEntitiesTableOrderingComposer,
          $$AreaEntitiesTableAnnotationComposer,
          $$AreaEntitiesTableCreateCompanionBuilder,
          $$AreaEntitiesTableUpdateCompanionBuilder,
          (AreaEntity, $$AreaEntitiesTableReferences),
          AreaEntity,
          PrefetchHooks Function({
            bool serverId,
            bool deviceAreaConfigsRefs,
            bool areaHomeConfigsRefs,
          })
        > {
  $$AreaEntitiesTableTableManager(_$AppDatabase db, $AreaEntitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AreaEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AreaEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AreaEntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> haId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> background = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<int> serverId = const Value.absent(),
              }) => AreaEntitiesCompanion(
                id: id,
                haId: haId,
                name: name,
                background: background,
                image: image,
                serverId: serverId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String haId,
                required String name,
                Value<String?> background = const Value.absent(),
                Value<String?> image = const Value.absent(),
                required int serverId,
              }) => AreaEntitiesCompanion.insert(
                id: id,
                haId: haId,
                name: name,
                background: background,
                image: image,
                serverId: serverId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AreaEntitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                serverId = false,
                deviceAreaConfigsRefs = false,
                areaHomeConfigsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (deviceAreaConfigsRefs) db.deviceAreaConfigs,
                    if (areaHomeConfigsRefs) db.areaHomeConfigs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (serverId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.serverId,
                                    referencedTable:
                                        $$AreaEntitiesTableReferences
                                            ._serverIdTable(db),
                                    referencedColumn:
                                        $$AreaEntitiesTableReferences
                                            ._serverIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (deviceAreaConfigsRefs)
                        await $_getPrefetchedData<
                          AreaEntity,
                          $AreaEntitiesTable,
                          DeviceAreaConfig
                        >(
                          currentTable: table,
                          referencedTable: $$AreaEntitiesTableReferences
                              ._deviceAreaConfigsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AreaEntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).deviceAreaConfigsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.areaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (areaHomeConfigsRefs)
                        await $_getPrefetchedData<
                          AreaEntity,
                          $AreaEntitiesTable,
                          AreaHomeConfig
                        >(
                          currentTable: table,
                          referencedTable: $$AreaEntitiesTableReferences
                              ._areaHomeConfigsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AreaEntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).areaHomeConfigsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.areaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AreaEntitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AreaEntitiesTable,
      AreaEntity,
      $$AreaEntitiesTableFilterComposer,
      $$AreaEntitiesTableOrderingComposer,
      $$AreaEntitiesTableAnnotationComposer,
      $$AreaEntitiesTableCreateCompanionBuilder,
      $$AreaEntitiesTableUpdateCompanionBuilder,
      (AreaEntity, $$AreaEntitiesTableReferences),
      AreaEntity,
      PrefetchHooks Function({
        bool serverId,
        bool deviceAreaConfigsRefs,
        bool areaHomeConfigsRefs,
      })
    >;
typedef $$DeviceEntitiesTableCreateCompanionBuilder =
    DeviceEntitiesCompanion Function({
      Value<int> id,
      required String haId,
      required String name,
      required String type,
      required int serverId,
    });
typedef $$DeviceEntitiesTableUpdateCompanionBuilder =
    DeviceEntitiesCompanion Function({
      Value<int> id,
      Value<String> haId,
      Value<String> name,
      Value<String> type,
      Value<int> serverId,
    });

final class $$DeviceEntitiesTableReferences
    extends BaseReferences<_$AppDatabase, $DeviceEntitiesTable, DeviceEntity> {
  $$DeviceEntitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ServerEntitiesTable _serverIdTable(_$AppDatabase db) =>
      db.serverEntities.createAlias(
        $_aliasNameGenerator(db.deviceEntities.serverId, db.serverEntities.id),
      );

  $$ServerEntitiesTableProcessedTableManager get serverId {
    final $_column = $_itemColumn<int>('server_id')!;

    final manager = $$ServerEntitiesTableTableManager(
      $_db,
      $_db.serverEntities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_serverIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DeviceAreaConfigsTable, List<DeviceAreaConfig>>
  _deviceAreaConfigsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.deviceAreaConfigs,
        aliasName: $_aliasNameGenerator(
          db.deviceEntities.id,
          db.deviceAreaConfigs.deviceId,
        ),
      );

  $$DeviceAreaConfigsTableProcessedTableManager get deviceAreaConfigsRefs {
    final manager = $$DeviceAreaConfigsTableTableManager(
      $_db,
      $_db.deviceAreaConfigs,
    ).filter((f) => f.deviceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _deviceAreaConfigsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DeviceHomeConfigsTable, List<DeviceHomeConfig>>
  _deviceHomeConfigsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.deviceHomeConfigs,
        aliasName: $_aliasNameGenerator(
          db.deviceEntities.id,
          db.deviceHomeConfigs.deviceId,
        ),
      );

  $$DeviceHomeConfigsTableProcessedTableManager get deviceHomeConfigsRefs {
    final manager = $$DeviceHomeConfigsTableTableManager(
      $_db,
      $_db.deviceHomeConfigs,
    ).filter((f) => f.deviceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _deviceHomeConfigsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DeviceEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $DeviceEntitiesTable> {
  $$DeviceEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get haId => $composableBuilder(
    column: $table.haId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  $$ServerEntitiesTableFilterComposer get serverId {
    final $$ServerEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.serverEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServerEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.serverEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> deviceAreaConfigsRefs(
    Expression<bool> Function($$DeviceAreaConfigsTableFilterComposer f) f,
  ) {
    final $$DeviceAreaConfigsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceAreaConfigs,
      getReferencedColumn: (t) => t.deviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceAreaConfigsTableFilterComposer(
            $db: $db,
            $table: $db.deviceAreaConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> deviceHomeConfigsRefs(
    Expression<bool> Function($$DeviceHomeConfigsTableFilterComposer f) f,
  ) {
    final $$DeviceHomeConfigsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceHomeConfigs,
      getReferencedColumn: (t) => t.deviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceHomeConfigsTableFilterComposer(
            $db: $db,
            $table: $db.deviceHomeConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DeviceEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $DeviceEntitiesTable> {
  $$DeviceEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get haId => $composableBuilder(
    column: $table.haId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  $$ServerEntitiesTableOrderingComposer get serverId {
    final $$ServerEntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.serverEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServerEntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.serverEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeviceEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeviceEntitiesTable> {
  $$DeviceEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get haId =>
      $composableBuilder(column: $table.haId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  $$ServerEntitiesTableAnnotationComposer get serverId {
    final $$ServerEntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.serverEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServerEntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.serverEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> deviceAreaConfigsRefs<T extends Object>(
    Expression<T> Function($$DeviceAreaConfigsTableAnnotationComposer a) f,
  ) {
    final $$DeviceAreaConfigsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.deviceAreaConfigs,
          getReferencedColumn: (t) => t.deviceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DeviceAreaConfigsTableAnnotationComposer(
                $db: $db,
                $table: $db.deviceAreaConfigs,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> deviceHomeConfigsRefs<T extends Object>(
    Expression<T> Function($$DeviceHomeConfigsTableAnnotationComposer a) f,
  ) {
    final $$DeviceHomeConfigsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.deviceHomeConfigs,
          getReferencedColumn: (t) => t.deviceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DeviceHomeConfigsTableAnnotationComposer(
                $db: $db,
                $table: $db.deviceHomeConfigs,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DeviceEntitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeviceEntitiesTable,
          DeviceEntity,
          $$DeviceEntitiesTableFilterComposer,
          $$DeviceEntitiesTableOrderingComposer,
          $$DeviceEntitiesTableAnnotationComposer,
          $$DeviceEntitiesTableCreateCompanionBuilder,
          $$DeviceEntitiesTableUpdateCompanionBuilder,
          (DeviceEntity, $$DeviceEntitiesTableReferences),
          DeviceEntity,
          PrefetchHooks Function({
            bool serverId,
            bool deviceAreaConfigsRefs,
            bool deviceHomeConfigsRefs,
          })
        > {
  $$DeviceEntitiesTableTableManager(
    _$AppDatabase db,
    $DeviceEntitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceEntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> haId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> serverId = const Value.absent(),
              }) => DeviceEntitiesCompanion(
                id: id,
                haId: haId,
                name: name,
                type: type,
                serverId: serverId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String haId,
                required String name,
                required String type,
                required int serverId,
              }) => DeviceEntitiesCompanion.insert(
                id: id,
                haId: haId,
                name: name,
                type: type,
                serverId: serverId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DeviceEntitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                serverId = false,
                deviceAreaConfigsRefs = false,
                deviceHomeConfigsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (deviceAreaConfigsRefs) db.deviceAreaConfigs,
                    if (deviceHomeConfigsRefs) db.deviceHomeConfigs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (serverId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.serverId,
                                    referencedTable:
                                        $$DeviceEntitiesTableReferences
                                            ._serverIdTable(db),
                                    referencedColumn:
                                        $$DeviceEntitiesTableReferences
                                            ._serverIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (deviceAreaConfigsRefs)
                        await $_getPrefetchedData<
                          DeviceEntity,
                          $DeviceEntitiesTable,
                          DeviceAreaConfig
                        >(
                          currentTable: table,
                          referencedTable: $$DeviceEntitiesTableReferences
                              ._deviceAreaConfigsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DeviceEntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).deviceAreaConfigsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deviceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (deviceHomeConfigsRefs)
                        await $_getPrefetchedData<
                          DeviceEntity,
                          $DeviceEntitiesTable,
                          DeviceHomeConfig
                        >(
                          currentTable: table,
                          referencedTable: $$DeviceEntitiesTableReferences
                              ._deviceHomeConfigsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DeviceEntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).deviceHomeConfigsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deviceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DeviceEntitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeviceEntitiesTable,
      DeviceEntity,
      $$DeviceEntitiesTableFilterComposer,
      $$DeviceEntitiesTableOrderingComposer,
      $$DeviceEntitiesTableAnnotationComposer,
      $$DeviceEntitiesTableCreateCompanionBuilder,
      $$DeviceEntitiesTableUpdateCompanionBuilder,
      (DeviceEntity, $$DeviceEntitiesTableReferences),
      DeviceEntity,
      PrefetchHooks Function({
        bool serverId,
        bool deviceAreaConfigsRefs,
        bool deviceHomeConfigsRefs,
      })
    >;
typedef $$DeviceAreaConfigsTableCreateCompanionBuilder =
    DeviceAreaConfigsCompanion Function({
      Value<int> id,
      required int deviceId,
      required int areaId,
    });
typedef $$DeviceAreaConfigsTableUpdateCompanionBuilder =
    DeviceAreaConfigsCompanion Function({
      Value<int> id,
      Value<int> deviceId,
      Value<int> areaId,
    });

final class $$DeviceAreaConfigsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DeviceAreaConfigsTable,
          DeviceAreaConfig
        > {
  $$DeviceAreaConfigsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DeviceEntitiesTable _deviceIdTable(_$AppDatabase db) =>
      db.deviceEntities.createAlias(
        $_aliasNameGenerator(
          db.deviceAreaConfigs.deviceId,
          db.deviceEntities.id,
        ),
      );

  $$DeviceEntitiesTableProcessedTableManager get deviceId {
    final $_column = $_itemColumn<int>('device_id')!;

    final manager = $$DeviceEntitiesTableTableManager(
      $_db,
      $_db.deviceEntities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deviceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AreaEntitiesTable _areaIdTable(_$AppDatabase db) =>
      db.areaEntities.createAlias(
        $_aliasNameGenerator(db.deviceAreaConfigs.areaId, db.areaEntities.id),
      );

  $$AreaEntitiesTableProcessedTableManager get areaId {
    final $_column = $_itemColumn<int>('area_id')!;

    final manager = $$AreaEntitiesTableTableManager(
      $_db,
      $_db.areaEntities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_areaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DeviceAreaConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $DeviceAreaConfigsTable> {
  $$DeviceAreaConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  $$DeviceEntitiesTableFilterComposer get deviceId {
    final $$DeviceEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceId,
      referencedTable: $db.deviceEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.deviceEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AreaEntitiesTableFilterComposer get areaId {
    final $$AreaEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areaEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.areaEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeviceAreaConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $DeviceAreaConfigsTable> {
  $$DeviceAreaConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  $$DeviceEntitiesTableOrderingComposer get deviceId {
    final $$DeviceEntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceId,
      referencedTable: $db.deviceEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceEntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.deviceEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AreaEntitiesTableOrderingComposer get areaId {
    final $$AreaEntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areaEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaEntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.areaEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeviceAreaConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeviceAreaConfigsTable> {
  $$DeviceAreaConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$DeviceEntitiesTableAnnotationComposer get deviceId {
    final $$DeviceEntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceId,
      referencedTable: $db.deviceEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceEntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.deviceEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AreaEntitiesTableAnnotationComposer get areaId {
    final $$AreaEntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areaEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaEntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.areaEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeviceAreaConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeviceAreaConfigsTable,
          DeviceAreaConfig,
          $$DeviceAreaConfigsTableFilterComposer,
          $$DeviceAreaConfigsTableOrderingComposer,
          $$DeviceAreaConfigsTableAnnotationComposer,
          $$DeviceAreaConfigsTableCreateCompanionBuilder,
          $$DeviceAreaConfigsTableUpdateCompanionBuilder,
          (DeviceAreaConfig, $$DeviceAreaConfigsTableReferences),
          DeviceAreaConfig,
          PrefetchHooks Function({bool deviceId, bool areaId})
        > {
  $$DeviceAreaConfigsTableTableManager(
    _$AppDatabase db,
    $DeviceAreaConfigsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceAreaConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceAreaConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceAreaConfigsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> deviceId = const Value.absent(),
                Value<int> areaId = const Value.absent(),
              }) => DeviceAreaConfigsCompanion(
                id: id,
                deviceId: deviceId,
                areaId: areaId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int deviceId,
                required int areaId,
              }) => DeviceAreaConfigsCompanion.insert(
                id: id,
                deviceId: deviceId,
                areaId: areaId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DeviceAreaConfigsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({deviceId = false, areaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (deviceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.deviceId,
                                referencedTable:
                                    $$DeviceAreaConfigsTableReferences
                                        ._deviceIdTable(db),
                                referencedColumn:
                                    $$DeviceAreaConfigsTableReferences
                                        ._deviceIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (areaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.areaId,
                                referencedTable:
                                    $$DeviceAreaConfigsTableReferences
                                        ._areaIdTable(db),
                                referencedColumn:
                                    $$DeviceAreaConfigsTableReferences
                                        ._areaIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DeviceAreaConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeviceAreaConfigsTable,
      DeviceAreaConfig,
      $$DeviceAreaConfigsTableFilterComposer,
      $$DeviceAreaConfigsTableOrderingComposer,
      $$DeviceAreaConfigsTableAnnotationComposer,
      $$DeviceAreaConfigsTableCreateCompanionBuilder,
      $$DeviceAreaConfigsTableUpdateCompanionBuilder,
      (DeviceAreaConfig, $$DeviceAreaConfigsTableReferences),
      DeviceAreaConfig,
      PrefetchHooks Function({bool deviceId, bool areaId})
    >;
typedef $$HomeViewConfigsTableCreateCompanionBuilder =
    HomeViewConfigsCompanion Function({Value<int> id, required int serverId});
typedef $$HomeViewConfigsTableUpdateCompanionBuilder =
    HomeViewConfigsCompanion Function({Value<int> id, Value<int> serverId});

final class $$HomeViewConfigsTableReferences
    extends
        BaseReferences<_$AppDatabase, $HomeViewConfigsTable, HomeViewConfig> {
  $$HomeViewConfigsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ServerEntitiesTable _serverIdTable(_$AppDatabase db) =>
      db.serverEntities.createAlias(
        $_aliasNameGenerator(db.homeViewConfigs.serverId, db.serverEntities.id),
      );

  $$ServerEntitiesTableProcessedTableManager get serverId {
    final $_column = $_itemColumn<int>('server_id')!;

    final manager = $$ServerEntitiesTableTableManager(
      $_db,
      $_db.serverEntities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_serverIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AreaHomeConfigsTable, List<AreaHomeConfig>>
  _areaHomeConfigsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.areaHomeConfigs,
    aliasName: $_aliasNameGenerator(
      db.homeViewConfigs.id,
      db.areaHomeConfigs.homeConfigId,
    ),
  );

  $$AreaHomeConfigsTableProcessedTableManager get areaHomeConfigsRefs {
    final manager = $$AreaHomeConfigsTableTableManager(
      $_db,
      $_db.areaHomeConfigs,
    ).filter((f) => f.homeConfigId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _areaHomeConfigsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HomeViewConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $HomeViewConfigsTable> {
  $$HomeViewConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  $$ServerEntitiesTableFilterComposer get serverId {
    final $$ServerEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.serverEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServerEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.serverEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> areaHomeConfigsRefs(
    Expression<bool> Function($$AreaHomeConfigsTableFilterComposer f) f,
  ) {
    final $$AreaHomeConfigsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.areaHomeConfigs,
      getReferencedColumn: (t) => t.homeConfigId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaHomeConfigsTableFilterComposer(
            $db: $db,
            $table: $db.areaHomeConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HomeViewConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $HomeViewConfigsTable> {
  $$HomeViewConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  $$ServerEntitiesTableOrderingComposer get serverId {
    final $$ServerEntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.serverEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServerEntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.serverEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HomeViewConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HomeViewConfigsTable> {
  $$HomeViewConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$ServerEntitiesTableAnnotationComposer get serverId {
    final $$ServerEntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.serverEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServerEntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.serverEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> areaHomeConfigsRefs<T extends Object>(
    Expression<T> Function($$AreaHomeConfigsTableAnnotationComposer a) f,
  ) {
    final $$AreaHomeConfigsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.areaHomeConfigs,
      getReferencedColumn: (t) => t.homeConfigId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaHomeConfigsTableAnnotationComposer(
            $db: $db,
            $table: $db.areaHomeConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HomeViewConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HomeViewConfigsTable,
          HomeViewConfig,
          $$HomeViewConfigsTableFilterComposer,
          $$HomeViewConfigsTableOrderingComposer,
          $$HomeViewConfigsTableAnnotationComposer,
          $$HomeViewConfigsTableCreateCompanionBuilder,
          $$HomeViewConfigsTableUpdateCompanionBuilder,
          (HomeViewConfig, $$HomeViewConfigsTableReferences),
          HomeViewConfig,
          PrefetchHooks Function({bool serverId, bool areaHomeConfigsRefs})
        > {
  $$HomeViewConfigsTableTableManager(
    _$AppDatabase db,
    $HomeViewConfigsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HomeViewConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HomeViewConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HomeViewConfigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> serverId = const Value.absent(),
              }) => HomeViewConfigsCompanion(id: id, serverId: serverId),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required int serverId}) =>
                  HomeViewConfigsCompanion.insert(id: id, serverId: serverId),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HomeViewConfigsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({serverId = false, areaHomeConfigsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (areaHomeConfigsRefs) db.areaHomeConfigs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (serverId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.serverId,
                                    referencedTable:
                                        $$HomeViewConfigsTableReferences
                                            ._serverIdTable(db),
                                    referencedColumn:
                                        $$HomeViewConfigsTableReferences
                                            ._serverIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (areaHomeConfigsRefs)
                        await $_getPrefetchedData<
                          HomeViewConfig,
                          $HomeViewConfigsTable,
                          AreaHomeConfig
                        >(
                          currentTable: table,
                          referencedTable: $$HomeViewConfigsTableReferences
                              ._areaHomeConfigsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HomeViewConfigsTableReferences(
                                db,
                                table,
                                p0,
                              ).areaHomeConfigsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.homeConfigId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HomeViewConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HomeViewConfigsTable,
      HomeViewConfig,
      $$HomeViewConfigsTableFilterComposer,
      $$HomeViewConfigsTableOrderingComposer,
      $$HomeViewConfigsTableAnnotationComposer,
      $$HomeViewConfigsTableCreateCompanionBuilder,
      $$HomeViewConfigsTableUpdateCompanionBuilder,
      (HomeViewConfig, $$HomeViewConfigsTableReferences),
      HomeViewConfig,
      PrefetchHooks Function({bool serverId, bool areaHomeConfigsRefs})
    >;
typedef $$AreaHomeConfigsTableCreateCompanionBuilder =
    AreaHomeConfigsCompanion Function({
      Value<int> id,
      required int order,
      required int areaId,
      required int homeConfigId,
    });
typedef $$AreaHomeConfigsTableUpdateCompanionBuilder =
    AreaHomeConfigsCompanion Function({
      Value<int> id,
      Value<int> order,
      Value<int> areaId,
      Value<int> homeConfigId,
    });

final class $$AreaHomeConfigsTableReferences
    extends
        BaseReferences<_$AppDatabase, $AreaHomeConfigsTable, AreaHomeConfig> {
  $$AreaHomeConfigsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AreaEntitiesTable _areaIdTable(_$AppDatabase db) =>
      db.areaEntities.createAlias(
        $_aliasNameGenerator(db.areaHomeConfigs.areaId, db.areaEntities.id),
      );

  $$AreaEntitiesTableProcessedTableManager get areaId {
    final $_column = $_itemColumn<int>('area_id')!;

    final manager = $$AreaEntitiesTableTableManager(
      $_db,
      $_db.areaEntities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_areaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HomeViewConfigsTable _homeConfigIdTable(_$AppDatabase db) =>
      db.homeViewConfigs.createAlias(
        $_aliasNameGenerator(
          db.areaHomeConfigs.homeConfigId,
          db.homeViewConfigs.id,
        ),
      );

  $$HomeViewConfigsTableProcessedTableManager get homeConfigId {
    final $_column = $_itemColumn<int>('home_config_id')!;

    final manager = $$HomeViewConfigsTableTableManager(
      $_db,
      $_db.homeViewConfigs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_homeConfigIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DeviceHomeConfigsTable, List<DeviceHomeConfig>>
  _deviceHomeConfigsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.deviceHomeConfigs,
        aliasName: $_aliasNameGenerator(
          db.areaHomeConfigs.id,
          db.deviceHomeConfigs.areaConfigId,
        ),
      );

  $$DeviceHomeConfigsTableProcessedTableManager get deviceHomeConfigsRefs {
    final manager = $$DeviceHomeConfigsTableTableManager(
      $_db,
      $_db.deviceHomeConfigs,
    ).filter((f) => f.areaConfigId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _deviceHomeConfigsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AreaHomeConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $AreaHomeConfigsTable> {
  $$AreaHomeConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  $$AreaEntitiesTableFilterComposer get areaId {
    final $$AreaEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areaEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.areaEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HomeViewConfigsTableFilterComposer get homeConfigId {
    final $$HomeViewConfigsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.homeConfigId,
      referencedTable: $db.homeViewConfigs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HomeViewConfigsTableFilterComposer(
            $db: $db,
            $table: $db.homeViewConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> deviceHomeConfigsRefs(
    Expression<bool> Function($$DeviceHomeConfigsTableFilterComposer f) f,
  ) {
    final $$DeviceHomeConfigsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceHomeConfigs,
      getReferencedColumn: (t) => t.areaConfigId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceHomeConfigsTableFilterComposer(
            $db: $db,
            $table: $db.deviceHomeConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AreaHomeConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $AreaHomeConfigsTable> {
  $$AreaHomeConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  $$AreaEntitiesTableOrderingComposer get areaId {
    final $$AreaEntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areaEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaEntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.areaEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HomeViewConfigsTableOrderingComposer get homeConfigId {
    final $$HomeViewConfigsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.homeConfigId,
      referencedTable: $db.homeViewConfigs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HomeViewConfigsTableOrderingComposer(
            $db: $db,
            $table: $db.homeViewConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AreaHomeConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AreaHomeConfigsTable> {
  $$AreaHomeConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$AreaEntitiesTableAnnotationComposer get areaId {
    final $$AreaEntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areaEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaEntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.areaEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HomeViewConfigsTableAnnotationComposer get homeConfigId {
    final $$HomeViewConfigsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.homeConfigId,
      referencedTable: $db.homeViewConfigs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HomeViewConfigsTableAnnotationComposer(
            $db: $db,
            $table: $db.homeViewConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> deviceHomeConfigsRefs<T extends Object>(
    Expression<T> Function($$DeviceHomeConfigsTableAnnotationComposer a) f,
  ) {
    final $$DeviceHomeConfigsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.deviceHomeConfigs,
          getReferencedColumn: (t) => t.areaConfigId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DeviceHomeConfigsTableAnnotationComposer(
                $db: $db,
                $table: $db.deviceHomeConfigs,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AreaHomeConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AreaHomeConfigsTable,
          AreaHomeConfig,
          $$AreaHomeConfigsTableFilterComposer,
          $$AreaHomeConfigsTableOrderingComposer,
          $$AreaHomeConfigsTableAnnotationComposer,
          $$AreaHomeConfigsTableCreateCompanionBuilder,
          $$AreaHomeConfigsTableUpdateCompanionBuilder,
          (AreaHomeConfig, $$AreaHomeConfigsTableReferences),
          AreaHomeConfig,
          PrefetchHooks Function({
            bool areaId,
            bool homeConfigId,
            bool deviceHomeConfigsRefs,
          })
        > {
  $$AreaHomeConfigsTableTableManager(
    _$AppDatabase db,
    $AreaHomeConfigsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AreaHomeConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AreaHomeConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AreaHomeConfigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<int> areaId = const Value.absent(),
                Value<int> homeConfigId = const Value.absent(),
              }) => AreaHomeConfigsCompanion(
                id: id,
                order: order,
                areaId: areaId,
                homeConfigId: homeConfigId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int order,
                required int areaId,
                required int homeConfigId,
              }) => AreaHomeConfigsCompanion.insert(
                id: id,
                order: order,
                areaId: areaId,
                homeConfigId: homeConfigId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AreaHomeConfigsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                areaId = false,
                homeConfigId = false,
                deviceHomeConfigsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (deviceHomeConfigsRefs) db.deviceHomeConfigs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (areaId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.areaId,
                                    referencedTable:
                                        $$AreaHomeConfigsTableReferences
                                            ._areaIdTable(db),
                                    referencedColumn:
                                        $$AreaHomeConfigsTableReferences
                                            ._areaIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (homeConfigId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.homeConfigId,
                                    referencedTable:
                                        $$AreaHomeConfigsTableReferences
                                            ._homeConfigIdTable(db),
                                    referencedColumn:
                                        $$AreaHomeConfigsTableReferences
                                            ._homeConfigIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (deviceHomeConfigsRefs)
                        await $_getPrefetchedData<
                          AreaHomeConfig,
                          $AreaHomeConfigsTable,
                          DeviceHomeConfig
                        >(
                          currentTable: table,
                          referencedTable: $$AreaHomeConfigsTableReferences
                              ._deviceHomeConfigsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AreaHomeConfigsTableReferences(
                                db,
                                table,
                                p0,
                              ).deviceHomeConfigsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.areaConfigId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AreaHomeConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AreaHomeConfigsTable,
      AreaHomeConfig,
      $$AreaHomeConfigsTableFilterComposer,
      $$AreaHomeConfigsTableOrderingComposer,
      $$AreaHomeConfigsTableAnnotationComposer,
      $$AreaHomeConfigsTableCreateCompanionBuilder,
      $$AreaHomeConfigsTableUpdateCompanionBuilder,
      (AreaHomeConfig, $$AreaHomeConfigsTableReferences),
      AreaHomeConfig,
      PrefetchHooks Function({
        bool areaId,
        bool homeConfigId,
        bool deviceHomeConfigsRefs,
      })
    >;
typedef $$DeviceHomeConfigsTableCreateCompanionBuilder =
    DeviceHomeConfigsCompanion Function({
      Value<int> id,
      required int order,
      required DeviceDisplaySizeDb size,
      required int deviceId,
      required int areaConfigId,
    });
typedef $$DeviceHomeConfigsTableUpdateCompanionBuilder =
    DeviceHomeConfigsCompanion Function({
      Value<int> id,
      Value<int> order,
      Value<DeviceDisplaySizeDb> size,
      Value<int> deviceId,
      Value<int> areaConfigId,
    });

final class $$DeviceHomeConfigsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DeviceHomeConfigsTable,
          DeviceHomeConfig
        > {
  $$DeviceHomeConfigsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DeviceEntitiesTable _deviceIdTable(_$AppDatabase db) =>
      db.deviceEntities.createAlias(
        $_aliasNameGenerator(
          db.deviceHomeConfigs.deviceId,
          db.deviceEntities.id,
        ),
      );

  $$DeviceEntitiesTableProcessedTableManager get deviceId {
    final $_column = $_itemColumn<int>('device_id')!;

    final manager = $$DeviceEntitiesTableTableManager(
      $_db,
      $_db.deviceEntities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deviceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AreaHomeConfigsTable _areaConfigIdTable(_$AppDatabase db) =>
      db.areaHomeConfigs.createAlias(
        $_aliasNameGenerator(
          db.deviceHomeConfigs.areaConfigId,
          db.areaHomeConfigs.id,
        ),
      );

  $$AreaHomeConfigsTableProcessedTableManager get areaConfigId {
    final $_column = $_itemColumn<int>('area_config_id')!;

    final manager = $$AreaHomeConfigsTableTableManager(
      $_db,
      $_db.areaHomeConfigs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_areaConfigIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DeviceHomeConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $DeviceHomeConfigsTable> {
  $$DeviceHomeConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DeviceDisplaySizeDb, DeviceDisplaySizeDb, int>
  get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$DeviceEntitiesTableFilterComposer get deviceId {
    final $$DeviceEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceId,
      referencedTable: $db.deviceEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.deviceEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AreaHomeConfigsTableFilterComposer get areaConfigId {
    final $$AreaHomeConfigsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaConfigId,
      referencedTable: $db.areaHomeConfigs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaHomeConfigsTableFilterComposer(
            $db: $db,
            $table: $db.areaHomeConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeviceHomeConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $DeviceHomeConfigsTable> {
  $$DeviceHomeConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  $$DeviceEntitiesTableOrderingComposer get deviceId {
    final $$DeviceEntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceId,
      referencedTable: $db.deviceEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceEntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.deviceEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AreaHomeConfigsTableOrderingComposer get areaConfigId {
    final $$AreaHomeConfigsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaConfigId,
      referencedTable: $db.areaHomeConfigs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaHomeConfigsTableOrderingComposer(
            $db: $db,
            $table: $db.areaHomeConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeviceHomeConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeviceHomeConfigsTable> {
  $$DeviceHomeConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DeviceDisplaySizeDb, int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  $$DeviceEntitiesTableAnnotationComposer get deviceId {
    final $$DeviceEntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceId,
      referencedTable: $db.deviceEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceEntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.deviceEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AreaHomeConfigsTableAnnotationComposer get areaConfigId {
    final $$AreaHomeConfigsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaConfigId,
      referencedTable: $db.areaHomeConfigs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreaHomeConfigsTableAnnotationComposer(
            $db: $db,
            $table: $db.areaHomeConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeviceHomeConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeviceHomeConfigsTable,
          DeviceHomeConfig,
          $$DeviceHomeConfigsTableFilterComposer,
          $$DeviceHomeConfigsTableOrderingComposer,
          $$DeviceHomeConfigsTableAnnotationComposer,
          $$DeviceHomeConfigsTableCreateCompanionBuilder,
          $$DeviceHomeConfigsTableUpdateCompanionBuilder,
          (DeviceHomeConfig, $$DeviceHomeConfigsTableReferences),
          DeviceHomeConfig,
          PrefetchHooks Function({bool deviceId, bool areaConfigId})
        > {
  $$DeviceHomeConfigsTableTableManager(
    _$AppDatabase db,
    $DeviceHomeConfigsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceHomeConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceHomeConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceHomeConfigsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<DeviceDisplaySizeDb> size = const Value.absent(),
                Value<int> deviceId = const Value.absent(),
                Value<int> areaConfigId = const Value.absent(),
              }) => DeviceHomeConfigsCompanion(
                id: id,
                order: order,
                size: size,
                deviceId: deviceId,
                areaConfigId: areaConfigId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int order,
                required DeviceDisplaySizeDb size,
                required int deviceId,
                required int areaConfigId,
              }) => DeviceHomeConfigsCompanion.insert(
                id: id,
                order: order,
                size: size,
                deviceId: deviceId,
                areaConfigId: areaConfigId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DeviceHomeConfigsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({deviceId = false, areaConfigId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (deviceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.deviceId,
                                referencedTable:
                                    $$DeviceHomeConfigsTableReferences
                                        ._deviceIdTable(db),
                                referencedColumn:
                                    $$DeviceHomeConfigsTableReferences
                                        ._deviceIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (areaConfigId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.areaConfigId,
                                referencedTable:
                                    $$DeviceHomeConfigsTableReferences
                                        ._areaConfigIdTable(db),
                                referencedColumn:
                                    $$DeviceHomeConfigsTableReferences
                                        ._areaConfigIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DeviceHomeConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeviceHomeConfigsTable,
      DeviceHomeConfig,
      $$DeviceHomeConfigsTableFilterComposer,
      $$DeviceHomeConfigsTableOrderingComposer,
      $$DeviceHomeConfigsTableAnnotationComposer,
      $$DeviceHomeConfigsTableCreateCompanionBuilder,
      $$DeviceHomeConfigsTableUpdateCompanionBuilder,
      (DeviceHomeConfig, $$DeviceHomeConfigsTableReferences),
      DeviceHomeConfig,
      PrefetchHooks Function({bool deviceId, bool areaConfigId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ServerEntitiesTableTableManager get serverEntities =>
      $$ServerEntitiesTableTableManager(_db, _db.serverEntities);
  $$AreaEntitiesTableTableManager get areaEntities =>
      $$AreaEntitiesTableTableManager(_db, _db.areaEntities);
  $$DeviceEntitiesTableTableManager get deviceEntities =>
      $$DeviceEntitiesTableTableManager(_db, _db.deviceEntities);
  $$DeviceAreaConfigsTableTableManager get deviceAreaConfigs =>
      $$DeviceAreaConfigsTableTableManager(_db, _db.deviceAreaConfigs);
  $$HomeViewConfigsTableTableManager get homeViewConfigs =>
      $$HomeViewConfigsTableTableManager(_db, _db.homeViewConfigs);
  $$AreaHomeConfigsTableTableManager get areaHomeConfigs =>
      $$AreaHomeConfigsTableTableManager(_db, _db.areaHomeConfigs);
  $$DeviceHomeConfigsTableTableManager get deviceHomeConfigs =>
      $$DeviceHomeConfigsTableTableManager(_db, _db.deviceHomeConfigs);
}
