// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) server,
    required TResult Function(String? message) userBrake,
    required TResult Function() storage,
    required TResult Function() missingCredentials,
    required TResult Function() refreshToken,
    required TResult Function() connection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? server,
    TResult? Function(String? message)? userBrake,
    TResult? Function()? storage,
    TResult? Function()? missingCredentials,
    TResult? Function()? refreshToken,
    TResult? Function()? connection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? server,
    TResult Function(String? message)? userBrake,
    TResult Function()? storage,
    TResult Function()? missingCredentials,
    TResult Function()? refreshToken,
    TResult Function()? connection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Server value) server,
    required TResult Function(UserBrake value) userBrake,
    required TResult Function(Storage value) storage,
    required TResult Function(MissingCredentials value) missingCredentials,
    required TResult Function(RefreshTokenFailure value) refreshToken,
    required TResult Function(Connection value) connection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Server value)? server,
    TResult? Function(UserBrake value)? userBrake,
    TResult? Function(Storage value)? storage,
    TResult? Function(MissingCredentials value)? missingCredentials,
    TResult? Function(RefreshTokenFailure value)? refreshToken,
    TResult? Function(Connection value)? connection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Server value)? server,
    TResult Function(UserBrake value)? userBrake,
    TResult Function(Storage value)? storage,
    TResult Function(MissingCredentials value)? missingCredentials,
    TResult Function(RefreshTokenFailure value)? refreshToken,
    TResult Function(Connection value)? connection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthFailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(
          AuthFailure value, $Res Function(AuthFailure) then) =
      _$AuthFailureCopyWithImpl<$Res, AuthFailure>;
}

/// @nodoc
class _$AuthFailureCopyWithImpl<$Res, $Val extends AuthFailure>
    implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ServerImplCopyWith<$Res> {
  factory _$$ServerImplCopyWith(
          _$ServerImpl value, $Res Function(_$ServerImpl) then) =
      __$$ServerImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ServerImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$ServerImpl>
    implements _$$ServerImplCopyWith<$Res> {
  __$$ServerImplCopyWithImpl(
      _$ServerImpl _value, $Res Function(_$ServerImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ServerImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ServerImpl extends Server {
  const _$ServerImpl([this.message]) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'AuthFailure.server(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerImplCopyWith<_$ServerImpl> get copyWith =>
      __$$ServerImplCopyWithImpl<_$ServerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) server,
    required TResult Function(String? message) userBrake,
    required TResult Function() storage,
    required TResult Function() missingCredentials,
    required TResult Function() refreshToken,
    required TResult Function() connection,
  }) {
    return server(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? server,
    TResult? Function(String? message)? userBrake,
    TResult? Function()? storage,
    TResult? Function()? missingCredentials,
    TResult? Function()? refreshToken,
    TResult? Function()? connection,
  }) {
    return server?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? server,
    TResult Function(String? message)? userBrake,
    TResult Function()? storage,
    TResult Function()? missingCredentials,
    TResult Function()? refreshToken,
    TResult Function()? connection,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Server value) server,
    required TResult Function(UserBrake value) userBrake,
    required TResult Function(Storage value) storage,
    required TResult Function(MissingCredentials value) missingCredentials,
    required TResult Function(RefreshTokenFailure value) refreshToken,
    required TResult Function(Connection value) connection,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Server value)? server,
    TResult? Function(UserBrake value)? userBrake,
    TResult? Function(Storage value)? storage,
    TResult? Function(MissingCredentials value)? missingCredentials,
    TResult? Function(RefreshTokenFailure value)? refreshToken,
    TResult? Function(Connection value)? connection,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Server value)? server,
    TResult Function(UserBrake value)? userBrake,
    TResult Function(Storage value)? storage,
    TResult Function(MissingCredentials value)? missingCredentials,
    TResult Function(RefreshTokenFailure value)? refreshToken,
    TResult Function(Connection value)? connection,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class Server extends AuthFailure {
  const factory Server([final String? message]) = _$ServerImpl;
  const Server._() : super._();

  String? get message;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerImplCopyWith<_$ServerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserBrakeImplCopyWith<$Res> {
  factory _$$UserBrakeImplCopyWith(
          _$UserBrakeImpl value, $Res Function(_$UserBrakeImpl) then) =
      __$$UserBrakeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UserBrakeImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$UserBrakeImpl>
    implements _$$UserBrakeImplCopyWith<$Res> {
  __$$UserBrakeImplCopyWithImpl(
      _$UserBrakeImpl _value, $Res Function(_$UserBrakeImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$UserBrakeImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UserBrakeImpl extends UserBrake {
  const _$UserBrakeImpl([this.message]) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'AuthFailure.userBrake(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserBrakeImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserBrakeImplCopyWith<_$UserBrakeImpl> get copyWith =>
      __$$UserBrakeImplCopyWithImpl<_$UserBrakeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) server,
    required TResult Function(String? message) userBrake,
    required TResult Function() storage,
    required TResult Function() missingCredentials,
    required TResult Function() refreshToken,
    required TResult Function() connection,
  }) {
    return userBrake(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? server,
    TResult? Function(String? message)? userBrake,
    TResult? Function()? storage,
    TResult? Function()? missingCredentials,
    TResult? Function()? refreshToken,
    TResult? Function()? connection,
  }) {
    return userBrake?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? server,
    TResult Function(String? message)? userBrake,
    TResult Function()? storage,
    TResult Function()? missingCredentials,
    TResult Function()? refreshToken,
    TResult Function()? connection,
    required TResult orElse(),
  }) {
    if (userBrake != null) {
      return userBrake(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Server value) server,
    required TResult Function(UserBrake value) userBrake,
    required TResult Function(Storage value) storage,
    required TResult Function(MissingCredentials value) missingCredentials,
    required TResult Function(RefreshTokenFailure value) refreshToken,
    required TResult Function(Connection value) connection,
  }) {
    return userBrake(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Server value)? server,
    TResult? Function(UserBrake value)? userBrake,
    TResult? Function(Storage value)? storage,
    TResult? Function(MissingCredentials value)? missingCredentials,
    TResult? Function(RefreshTokenFailure value)? refreshToken,
    TResult? Function(Connection value)? connection,
  }) {
    return userBrake?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Server value)? server,
    TResult Function(UserBrake value)? userBrake,
    TResult Function(Storage value)? storage,
    TResult Function(MissingCredentials value)? missingCredentials,
    TResult Function(RefreshTokenFailure value)? refreshToken,
    TResult Function(Connection value)? connection,
    required TResult orElse(),
  }) {
    if (userBrake != null) {
      return userBrake(this);
    }
    return orElse();
  }
}

abstract class UserBrake extends AuthFailure {
  const factory UserBrake([final String? message]) = _$UserBrakeImpl;
  const UserBrake._() : super._();

  String? get message;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserBrakeImplCopyWith<_$UserBrakeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StorageImplCopyWith<$Res> {
  factory _$$StorageImplCopyWith(
          _$StorageImpl value, $Res Function(_$StorageImpl) then) =
      __$$StorageImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StorageImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$StorageImpl>
    implements _$$StorageImplCopyWith<$Res> {
  __$$StorageImplCopyWithImpl(
      _$StorageImpl _value, $Res Function(_$StorageImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StorageImpl extends Storage {
  const _$StorageImpl() : super._();

  @override
  String toString() {
    return 'AuthFailure.storage()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StorageImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) server,
    required TResult Function(String? message) userBrake,
    required TResult Function() storage,
    required TResult Function() missingCredentials,
    required TResult Function() refreshToken,
    required TResult Function() connection,
  }) {
    return storage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? server,
    TResult? Function(String? message)? userBrake,
    TResult? Function()? storage,
    TResult? Function()? missingCredentials,
    TResult? Function()? refreshToken,
    TResult? Function()? connection,
  }) {
    return storage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? server,
    TResult Function(String? message)? userBrake,
    TResult Function()? storage,
    TResult Function()? missingCredentials,
    TResult Function()? refreshToken,
    TResult Function()? connection,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Server value) server,
    required TResult Function(UserBrake value) userBrake,
    required TResult Function(Storage value) storage,
    required TResult Function(MissingCredentials value) missingCredentials,
    required TResult Function(RefreshTokenFailure value) refreshToken,
    required TResult Function(Connection value) connection,
  }) {
    return storage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Server value)? server,
    TResult? Function(UserBrake value)? userBrake,
    TResult? Function(Storage value)? storage,
    TResult? Function(MissingCredentials value)? missingCredentials,
    TResult? Function(RefreshTokenFailure value)? refreshToken,
    TResult? Function(Connection value)? connection,
  }) {
    return storage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Server value)? server,
    TResult Function(UserBrake value)? userBrake,
    TResult Function(Storage value)? storage,
    TResult Function(MissingCredentials value)? missingCredentials,
    TResult Function(RefreshTokenFailure value)? refreshToken,
    TResult Function(Connection value)? connection,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage(this);
    }
    return orElse();
  }
}

abstract class Storage extends AuthFailure {
  const factory Storage() = _$StorageImpl;
  const Storage._() : super._();
}

/// @nodoc
abstract class _$$MissingCredentialsImplCopyWith<$Res> {
  factory _$$MissingCredentialsImplCopyWith(_$MissingCredentialsImpl value,
          $Res Function(_$MissingCredentialsImpl) then) =
      __$$MissingCredentialsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MissingCredentialsImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$MissingCredentialsImpl>
    implements _$$MissingCredentialsImplCopyWith<$Res> {
  __$$MissingCredentialsImplCopyWithImpl(_$MissingCredentialsImpl _value,
      $Res Function(_$MissingCredentialsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MissingCredentialsImpl extends MissingCredentials {
  const _$MissingCredentialsImpl() : super._();

  @override
  String toString() {
    return 'AuthFailure.missingCredentials()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MissingCredentialsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) server,
    required TResult Function(String? message) userBrake,
    required TResult Function() storage,
    required TResult Function() missingCredentials,
    required TResult Function() refreshToken,
    required TResult Function() connection,
  }) {
    return missingCredentials();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? server,
    TResult? Function(String? message)? userBrake,
    TResult? Function()? storage,
    TResult? Function()? missingCredentials,
    TResult? Function()? refreshToken,
    TResult? Function()? connection,
  }) {
    return missingCredentials?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? server,
    TResult Function(String? message)? userBrake,
    TResult Function()? storage,
    TResult Function()? missingCredentials,
    TResult Function()? refreshToken,
    TResult Function()? connection,
    required TResult orElse(),
  }) {
    if (missingCredentials != null) {
      return missingCredentials();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Server value) server,
    required TResult Function(UserBrake value) userBrake,
    required TResult Function(Storage value) storage,
    required TResult Function(MissingCredentials value) missingCredentials,
    required TResult Function(RefreshTokenFailure value) refreshToken,
    required TResult Function(Connection value) connection,
  }) {
    return missingCredentials(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Server value)? server,
    TResult? Function(UserBrake value)? userBrake,
    TResult? Function(Storage value)? storage,
    TResult? Function(MissingCredentials value)? missingCredentials,
    TResult? Function(RefreshTokenFailure value)? refreshToken,
    TResult? Function(Connection value)? connection,
  }) {
    return missingCredentials?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Server value)? server,
    TResult Function(UserBrake value)? userBrake,
    TResult Function(Storage value)? storage,
    TResult Function(MissingCredentials value)? missingCredentials,
    TResult Function(RefreshTokenFailure value)? refreshToken,
    TResult Function(Connection value)? connection,
    required TResult orElse(),
  }) {
    if (missingCredentials != null) {
      return missingCredentials(this);
    }
    return orElse();
  }
}

abstract class MissingCredentials extends AuthFailure {
  const factory MissingCredentials() = _$MissingCredentialsImpl;
  const MissingCredentials._() : super._();
}

/// @nodoc
abstract class _$$RefreshTokenFailureImplCopyWith<$Res> {
  factory _$$RefreshTokenFailureImplCopyWith(_$RefreshTokenFailureImpl value,
          $Res Function(_$RefreshTokenFailureImpl) then) =
      __$$RefreshTokenFailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshTokenFailureImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$RefreshTokenFailureImpl>
    implements _$$RefreshTokenFailureImplCopyWith<$Res> {
  __$$RefreshTokenFailureImplCopyWithImpl(_$RefreshTokenFailureImpl _value,
      $Res Function(_$RefreshTokenFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshTokenFailureImpl extends RefreshTokenFailure {
  const _$RefreshTokenFailureImpl() : super._();

  @override
  String toString() {
    return 'AuthFailure.refreshToken()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTokenFailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) server,
    required TResult Function(String? message) userBrake,
    required TResult Function() storage,
    required TResult Function() missingCredentials,
    required TResult Function() refreshToken,
    required TResult Function() connection,
  }) {
    return refreshToken();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? server,
    TResult? Function(String? message)? userBrake,
    TResult? Function()? storage,
    TResult? Function()? missingCredentials,
    TResult? Function()? refreshToken,
    TResult? Function()? connection,
  }) {
    return refreshToken?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? server,
    TResult Function(String? message)? userBrake,
    TResult Function()? storage,
    TResult Function()? missingCredentials,
    TResult Function()? refreshToken,
    TResult Function()? connection,
    required TResult orElse(),
  }) {
    if (refreshToken != null) {
      return refreshToken();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Server value) server,
    required TResult Function(UserBrake value) userBrake,
    required TResult Function(Storage value) storage,
    required TResult Function(MissingCredentials value) missingCredentials,
    required TResult Function(RefreshTokenFailure value) refreshToken,
    required TResult Function(Connection value) connection,
  }) {
    return refreshToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Server value)? server,
    TResult? Function(UserBrake value)? userBrake,
    TResult? Function(Storage value)? storage,
    TResult? Function(MissingCredentials value)? missingCredentials,
    TResult? Function(RefreshTokenFailure value)? refreshToken,
    TResult? Function(Connection value)? connection,
  }) {
    return refreshToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Server value)? server,
    TResult Function(UserBrake value)? userBrake,
    TResult Function(Storage value)? storage,
    TResult Function(MissingCredentials value)? missingCredentials,
    TResult Function(RefreshTokenFailure value)? refreshToken,
    TResult Function(Connection value)? connection,
    required TResult orElse(),
  }) {
    if (refreshToken != null) {
      return refreshToken(this);
    }
    return orElse();
  }
}

abstract class RefreshTokenFailure extends AuthFailure {
  const factory RefreshTokenFailure() = _$RefreshTokenFailureImpl;
  const RefreshTokenFailure._() : super._();
}

/// @nodoc
abstract class _$$ConnectionImplCopyWith<$Res> {
  factory _$$ConnectionImplCopyWith(
          _$ConnectionImpl value, $Res Function(_$ConnectionImpl) then) =
      __$$ConnectionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$ConnectionImpl>
    implements _$$ConnectionImplCopyWith<$Res> {
  __$$ConnectionImplCopyWithImpl(
      _$ConnectionImpl _value, $Res Function(_$ConnectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectionImpl extends Connection {
  const _$ConnectionImpl() : super._();

  @override
  String toString() {
    return 'AuthFailure.connection()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) server,
    required TResult Function(String? message) userBrake,
    required TResult Function() storage,
    required TResult Function() missingCredentials,
    required TResult Function() refreshToken,
    required TResult Function() connection,
  }) {
    return connection();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? server,
    TResult? Function(String? message)? userBrake,
    TResult? Function()? storage,
    TResult? Function()? missingCredentials,
    TResult? Function()? refreshToken,
    TResult? Function()? connection,
  }) {
    return connection?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? server,
    TResult Function(String? message)? userBrake,
    TResult Function()? storage,
    TResult Function()? missingCredentials,
    TResult Function()? refreshToken,
    TResult Function()? connection,
    required TResult orElse(),
  }) {
    if (connection != null) {
      return connection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Server value) server,
    required TResult Function(UserBrake value) userBrake,
    required TResult Function(Storage value) storage,
    required TResult Function(MissingCredentials value) missingCredentials,
    required TResult Function(RefreshTokenFailure value) refreshToken,
    required TResult Function(Connection value) connection,
  }) {
    return connection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Server value)? server,
    TResult? Function(UserBrake value)? userBrake,
    TResult? Function(Storage value)? storage,
    TResult? Function(MissingCredentials value)? missingCredentials,
    TResult? Function(RefreshTokenFailure value)? refreshToken,
    TResult? Function(Connection value)? connection,
  }) {
    return connection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Server value)? server,
    TResult Function(UserBrake value)? userBrake,
    TResult Function(Storage value)? storage,
    TResult Function(MissingCredentials value)? missingCredentials,
    TResult Function(RefreshTokenFailure value)? refreshToken,
    TResult Function(Connection value)? connection,
    required TResult orElse(),
  }) {
    if (connection != null) {
      return connection(this);
    }
    return orElse();
  }
}

abstract class Connection extends AuthFailure {
  const factory Connection() = _$ConnectionImpl;
  const Connection._() : super._();
}
