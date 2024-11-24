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

  /// Serializes this HassError to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HassError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of HassError
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of HassError
  /// with the given fields replaced by the non-null parameter values.
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  /// Create a copy of HassError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of HassError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this AreaEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AreaEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of AreaEntity
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of AreaEntity
  /// with the given fields replaced by the non-null parameter values.
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, area_id, name, picture,
      const DeepCollectionEquality().hash(_aliases));

  /// Create a copy of AreaEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of AreaEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AreaEntityImplCopyWith<_$AreaEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AreaEntityList _$AreaEntityListFromJson(Map<String, dynamic> json) {
  return _AreaEntityList.fromJson(json);
}

/// @nodoc
mixin _$AreaEntityList {
  List<AreaEntity> get areasList => throw _privateConstructorUsedError;

  /// Serializes this AreaEntityList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AreaEntityList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of AreaEntityList
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of AreaEntityList
  /// with the given fields replaced by the non-null parameter values.
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_areasList));

  /// Create a copy of AreaEntityList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of AreaEntityList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this HassUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HassUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of HassUser
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of HassUser
  /// with the given fields replaced by the non-null parameter values.
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, is_admin, is_owner, name);

  /// Create a copy of HassUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of HassUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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
  UnitSystem get unit_system => throw _privateConstructorUsedError;
  String get location_name => throw _privateConstructorUsedError;
  String get time_zone => throw _privateConstructorUsedError;
  List<String> get components => throw _privateConstructorUsedError;
  String get config_dir => throw _privateConstructorUsedError;
  List<String> get allowlist_external_dirs =>
      throw _privateConstructorUsedError;
  List<String> get allowlist_external_urls =>
      throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get config_source => throw _privateConstructorUsedError;
  bool get recovery_mode => throw _privateConstructorUsedError;
  bool get safe_mode =>
      throw _privateConstructorUsedError; // @StringEnum('NOT_RUNNING', 'STARTING', 'RUNNING', 'STOPPING', 'FINAL_WRITE')
  State get state => throw _privateConstructorUsedError;
  String? get external_url => throw _privateConstructorUsedError;
  String? get internal_url => throw _privateConstructorUsedError;
  List<String>? get whitelist_external_dirs =>
      throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;

  /// Serializes this HassConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HassConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      UnitSystem unit_system,
      String location_name,
      String time_zone,
      List<String> components,
      String config_dir,
      List<String> allowlist_external_dirs,
      List<String> allowlist_external_urls,
      String version,
      String config_source,
      bool recovery_mode,
      bool safe_mode,
      State state,
      String? external_url,
      String? internal_url,
      List<String>? whitelist_external_dirs,
      String currency,
      String? country,
      String language});

  $UnitSystemCopyWith<$Res> get unit_system;
}

/// @nodoc
class _$HassConfigCopyWithImpl<$Res, $Val extends HassConfig>
    implements $HassConfigCopyWith<$Res> {
  _$HassConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HassConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? elevation = null,
    Object? unit_system = null,
    Object? location_name = null,
    Object? time_zone = null,
    Object? components = null,
    Object? config_dir = null,
    Object? allowlist_external_dirs = null,
    Object? allowlist_external_urls = null,
    Object? version = null,
    Object? config_source = null,
    Object? recovery_mode = null,
    Object? safe_mode = null,
    Object? state = null,
    Object? external_url = freezed,
    Object? internal_url = freezed,
    Object? whitelist_external_dirs = freezed,
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
      unit_system: null == unit_system
          ? _value.unit_system
          : unit_system // ignore: cast_nullable_to_non_nullable
              as UnitSystem,
      location_name: null == location_name
          ? _value.location_name
          : location_name // ignore: cast_nullable_to_non_nullable
              as String,
      time_zone: null == time_zone
          ? _value.time_zone
          : time_zone // ignore: cast_nullable_to_non_nullable
              as String,
      components: null == components
          ? _value.components
          : components // ignore: cast_nullable_to_non_nullable
              as List<String>,
      config_dir: null == config_dir
          ? _value.config_dir
          : config_dir // ignore: cast_nullable_to_non_nullable
              as String,
      allowlist_external_dirs: null == allowlist_external_dirs
          ? _value.allowlist_external_dirs
          : allowlist_external_dirs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowlist_external_urls: null == allowlist_external_urls
          ? _value.allowlist_external_urls
          : allowlist_external_urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      config_source: null == config_source
          ? _value.config_source
          : config_source // ignore: cast_nullable_to_non_nullable
              as String,
      recovery_mode: null == recovery_mode
          ? _value.recovery_mode
          : recovery_mode // ignore: cast_nullable_to_non_nullable
              as bool,
      safe_mode: null == safe_mode
          ? _value.safe_mode
          : safe_mode // ignore: cast_nullable_to_non_nullable
              as bool,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as State,
      external_url: freezed == external_url
          ? _value.external_url
          : external_url // ignore: cast_nullable_to_non_nullable
              as String?,
      internal_url: freezed == internal_url
          ? _value.internal_url
          : internal_url // ignore: cast_nullable_to_non_nullable
              as String?,
      whitelist_external_dirs: freezed == whitelist_external_dirs
          ? _value.whitelist_external_dirs
          : whitelist_external_dirs // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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

  /// Create a copy of HassConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UnitSystemCopyWith<$Res> get unit_system {
    return $UnitSystemCopyWith<$Res>(_value.unit_system, (value) {
      return _then(_value.copyWith(unit_system: value) as $Val);
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
      UnitSystem unit_system,
      String location_name,
      String time_zone,
      List<String> components,
      String config_dir,
      List<String> allowlist_external_dirs,
      List<String> allowlist_external_urls,
      String version,
      String config_source,
      bool recovery_mode,
      bool safe_mode,
      State state,
      String? external_url,
      String? internal_url,
      List<String>? whitelist_external_dirs,
      String currency,
      String? country,
      String language});

  @override
  $UnitSystemCopyWith<$Res> get unit_system;
}

/// @nodoc
class __$$HassConfigImplCopyWithImpl<$Res>
    extends _$HassConfigCopyWithImpl<$Res, _$HassConfigImpl>
    implements _$$HassConfigImplCopyWith<$Res> {
  __$$HassConfigImplCopyWithImpl(
      _$HassConfigImpl _value, $Res Function(_$HassConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of HassConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? elevation = null,
    Object? unit_system = null,
    Object? location_name = null,
    Object? time_zone = null,
    Object? components = null,
    Object? config_dir = null,
    Object? allowlist_external_dirs = null,
    Object? allowlist_external_urls = null,
    Object? version = null,
    Object? config_source = null,
    Object? recovery_mode = null,
    Object? safe_mode = null,
    Object? state = null,
    Object? external_url = freezed,
    Object? internal_url = freezed,
    Object? whitelist_external_dirs = freezed,
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
      unit_system: null == unit_system
          ? _value.unit_system
          : unit_system // ignore: cast_nullable_to_non_nullable
              as UnitSystem,
      location_name: null == location_name
          ? _value.location_name
          : location_name // ignore: cast_nullable_to_non_nullable
              as String,
      time_zone: null == time_zone
          ? _value.time_zone
          : time_zone // ignore: cast_nullable_to_non_nullable
              as String,
      components: null == components
          ? _value._components
          : components // ignore: cast_nullable_to_non_nullable
              as List<String>,
      config_dir: null == config_dir
          ? _value.config_dir
          : config_dir // ignore: cast_nullable_to_non_nullable
              as String,
      allowlist_external_dirs: null == allowlist_external_dirs
          ? _value._allowlist_external_dirs
          : allowlist_external_dirs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowlist_external_urls: null == allowlist_external_urls
          ? _value._allowlist_external_urls
          : allowlist_external_urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      config_source: null == config_source
          ? _value.config_source
          : config_source // ignore: cast_nullable_to_non_nullable
              as String,
      recovery_mode: null == recovery_mode
          ? _value.recovery_mode
          : recovery_mode // ignore: cast_nullable_to_non_nullable
              as bool,
      safe_mode: null == safe_mode
          ? _value.safe_mode
          : safe_mode // ignore: cast_nullable_to_non_nullable
              as bool,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as State,
      external_url: freezed == external_url
          ? _value.external_url
          : external_url // ignore: cast_nullable_to_non_nullable
              as String?,
      internal_url: freezed == internal_url
          ? _value.internal_url
          : internal_url // ignore: cast_nullable_to_non_nullable
              as String?,
      whitelist_external_dirs: freezed == whitelist_external_dirs
          ? _value._whitelist_external_dirs
          : whitelist_external_dirs // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
      required this.unit_system,
      required this.location_name,
      required this.time_zone,
      required final List<String> components,
      required this.config_dir,
      required final List<String> allowlist_external_dirs,
      required final List<String> allowlist_external_urls,
      required this.version,
      required this.config_source,
      required this.recovery_mode,
      required this.safe_mode,
      required this.state,
      this.external_url,
      this.internal_url,
      final List<String>? whitelist_external_dirs,
      required this.currency,
      this.country,
      required this.language})
      : _components = components,
        _allowlist_external_dirs = allowlist_external_dirs,
        _allowlist_external_urls = allowlist_external_urls,
        _whitelist_external_dirs = whitelist_external_dirs;

  factory _$HassConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$HassConfigImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double elevation;
  @override
  final UnitSystem unit_system;
  @override
  final String location_name;
  @override
  final String time_zone;
  final List<String> _components;
  @override
  List<String> get components {
    if (_components is EqualUnmodifiableListView) return _components;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_components);
  }

  @override
  final String config_dir;
  final List<String> _allowlist_external_dirs;
  @override
  List<String> get allowlist_external_dirs {
    if (_allowlist_external_dirs is EqualUnmodifiableListView)
      return _allowlist_external_dirs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowlist_external_dirs);
  }

  final List<String> _allowlist_external_urls;
  @override
  List<String> get allowlist_external_urls {
    if (_allowlist_external_urls is EqualUnmodifiableListView)
      return _allowlist_external_urls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowlist_external_urls);
  }

  @override
  final String version;
  @override
  final String config_source;
  @override
  final bool recovery_mode;
  @override
  final bool safe_mode;
// @StringEnum('NOT_RUNNING', 'STARTING', 'RUNNING', 'STOPPING', 'FINAL_WRITE')
  @override
  final State state;
  @override
  final String? external_url;
  @override
  final String? internal_url;
  final List<String>? _whitelist_external_dirs;
  @override
  List<String>? get whitelist_external_dirs {
    final value = _whitelist_external_dirs;
    if (value == null) return null;
    if (_whitelist_external_dirs is EqualUnmodifiableListView)
      return _whitelist_external_dirs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String currency;
  @override
  final String? country;
  @override
  final String language;

  @override
  String toString() {
    return 'HassConfig(latitude: $latitude, longitude: $longitude, elevation: $elevation, unit_system: $unit_system, location_name: $location_name, time_zone: $time_zone, components: $components, config_dir: $config_dir, allowlist_external_dirs: $allowlist_external_dirs, allowlist_external_urls: $allowlist_external_urls, version: $version, config_source: $config_source, recovery_mode: $recovery_mode, safe_mode: $safe_mode, state: $state, external_url: $external_url, internal_url: $internal_url, whitelist_external_dirs: $whitelist_external_dirs, currency: $currency, country: $country, language: $language)';
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
            (identical(other.unit_system, unit_system) ||
                other.unit_system == unit_system) &&
            (identical(other.location_name, location_name) ||
                other.location_name == location_name) &&
            (identical(other.time_zone, time_zone) ||
                other.time_zone == time_zone) &&
            const DeepCollectionEquality()
                .equals(other._components, _components) &&
            (identical(other.config_dir, config_dir) ||
                other.config_dir == config_dir) &&
            const DeepCollectionEquality().equals(
                other._allowlist_external_dirs, _allowlist_external_dirs) &&
            const DeepCollectionEquality().equals(
                other._allowlist_external_urls, _allowlist_external_urls) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.config_source, config_source) ||
                other.config_source == config_source) &&
            (identical(other.recovery_mode, recovery_mode) ||
                other.recovery_mode == recovery_mode) &&
            (identical(other.safe_mode, safe_mode) ||
                other.safe_mode == safe_mode) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.external_url, external_url) ||
                other.external_url == external_url) &&
            (identical(other.internal_url, internal_url) ||
                other.internal_url == internal_url) &&
            const DeepCollectionEquality().equals(
                other._whitelist_external_dirs, _whitelist_external_dirs) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        latitude,
        longitude,
        elevation,
        unit_system,
        location_name,
        time_zone,
        const DeepCollectionEquality().hash(_components),
        config_dir,
        const DeepCollectionEquality().hash(_allowlist_external_dirs),
        const DeepCollectionEquality().hash(_allowlist_external_urls),
        version,
        config_source,
        recovery_mode,
        safe_mode,
        state,
        external_url,
        internal_url,
        const DeepCollectionEquality().hash(_whitelist_external_dirs),
        currency,
        country,
        language
      ]);

  /// Create a copy of HassConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      required final UnitSystem unit_system,
      required final String location_name,
      required final String time_zone,
      required final List<String> components,
      required final String config_dir,
      required final List<String> allowlist_external_dirs,
      required final List<String> allowlist_external_urls,
      required final String version,
      required final String config_source,
      required final bool recovery_mode,
      required final bool safe_mode,
      required final State state,
      final String? external_url,
      final String? internal_url,
      final List<String>? whitelist_external_dirs,
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
  UnitSystem get unit_system;
  @override
  String get location_name;
  @override
  String get time_zone;
  @override
  List<String> get components;
  @override
  String get config_dir;
  @override
  List<String> get allowlist_external_dirs;
  @override
  List<String> get allowlist_external_urls;
  @override
  String get version;
  @override
  String get config_source;
  @override
  bool get recovery_mode;
  @override
  bool
      get safe_mode; // @StringEnum('NOT_RUNNING', 'STARTING', 'RUNNING', 'STOPPING', 'FINAL_WRITE')
  @override
  State get state;
  @override
  String? get external_url;
  @override
  String? get internal_url;
  @override
  List<String>? get whitelist_external_dirs;
  @override
  String get currency;
  @override
  String? get country;
  @override
  String get language;

  /// Create a copy of HassConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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
  String get wind_speed => throw _privateConstructorUsedError;
  String get accumulated_precipitation => throw _privateConstructorUsedError;

  /// Serializes this UnitSystem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UnitSystem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      String wind_speed,
      String accumulated_precipitation});
}

/// @nodoc
class _$UnitSystemCopyWithImpl<$Res, $Val extends UnitSystem>
    implements $UnitSystemCopyWith<$Res> {
  _$UnitSystemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnitSystem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? length = null,
    Object? mass = null,
    Object? volume = null,
    Object? temperature = null,
    Object? pressure = null,
    Object? wind_speed = null,
    Object? accumulated_precipitation = null,
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
      wind_speed: null == wind_speed
          ? _value.wind_speed
          : wind_speed // ignore: cast_nullable_to_non_nullable
              as String,
      accumulated_precipitation: null == accumulated_precipitation
          ? _value.accumulated_precipitation
          : accumulated_precipitation // ignore: cast_nullable_to_non_nullable
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
      String wind_speed,
      String accumulated_precipitation});
}

/// @nodoc
class __$$UnitSystemImplCopyWithImpl<$Res>
    extends _$UnitSystemCopyWithImpl<$Res, _$UnitSystemImpl>
    implements _$$UnitSystemImplCopyWith<$Res> {
  __$$UnitSystemImplCopyWithImpl(
      _$UnitSystemImpl _value, $Res Function(_$UnitSystemImpl) _then)
      : super(_value, _then);

  /// Create a copy of UnitSystem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? length = null,
    Object? mass = null,
    Object? volume = null,
    Object? temperature = null,
    Object? pressure = null,
    Object? wind_speed = null,
    Object? accumulated_precipitation = null,
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
      wind_speed: null == wind_speed
          ? _value.wind_speed
          : wind_speed // ignore: cast_nullable_to_non_nullable
              as String,
      accumulated_precipitation: null == accumulated_precipitation
          ? _value.accumulated_precipitation
          : accumulated_precipitation // ignore: cast_nullable_to_non_nullable
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
      required this.wind_speed,
      required this.accumulated_precipitation});

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
  final String wind_speed;
  @override
  final String accumulated_precipitation;

  @override
  String toString() {
    return 'UnitSystem(length: $length, mass: $mass, volume: $volume, temperature: $temperature, pressure: $pressure, wind_speed: $wind_speed, accumulated_precipitation: $accumulated_precipitation)';
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
            (identical(other.wind_speed, wind_speed) ||
                other.wind_speed == wind_speed) &&
            (identical(other.accumulated_precipitation,
                    accumulated_precipitation) ||
                other.accumulated_precipitation == accumulated_precipitation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, length, mass, volume,
      temperature, pressure, wind_speed, accumulated_precipitation);

  /// Create a copy of UnitSystem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      required final String wind_speed,
      required final String accumulated_precipitation}) = _$UnitSystemImpl;

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
  String get wind_speed;
  @override
  String get accumulated_precipitation;

  /// Create a copy of UnitSystem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnitSystemImplCopyWith<_$UnitSystemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
