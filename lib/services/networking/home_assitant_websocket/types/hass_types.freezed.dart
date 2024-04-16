// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hass_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HassError _$HassErrorFromJson(Map<String, dynamic> json) {
  return _Error.fromJson(json);
}

/// @nodoc
mixin _$HassError {
  String get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HassErrorCopyWith<HassError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HassErrorCopyWith<$Res> {
  factory $HassErrorCopyWith(HassError value, $Res Function(HassError) then) =
      _$HassErrorCopyWithImpl<$Res, HassError>;
  @useResult
  $Res call({String code, String message});
}

/// @nodoc
class _$HassErrorCopyWithImpl<$Res, $Val extends HassError>
    implements $HassErrorCopyWith<$Res> {
  _$HassErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> implements $HassErrorCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$HassErrorCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.code, required this.message});

  factory _$ErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorImplFromJson(json);

  @override
  final String code;
  @override
  final String message;

  @override
  String toString() {
    return 'HassError(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorImplToJson(
      this,
    );
  }
}

abstract class _Error implements HassError {
  const factory _Error(
      {required final String code,
      required final String message}) = _$ErrorImpl;

  factory _Error.fromJson(Map<String, dynamic> json) = _$ErrorImpl.fromJson;

  @override
  String get code;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AreaEntity _$AreaEntityFromJson(Map<String, dynamic> json) {
  return _AreaEntity.fromJson(json);
}

/// @nodoc
mixin _$AreaEntity {
  String get area_id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get picture => throw _privateConstructorUsedError;
  List<String>? get aliases => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AreaEntityCopyWith<AreaEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreaEntityCopyWith<$Res> {
  factory $AreaEntityCopyWith(
          AreaEntity value, $Res Function(AreaEntity) then) =
      _$AreaEntityCopyWithImpl<$Res, AreaEntity>;
  @useResult
  $Res call(
      {String area_id, String name, String? picture, List<String>? aliases});
}

/// @nodoc
class _$AreaEntityCopyWithImpl<$Res, $Val extends AreaEntity>
    implements $AreaEntityCopyWith<$Res> {
  _$AreaEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area_id = null,
    Object? name = null,
    Object? picture = freezed,
    Object? aliases = freezed,
  }) {
    return _then(_value.copyWith(
      area_id: null == area_id
          ? _value.area_id
          : area_id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      aliases: freezed == aliases
          ? _value.aliases
          : aliases // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AreaEntityImplCopyWith<$Res>
    implements $AreaEntityCopyWith<$Res> {
  factory _$$AreaEntityImplCopyWith(
          _$AreaEntityImpl value, $Res Function(_$AreaEntityImpl) then) =
      __$$AreaEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String area_id, String name, String? picture, List<String>? aliases});
}

/// @nodoc
class __$$AreaEntityImplCopyWithImpl<$Res>
    extends _$AreaEntityCopyWithImpl<$Res, _$AreaEntityImpl>
    implements _$$AreaEntityImplCopyWith<$Res> {
  __$$AreaEntityImplCopyWithImpl(
      _$AreaEntityImpl _value, $Res Function(_$AreaEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area_id = null,
    Object? name = null,
    Object? picture = freezed,
    Object? aliases = freezed,
  }) {
    return _then(_$AreaEntityImpl(
      area_id: null == area_id
          ? _value.area_id
          : area_id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      aliases: freezed == aliases
          ? _value._aliases
          : aliases // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaEntityImpl implements _AreaEntity {
  const _$AreaEntityImpl(
      {required this.area_id,
      required this.name,
      this.picture,
      final List<String>? aliases})
      : _aliases = aliases;

  factory _$AreaEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AreaEntityImplFromJson(json);

  @override
  final String area_id;
  @override
  final String name;
  @override
  final String? picture;
  final List<String>? _aliases;
  @override
  List<String>? get aliases {
    final value = _aliases;
    if (value == null) return null;
    if (_aliases is EqualUnmodifiableListView) return _aliases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AreaEntity(area_id: $area_id, name: $name, picture: $picture, aliases: $aliases)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaEntityImpl &&
            (identical(other.area_id, area_id) || other.area_id == area_id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.picture, picture) || other.picture == picture) &&
            const DeepCollectionEquality().equals(other._aliases, _aliases));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, area_id, name, picture,
      const DeepCollectionEquality().hash(_aliases));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaEntityImplCopyWith<_$AreaEntityImpl> get copyWith =>
      __$$AreaEntityImplCopyWithImpl<_$AreaEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaEntityImplToJson(
      this,
    );
  }
}

abstract class _AreaEntity implements AreaEntity {
  const factory _AreaEntity(
      {required final String area_id,
      required final String name,
      final String? picture,
      final List<String>? aliases}) = _$AreaEntityImpl;

  factory _AreaEntity.fromJson(Map<String, dynamic> json) =
      _$AreaEntityImpl.fromJson;

  @override
  String get area_id;
  @override
  String get name;
  @override
  String? get picture;
  @override
  List<String>? get aliases;
  @override
  @JsonKey(ignore: true)
  _$$AreaEntityImplCopyWith<_$AreaEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AreaEntityList _$AreaEntityListFromJson(Map<String, dynamic> json) {
  return _AreaEntityList.fromJson(json);
}

/// @nodoc
mixin _$AreaEntityList {
  List<AreaEntity> get areasList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AreaEntityListCopyWith<AreaEntityList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreaEntityListCopyWith<$Res> {
  factory $AreaEntityListCopyWith(
          AreaEntityList value, $Res Function(AreaEntityList) then) =
      _$AreaEntityListCopyWithImpl<$Res, AreaEntityList>;
  @useResult
  $Res call({List<AreaEntity> areasList});
}

/// @nodoc
class _$AreaEntityListCopyWithImpl<$Res, $Val extends AreaEntityList>
    implements $AreaEntityListCopyWith<$Res> {
  _$AreaEntityListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areasList = null,
  }) {
    return _then(_value.copyWith(
      areasList: null == areasList
          ? _value.areasList
          : areasList // ignore: cast_nullable_to_non_nullable
              as List<AreaEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AreaEntityListImplCopyWith<$Res>
    implements $AreaEntityListCopyWith<$Res> {
  factory _$$AreaEntityListImplCopyWith(_$AreaEntityListImpl value,
          $Res Function(_$AreaEntityListImpl) then) =
      __$$AreaEntityListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AreaEntity> areasList});
}

/// @nodoc
class __$$AreaEntityListImplCopyWithImpl<$Res>
    extends _$AreaEntityListCopyWithImpl<$Res, _$AreaEntityListImpl>
    implements _$$AreaEntityListImplCopyWith<$Res> {
  __$$AreaEntityListImplCopyWithImpl(
      _$AreaEntityListImpl _value, $Res Function(_$AreaEntityListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areasList = null,
  }) {
    return _then(_$AreaEntityListImpl(
      null == areasList
          ? _value._areasList
          : areasList // ignore: cast_nullable_to_non_nullable
              as List<AreaEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaEntityListImpl implements _AreaEntityList {
  const _$AreaEntityListImpl(final List<AreaEntity> areasList)
      : _areasList = areasList;

  factory _$AreaEntityListImpl.fromJson(Map<String, dynamic> json) =>
      _$$AreaEntityListImplFromJson(json);

  final List<AreaEntity> _areasList;
  @override
  List<AreaEntity> get areasList {
    if (_areasList is EqualUnmodifiableListView) return _areasList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areasList);
  }

  @override
  String toString() {
    return 'AreaEntityList(areasList: $areasList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaEntityListImpl &&
            const DeepCollectionEquality()
                .equals(other._areasList, _areasList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_areasList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaEntityListImplCopyWith<_$AreaEntityListImpl> get copyWith =>
      __$$AreaEntityListImplCopyWithImpl<_$AreaEntityListImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaEntityListImplToJson(
      this,
    );
  }
}

abstract class _AreaEntityList implements AreaEntityList {
  const factory _AreaEntityList(final List<AreaEntity> areasList) =
      _$AreaEntityListImpl;

  factory _AreaEntityList.fromJson(Map<String, dynamic> json) =
      _$AreaEntityListImpl.fromJson;

  @override
  List<AreaEntity> get areasList;
  @override
  @JsonKey(ignore: true)
  _$$AreaEntityListImplCopyWith<_$AreaEntityListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HassUser _$HassUserFromJson(Map<String, dynamic> json) {
  return _HassUser.fromJson(json);
}

/// @nodoc
mixin _$HassUser {
  String get id => throw _privateConstructorUsedError;
  bool get is_admin => throw _privateConstructorUsedError;
  bool get is_owner => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HassUserCopyWith<HassUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HassUserCopyWith<$Res> {
  factory $HassUserCopyWith(HassUser value, $Res Function(HassUser) then) =
      _$HassUserCopyWithImpl<$Res, HassUser>;
  @useResult
  $Res call({String id, bool is_admin, bool is_owner, String name});
}

/// @nodoc
class _$HassUserCopyWithImpl<$Res, $Val extends HassUser>
    implements $HassUserCopyWith<$Res> {
  _$HassUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? is_admin = null,
    Object? is_owner = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      is_admin: null == is_admin
          ? _value.is_admin
          : is_admin // ignore: cast_nullable_to_non_nullable
              as bool,
      is_owner: null == is_owner
          ? _value.is_owner
          : is_owner // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HassUserImplCopyWith<$Res>
    implements $HassUserCopyWith<$Res> {
  factory _$$HassUserImplCopyWith(
          _$HassUserImpl value, $Res Function(_$HassUserImpl) then) =
      __$$HassUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, bool is_admin, bool is_owner, String name});
}

/// @nodoc
class __$$HassUserImplCopyWithImpl<$Res>
    extends _$HassUserCopyWithImpl<$Res, _$HassUserImpl>
    implements _$$HassUserImplCopyWith<$Res> {
  __$$HassUserImplCopyWithImpl(
      _$HassUserImpl _value, $Res Function(_$HassUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? is_admin = null,
    Object? is_owner = null,
    Object? name = null,
  }) {
    return _then(_$HassUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      is_admin: null == is_admin
          ? _value.is_admin
          : is_admin // ignore: cast_nullable_to_non_nullable
              as bool,
      is_owner: null == is_owner
          ? _value.is_owner
          : is_owner // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HassUserImpl implements _HassUser {
  const _$HassUserImpl(
      {required this.id,
      required this.is_admin,
      required this.is_owner,
      required this.name});

  factory _$HassUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$HassUserImplFromJson(json);

  @override
  final String id;
  @override
  final bool is_admin;
  @override
  final bool is_owner;
  @override
  final String name;

  @override
  String toString() {
    return 'HassUser(id: $id, is_admin: $is_admin, is_owner: $is_owner, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HassUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.is_admin, is_admin) ||
                other.is_admin == is_admin) &&
            (identical(other.is_owner, is_owner) ||
                other.is_owner == is_owner) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, is_admin, is_owner, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HassUserImplCopyWith<_$HassUserImpl> get copyWith =>
      __$$HassUserImplCopyWithImpl<_$HassUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HassUserImplToJson(
      this,
    );
  }
}

abstract class _HassUser implements HassUser {
  const factory _HassUser(
      {required final String id,
      required final bool is_admin,
      required final bool is_owner,
      required final String name}) = _$HassUserImpl;

  factory _HassUser.fromJson(Map<String, dynamic> json) =
      _$HassUserImpl.fromJson;

  @override
  String get id;
  @override
  bool get is_admin;
  @override
  bool get is_owner;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$HassUserImplCopyWith<_$HassUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HassConfig _$HassConfigFromJson(Map<String, dynamic> json) {
  return _HassConfig.fromJson(json);
}

/// @nodoc
mixin _$HassConfig {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get elevation => throw _privateConstructorUsedError;
  UnitSystem get unitSystem => throw _privateConstructorUsedError;
  String get locationName => throw _privateConstructorUsedError;
  String get timeZone => throw _privateConstructorUsedError;
  List<String> get components => throw _privateConstructorUsedError;
  String get configDir => throw _privateConstructorUsedError;
  List<String> get allowlistExternalDirs => throw _privateConstructorUsedError;
  List<String> get allowlistExternalUrls => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get configSource => throw _privateConstructorUsedError;
  bool get recoveryMode => throw _privateConstructorUsedError;
  bool get safeMode =>
      throw _privateConstructorUsedError; // @StringEnum('NOT_RUNNING', 'STARTING', 'RUNNING', 'STOPPING', 'FINAL_WRITE')
  State get state => throw _privateConstructorUsedError;
  String? get externalUrl => throw _privateConstructorUsedError;
  String? get internalUrl => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HassConfigCopyWith<HassConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HassConfigCopyWith<$Res> {
  factory $HassConfigCopyWith(
          HassConfig value, $Res Function(HassConfig) then) =
      _$HassConfigCopyWithImpl<$Res, HassConfig>;
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      double elevation,
      UnitSystem unitSystem,
      String locationName,
      String timeZone,
      List<String> components,
      String configDir,
      List<String> allowlistExternalDirs,
      List<String> allowlistExternalUrls,
      String version,
      String configSource,
      bool recoveryMode,
      bool safeMode,
      State state,
      String? externalUrl,
      String? internalUrl,
      String currency,
      String? country,
      String language});

  $UnitSystemCopyWith<$Res> get unitSystem;
}

/// @nodoc
class _$HassConfigCopyWithImpl<$Res, $Val extends HassConfig>
    implements $HassConfigCopyWith<$Res> {
  _$HassConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? elevation = null,
    Object? unitSystem = null,
    Object? locationName = null,
    Object? timeZone = null,
    Object? components = null,
    Object? configDir = null,
    Object? allowlistExternalDirs = null,
    Object? allowlistExternalUrls = null,
    Object? version = null,
    Object? configSource = null,
    Object? recoveryMode = null,
    Object? safeMode = null,
    Object? state = null,
    Object? externalUrl = freezed,
    Object? internalUrl = freezed,
    Object? currency = null,
    Object? country = freezed,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      elevation: null == elevation
          ? _value.elevation
          : elevation // ignore: cast_nullable_to_non_nullable
              as double,
      unitSystem: null == unitSystem
          ? _value.unitSystem
          : unitSystem // ignore: cast_nullable_to_non_nullable
              as UnitSystem,
      locationName: null == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String,
      timeZone: null == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String,
      components: null == components
          ? _value.components
          : components // ignore: cast_nullable_to_non_nullable
              as List<String>,
      configDir: null == configDir
          ? _value.configDir
          : configDir // ignore: cast_nullable_to_non_nullable
              as String,
      allowlistExternalDirs: null == allowlistExternalDirs
          ? _value.allowlistExternalDirs
          : allowlistExternalDirs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowlistExternalUrls: null == allowlistExternalUrls
          ? _value.allowlistExternalUrls
          : allowlistExternalUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      configSource: null == configSource
          ? _value.configSource
          : configSource // ignore: cast_nullable_to_non_nullable
              as String,
      recoveryMode: null == recoveryMode
          ? _value.recoveryMode
          : recoveryMode // ignore: cast_nullable_to_non_nullable
              as bool,
      safeMode: null == safeMode
          ? _value.safeMode
          : safeMode // ignore: cast_nullable_to_non_nullable
              as bool,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as State,
      externalUrl: freezed == externalUrl
          ? _value.externalUrl
          : externalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      internalUrl: freezed == internalUrl
          ? _value.internalUrl
          : internalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnitSystemCopyWith<$Res> get unitSystem {
    return $UnitSystemCopyWith<$Res>(_value.unitSystem, (value) {
      return _then(_value.copyWith(unitSystem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HassConfigImplCopyWith<$Res>
    implements $HassConfigCopyWith<$Res> {
  factory _$$HassConfigImplCopyWith(
          _$HassConfigImpl value, $Res Function(_$HassConfigImpl) then) =
      __$$HassConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      double elevation,
      UnitSystem unitSystem,
      String locationName,
      String timeZone,
      List<String> components,
      String configDir,
      List<String> allowlistExternalDirs,
      List<String> allowlistExternalUrls,
      String version,
      String configSource,
      bool recoveryMode,
      bool safeMode,
      State state,
      String? externalUrl,
      String? internalUrl,
      String currency,
      String? country,
      String language});

  @override
  $UnitSystemCopyWith<$Res> get unitSystem;
}

/// @nodoc
class __$$HassConfigImplCopyWithImpl<$Res>
    extends _$HassConfigCopyWithImpl<$Res, _$HassConfigImpl>
    implements _$$HassConfigImplCopyWith<$Res> {
  __$$HassConfigImplCopyWithImpl(
      _$HassConfigImpl _value, $Res Function(_$HassConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? elevation = null,
    Object? unitSystem = null,
    Object? locationName = null,
    Object? timeZone = null,
    Object? components = null,
    Object? configDir = null,
    Object? allowlistExternalDirs = null,
    Object? allowlistExternalUrls = null,
    Object? version = null,
    Object? configSource = null,
    Object? recoveryMode = null,
    Object? safeMode = null,
    Object? state = null,
    Object? externalUrl = freezed,
    Object? internalUrl = freezed,
    Object? currency = null,
    Object? country = freezed,
    Object? language = null,
  }) {
    return _then(_$HassConfigImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      elevation: null == elevation
          ? _value.elevation
          : elevation // ignore: cast_nullable_to_non_nullable
              as double,
      unitSystem: null == unitSystem
          ? _value.unitSystem
          : unitSystem // ignore: cast_nullable_to_non_nullable
              as UnitSystem,
      locationName: null == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String,
      timeZone: null == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String,
      components: null == components
          ? _value._components
          : components // ignore: cast_nullable_to_non_nullable
              as List<String>,
      configDir: null == configDir
          ? _value.configDir
          : configDir // ignore: cast_nullable_to_non_nullable
              as String,
      allowlistExternalDirs: null == allowlistExternalDirs
          ? _value._allowlistExternalDirs
          : allowlistExternalDirs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowlistExternalUrls: null == allowlistExternalUrls
          ? _value._allowlistExternalUrls
          : allowlistExternalUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      configSource: null == configSource
          ? _value.configSource
          : configSource // ignore: cast_nullable_to_non_nullable
              as String,
      recoveryMode: null == recoveryMode
          ? _value.recoveryMode
          : recoveryMode // ignore: cast_nullable_to_non_nullable
              as bool,
      safeMode: null == safeMode
          ? _value.safeMode
          : safeMode // ignore: cast_nullable_to_non_nullable
              as bool,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as State,
      externalUrl: freezed == externalUrl
          ? _value.externalUrl
          : externalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      internalUrl: freezed == internalUrl
          ? _value.internalUrl
          : internalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HassConfigImpl implements _HassConfig {
  const _$HassConfigImpl(
      {required this.latitude,
      required this.longitude,
      required this.elevation,
      required this.unitSystem,
      required this.locationName,
      required this.timeZone,
      required final List<String> components,
      required this.configDir,
      required final List<String> allowlistExternalDirs,
      required final List<String> allowlistExternalUrls,
      required this.version,
      required this.configSource,
      required this.recoveryMode,
      required this.safeMode,
      required this.state,
      this.externalUrl,
      this.internalUrl,
      required this.currency,
      this.country,
      required this.language})
      : _components = components,
        _allowlistExternalDirs = allowlistExternalDirs,
        _allowlistExternalUrls = allowlistExternalUrls;

  factory _$HassConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$HassConfigImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double elevation;
  @override
  final UnitSystem unitSystem;
  @override
  final String locationName;
  @override
  final String timeZone;
  final List<String> _components;
  @override
  List<String> get components {
    if (_components is EqualUnmodifiableListView) return _components;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_components);
  }

  @override
  final String configDir;
  final List<String> _allowlistExternalDirs;
  @override
  List<String> get allowlistExternalDirs {
    if (_allowlistExternalDirs is EqualUnmodifiableListView)
      return _allowlistExternalDirs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowlistExternalDirs);
  }

  final List<String> _allowlistExternalUrls;
  @override
  List<String> get allowlistExternalUrls {
    if (_allowlistExternalUrls is EqualUnmodifiableListView)
      return _allowlistExternalUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowlistExternalUrls);
  }

  @override
  final String version;
  @override
  final String configSource;
  @override
  final bool recoveryMode;
  @override
  final bool safeMode;
// @StringEnum('NOT_RUNNING', 'STARTING', 'RUNNING', 'STOPPING', 'FINAL_WRITE')
  @override
  final State state;
  @override
  final String? externalUrl;
  @override
  final String? internalUrl;
  @override
  final String currency;
  @override
  final String? country;
  @override
  final String language;

  @override
  String toString() {
    return 'HassConfig(latitude: $latitude, longitude: $longitude, elevation: $elevation, unitSystem: $unitSystem, locationName: $locationName, timeZone: $timeZone, components: $components, configDir: $configDir, allowlistExternalDirs: $allowlistExternalDirs, allowlistExternalUrls: $allowlistExternalUrls, version: $version, configSource: $configSource, recoveryMode: $recoveryMode, safeMode: $safeMode, state: $state, externalUrl: $externalUrl, internalUrl: $internalUrl, currency: $currency, country: $country, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HassConfigImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.elevation, elevation) ||
                other.elevation == elevation) &&
            (identical(other.unitSystem, unitSystem) ||
                other.unitSystem == unitSystem) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.timeZone, timeZone) ||
                other.timeZone == timeZone) &&
            const DeepCollectionEquality()
                .equals(other._components, _components) &&
            (identical(other.configDir, configDir) ||
                other.configDir == configDir) &&
            const DeepCollectionEquality()
                .equals(other._allowlistExternalDirs, _allowlistExternalDirs) &&
            const DeepCollectionEquality()
                .equals(other._allowlistExternalUrls, _allowlistExternalUrls) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.configSource, configSource) ||
                other.configSource == configSource) &&
            (identical(other.recoveryMode, recoveryMode) ||
                other.recoveryMode == recoveryMode) &&
            (identical(other.safeMode, safeMode) ||
                other.safeMode == safeMode) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.externalUrl, externalUrl) ||
                other.externalUrl == externalUrl) &&
            (identical(other.internalUrl, internalUrl) ||
                other.internalUrl == internalUrl) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        latitude,
        longitude,
        elevation,
        unitSystem,
        locationName,
        timeZone,
        const DeepCollectionEquality().hash(_components),
        configDir,
        const DeepCollectionEquality().hash(_allowlistExternalDirs),
        const DeepCollectionEquality().hash(_allowlistExternalUrls),
        version,
        configSource,
        recoveryMode,
        safeMode,
        state,
        externalUrl,
        internalUrl,
        currency,
        country,
        language
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HassConfigImplCopyWith<_$HassConfigImpl> get copyWith =>
      __$$HassConfigImplCopyWithImpl<_$HassConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HassConfigImplToJson(
      this,
    );
  }
}

abstract class _HassConfig implements HassConfig {
  const factory _HassConfig(
      {required final double latitude,
      required final double longitude,
      required final double elevation,
      required final UnitSystem unitSystem,
      required final String locationName,
      required final String timeZone,
      required final List<String> components,
      required final String configDir,
      required final List<String> allowlistExternalDirs,
      required final List<String> allowlistExternalUrls,
      required final String version,
      required final String configSource,
      required final bool recoveryMode,
      required final bool safeMode,
      required final State state,
      final String? externalUrl,
      final String? internalUrl,
      required final String currency,
      final String? country,
      required final String language}) = _$HassConfigImpl;

  factory _HassConfig.fromJson(Map<String, dynamic> json) =
      _$HassConfigImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get elevation;
  @override
  UnitSystem get unitSystem;
  @override
  String get locationName;
  @override
  String get timeZone;
  @override
  List<String> get components;
  @override
  String get configDir;
  @override
  List<String> get allowlistExternalDirs;
  @override
  List<String> get allowlistExternalUrls;
  @override
  String get version;
  @override
  String get configSource;
  @override
  bool get recoveryMode;
  @override
  bool get safeMode;
  @override // @StringEnum('NOT_RUNNING', 'STARTING', 'RUNNING', 'STOPPING', 'FINAL_WRITE')
  State get state;
  @override
  String? get externalUrl;
  @override
  String? get internalUrl;
  @override
  String get currency;
  @override
  String? get country;
  @override
  String get language;
  @override
  @JsonKey(ignore: true)
  _$$HassConfigImplCopyWith<_$HassConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UnitSystem _$UnitSystemFromJson(Map<String, dynamic> json) {
  return _UnitSystem.fromJson(json);
}

/// @nodoc
mixin _$UnitSystem {
  String get length => throw _privateConstructorUsedError;
  String get mass => throw _privateConstructorUsedError;
  String get volume => throw _privateConstructorUsedError;
  String get temperature => throw _privateConstructorUsedError;
  String get pressure => throw _privateConstructorUsedError;
  String get windSpeed => throw _privateConstructorUsedError;
  String get accumulatedPrecipitation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnitSystemCopyWith<UnitSystem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitSystemCopyWith<$Res> {
  factory $UnitSystemCopyWith(
          UnitSystem value, $Res Function(UnitSystem) then) =
      _$UnitSystemCopyWithImpl<$Res, UnitSystem>;
  @useResult
  $Res call(
      {String length,
      String mass,
      String volume,
      String temperature,
      String pressure,
      String windSpeed,
      String accumulatedPrecipitation});
}

/// @nodoc
class _$UnitSystemCopyWithImpl<$Res, $Val extends UnitSystem>
    implements $UnitSystemCopyWith<$Res> {
  _$UnitSystemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? length = null,
    Object? mass = null,
    Object? volume = null,
    Object? temperature = null,
    Object? pressure = null,
    Object? windSpeed = null,
    Object? accumulatedPrecipitation = null,
  }) {
    return _then(_value.copyWith(
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as String,
      mass: null == mass
          ? _value.mass
          : mass // ignore: cast_nullable_to_non_nullable
              as String,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as String,
      pressure: null == pressure
          ? _value.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as String,
      windSpeed: null == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as String,
      accumulatedPrecipitation: null == accumulatedPrecipitation
          ? _value.accumulatedPrecipitation
          : accumulatedPrecipitation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnitSystemImplCopyWith<$Res>
    implements $UnitSystemCopyWith<$Res> {
  factory _$$UnitSystemImplCopyWith(
          _$UnitSystemImpl value, $Res Function(_$UnitSystemImpl) then) =
      __$$UnitSystemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String length,
      String mass,
      String volume,
      String temperature,
      String pressure,
      String windSpeed,
      String accumulatedPrecipitation});
}

/// @nodoc
class __$$UnitSystemImplCopyWithImpl<$Res>
    extends _$UnitSystemCopyWithImpl<$Res, _$UnitSystemImpl>
    implements _$$UnitSystemImplCopyWith<$Res> {
  __$$UnitSystemImplCopyWithImpl(
      _$UnitSystemImpl _value, $Res Function(_$UnitSystemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? length = null,
    Object? mass = null,
    Object? volume = null,
    Object? temperature = null,
    Object? pressure = null,
    Object? windSpeed = null,
    Object? accumulatedPrecipitation = null,
  }) {
    return _then(_$UnitSystemImpl(
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as String,
      mass: null == mass
          ? _value.mass
          : mass // ignore: cast_nullable_to_non_nullable
              as String,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as String,
      pressure: null == pressure
          ? _value.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as String,
      windSpeed: null == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as String,
      accumulatedPrecipitation: null == accumulatedPrecipitation
          ? _value.accumulatedPrecipitation
          : accumulatedPrecipitation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnitSystemImpl implements _UnitSystem {
  const _$UnitSystemImpl(
      {required this.length,
      required this.mass,
      required this.volume,
      required this.temperature,
      required this.pressure,
      required this.windSpeed,
      required this.accumulatedPrecipitation});

  factory _$UnitSystemImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnitSystemImplFromJson(json);

  @override
  final String length;
  @override
  final String mass;
  @override
  final String volume;
  @override
  final String temperature;
  @override
  final String pressure;
  @override
  final String windSpeed;
  @override
  final String accumulatedPrecipitation;

  @override
  String toString() {
    return 'UnitSystem(length: $length, mass: $mass, volume: $volume, temperature: $temperature, pressure: $pressure, windSpeed: $windSpeed, accumulatedPrecipitation: $accumulatedPrecipitation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnitSystemImpl &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.mass, mass) || other.mass == mass) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.pressure, pressure) ||
                other.pressure == pressure) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(
                    other.accumulatedPrecipitation, accumulatedPrecipitation) ||
                other.accumulatedPrecipitation == accumulatedPrecipitation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, length, mass, volume,
      temperature, pressure, windSpeed, accumulatedPrecipitation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnitSystemImplCopyWith<_$UnitSystemImpl> get copyWith =>
      __$$UnitSystemImplCopyWithImpl<_$UnitSystemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnitSystemImplToJson(
      this,
    );
  }
}

abstract class _UnitSystem implements UnitSystem {
  const factory _UnitSystem(
      {required final String length,
      required final String mass,
      required final String volume,
      required final String temperature,
      required final String pressure,
      required final String windSpeed,
      required final String accumulatedPrecipitation}) = _$UnitSystemImpl;

  factory _UnitSystem.fromJson(Map<String, dynamic> json) =
      _$UnitSystemImpl.fromJson;

  @override
  String get length;
  @override
  String get mass;
  @override
  String get volume;
  @override
  String get temperature;
  @override
  String get pressure;
  @override
  String get windSpeed;
  @override
  String get accumulatedPrecipitation;
  @override
  @JsonKey(ignore: true)
  _$$UnitSystemImplCopyWith<_$UnitSystemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
