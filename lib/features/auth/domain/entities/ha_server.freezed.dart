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
  String get name => throw _privateConstructorUsedError;
  Uri get uri => throw _privateConstructorUsedError;

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
  $Res call({String name, Uri uri});
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
    Object? name = null,
    Object? uri = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
    ) as $Val);
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
  $Res call({String name, Uri uri});
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
    Object? name = null,
    Object? uri = null,
  }) {
    return _then(_$HaServerImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
    ));
  }
}

/// @nodoc

class _$HaServerImpl implements _HaServer {
  _$HaServerImpl({required this.name, required this.uri});

  @override
  final String name;
  @override
  final Uri uri;

  @override
  String toString() {
    return 'HaServer(name: $name, uri: $uri)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HaServerImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.uri, uri) || other.uri == uri));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, uri);

  /// Create a copy of HaServer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HaServerImplCopyWith<_$HaServerImpl> get copyWith =>
      __$$HaServerImplCopyWithImpl<_$HaServerImpl>(this, _$identity);
}

abstract class _HaServer implements HaServer {
  factory _HaServer({required final String name, required final Uri uri}) =
      _$HaServerImpl;

  @override
  String get name;
  @override
  Uri get uri;

  /// Create a copy of HaServer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HaServerImplCopyWith<_$HaServerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
