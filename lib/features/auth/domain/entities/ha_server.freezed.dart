// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ha_server.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HaServer {
  String? get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Uri get uri => throw _privateConstructorUsedError;
  HaVersion get version => throw _privateConstructorUsedError;
  Uri? get internalUrl => throw _privateConstructorUsedError;
  Uri? get externalUrl => throw _privateConstructorUsedError;

  /// Create a copy of HaServer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HaServerCopyWith<HaServer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HaServerCopyWith<$Res> {
  factory $HaServerCopyWith(HaServer value, $Res Function(HaServer) then) =
      _$HaServerCopyWithImpl<$Res, HaServer>;
  @useResult
  $Res call(
      {String? uuid,
      String name,
      Uri uri,
      HaVersion version,
      Uri? internalUrl,
      Uri? externalUrl});

  $HaVersionCopyWith<$Res> get version;
}

/// @nodoc
class _$HaServerCopyWithImpl<$Res, $Val extends HaServer>
    implements $HaServerCopyWith<$Res> {
  _$HaServerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HaServer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? name = null,
    Object? uri = null,
    Object? version = null,
    Object? internalUrl = freezed,
    Object? externalUrl = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as HaVersion,
      internalUrl: freezed == internalUrl
          ? _value.internalUrl
          : internalUrl // ignore: cast_nullable_to_non_nullable
              as Uri?,
      externalUrl: freezed == externalUrl
          ? _value.externalUrl
          : externalUrl // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ) as $Val);
  }

  /// Create a copy of HaServer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HaVersionCopyWith<$Res> get version {
    return $HaVersionCopyWith<$Res>(_value.version, (value) {
      return _then(_value.copyWith(version: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HaServerImplCopyWith<$Res>
    implements $HaServerCopyWith<$Res> {
  factory _$$HaServerImplCopyWith(
          _$HaServerImpl value, $Res Function(_$HaServerImpl) then) =
      __$$HaServerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uuid,
      String name,
      Uri uri,
      HaVersion version,
      Uri? internalUrl,
      Uri? externalUrl});

  @override
  $HaVersionCopyWith<$Res> get version;
}

/// @nodoc
class __$$HaServerImplCopyWithImpl<$Res>
    extends _$HaServerCopyWithImpl<$Res, _$HaServerImpl>
    implements _$$HaServerImplCopyWith<$Res> {
  __$$HaServerImplCopyWithImpl(
      _$HaServerImpl _value, $Res Function(_$HaServerImpl) _then)
      : super(_value, _then);

  /// Create a copy of HaServer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? name = null,
    Object? uri = null,
    Object? version = null,
    Object? internalUrl = freezed,
    Object? externalUrl = freezed,
  }) {
    return _then(_$HaServerImpl(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as HaVersion,
      internalUrl: freezed == internalUrl
          ? _value.internalUrl
          : internalUrl // ignore: cast_nullable_to_non_nullable
              as Uri?,
      externalUrl: freezed == externalUrl
          ? _value.externalUrl
          : externalUrl // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ));
  }
}

/// @nodoc

class _$HaServerImpl implements _HaServer {
  _$HaServerImpl(
      {this.uuid,
      required this.name,
      required this.uri,
      required this.version,
      this.internalUrl,
      this.externalUrl});

  @override
  final String? uuid;
  @override
  final String name;
  @override
  final Uri uri;
  @override
  final HaVersion version;
  @override
  final Uri? internalUrl;
  @override
  final Uri? externalUrl;

  @override
  String toString() {
    return 'HaServer(uuid: $uuid, name: $name, uri: $uri, version: $version, internalUrl: $internalUrl, externalUrl: $externalUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HaServerImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.uri, uri) || other.uri == uri) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.internalUrl, internalUrl) ||
                other.internalUrl == internalUrl) &&
            (identical(other.externalUrl, externalUrl) ||
                other.externalUrl == externalUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, uuid, name, uri, version, internalUrl, externalUrl);

  /// Create a copy of HaServer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HaServerImplCopyWith<_$HaServerImpl> get copyWith =>
      __$$HaServerImplCopyWithImpl<_$HaServerImpl>(this, _$identity);
}

abstract class _HaServer implements HaServer {
  factory _HaServer(
      {final String? uuid,
      required final String name,
      required final Uri uri,
      required final HaVersion version,
      final Uri? internalUrl,
      final Uri? externalUrl}) = _$HaServerImpl;

  @override
  String? get uuid;
  @override
  String get name;
  @override
  Uri get uri;
  @override
  HaVersion get version;
  @override
  Uri? get internalUrl;
  @override
  Uri? get externalUrl;

  /// Create a copy of HaServer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HaServerImplCopyWith<_$HaServerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
