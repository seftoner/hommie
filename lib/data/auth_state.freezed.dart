// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token) signedIn,
    required TResult Function() initial,
    required TResult Function() signedOut,
    required TResult Function() unauthenticated,
    required TResult Function(AuthFailure failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token)? signedIn,
    TResult? Function()? initial,
    TResult? Function()? signedOut,
    TResult? Function()? unauthenticated,
    TResult? Function(AuthFailure failure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token)? signedIn,
    TResult Function()? initial,
    TResult Function()? signedOut,
    TResult Function()? unauthenticated,
    TResult Function(AuthFailure failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignedIn value) signedIn,
    required TResult Function(_Initial value) initial,
    required TResult Function(_SignedOut value) signedOut,
    required TResult Function(_Unauthicated value) unauthenticated,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SignedIn value)? signedIn,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SignedOut value)? signedOut,
    TResult? Function(_Unauthicated value)? unauthenticated,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignedIn value)? signedIn,
    TResult Function(_Initial value)? initial,
    TResult Function(_SignedOut value)? signedOut,
    TResult Function(_Unauthicated value)? unauthenticated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SignedInImplCopyWith<$Res> {
  factory _$$SignedInImplCopyWith(
          _$SignedInImpl value, $Res Function(_$SignedInImpl) then) =
      __$$SignedInImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$SignedInImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$SignedInImpl>
    implements _$$SignedInImplCopyWith<$Res> {
  __$$SignedInImplCopyWithImpl(
      _$SignedInImpl _value, $Res Function(_$SignedInImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$SignedInImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignedInImpl extends _SignedIn {
  const _$SignedInImpl({required this.token}) : super._();

  @override
  final String token;

  @override
  String toString() {
    return 'AuthState.signedIn(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignedInImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignedInImplCopyWith<_$SignedInImpl> get copyWith =>
      __$$SignedInImplCopyWithImpl<_$SignedInImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token) signedIn,
    required TResult Function() initial,
    required TResult Function() signedOut,
    required TResult Function() unauthenticated,
    required TResult Function(AuthFailure failure) failure,
  }) {
    return signedIn(token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token)? signedIn,
    TResult? Function()? initial,
    TResult? Function()? signedOut,
    TResult? Function()? unauthenticated,
    TResult? Function(AuthFailure failure)? failure,
  }) {
    return signedIn?.call(token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token)? signedIn,
    TResult Function()? initial,
    TResult Function()? signedOut,
    TResult Function()? unauthenticated,
    TResult Function(AuthFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn(token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignedIn value) signedIn,
    required TResult Function(_Initial value) initial,
    required TResult Function(_SignedOut value) signedOut,
    required TResult Function(_Unauthicated value) unauthenticated,
    required TResult Function(_Failure value) failure,
  }) {
    return signedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SignedIn value)? signedIn,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SignedOut value)? signedOut,
    TResult? Function(_Unauthicated value)? unauthenticated,
    TResult? Function(_Failure value)? failure,
  }) {
    return signedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignedIn value)? signedIn,
    TResult Function(_Initial value)? initial,
    TResult Function(_SignedOut value)? signedOut,
    TResult Function(_Unauthicated value)? unauthenticated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn(this);
    }
    return orElse();
  }
}

abstract class _SignedIn extends AuthState {
  const factory _SignedIn({required final String token}) = _$SignedInImpl;
  const _SignedIn._() : super._();

  String get token;
  @JsonKey(ignore: true)
  _$$SignedInImplCopyWith<_$SignedInImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl extends _Initial {
  const _$InitialImpl() : super._();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token) signedIn,
    required TResult Function() initial,
    required TResult Function() signedOut,
    required TResult Function() unauthenticated,
    required TResult Function(AuthFailure failure) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token)? signedIn,
    TResult? Function()? initial,
    TResult? Function()? signedOut,
    TResult? Function()? unauthenticated,
    TResult? Function(AuthFailure failure)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token)? signedIn,
    TResult Function()? initial,
    TResult Function()? signedOut,
    TResult Function()? unauthenticated,
    TResult Function(AuthFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignedIn value) signedIn,
    required TResult Function(_Initial value) initial,
    required TResult Function(_SignedOut value) signedOut,
    required TResult Function(_Unauthicated value) unauthenticated,
    required TResult Function(_Failure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SignedIn value)? signedIn,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SignedOut value)? signedOut,
    TResult? Function(_Unauthicated value)? unauthenticated,
    TResult? Function(_Failure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignedIn value)? signedIn,
    TResult Function(_Initial value)? initial,
    TResult Function(_SignedOut value)? signedOut,
    TResult Function(_Unauthicated value)? unauthenticated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial extends AuthState {
  const factory _Initial() = _$InitialImpl;
  const _Initial._() : super._();
}

/// @nodoc
abstract class _$$SignedOutImplCopyWith<$Res> {
  factory _$$SignedOutImplCopyWith(
          _$SignedOutImpl value, $Res Function(_$SignedOutImpl) then) =
      __$$SignedOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignedOutImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$SignedOutImpl>
    implements _$$SignedOutImplCopyWith<$Res> {
  __$$SignedOutImplCopyWithImpl(
      _$SignedOutImpl _value, $Res Function(_$SignedOutImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignedOutImpl extends _SignedOut {
  const _$SignedOutImpl() : super._();

  @override
  String toString() {
    return 'AuthState.signedOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignedOutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token) signedIn,
    required TResult Function() initial,
    required TResult Function() signedOut,
    required TResult Function() unauthenticated,
    required TResult Function(AuthFailure failure) failure,
  }) {
    return signedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token)? signedIn,
    TResult? Function()? initial,
    TResult? Function()? signedOut,
    TResult? Function()? unauthenticated,
    TResult? Function(AuthFailure failure)? failure,
  }) {
    return signedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token)? signedIn,
    TResult Function()? initial,
    TResult Function()? signedOut,
    TResult Function()? unauthenticated,
    TResult Function(AuthFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (signedOut != null) {
      return signedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignedIn value) signedIn,
    required TResult Function(_Initial value) initial,
    required TResult Function(_SignedOut value) signedOut,
    required TResult Function(_Unauthicated value) unauthenticated,
    required TResult Function(_Failure value) failure,
  }) {
    return signedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SignedIn value)? signedIn,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SignedOut value)? signedOut,
    TResult? Function(_Unauthicated value)? unauthenticated,
    TResult? Function(_Failure value)? failure,
  }) {
    return signedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignedIn value)? signedIn,
    TResult Function(_Initial value)? initial,
    TResult Function(_SignedOut value)? signedOut,
    TResult Function(_Unauthicated value)? unauthenticated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (signedOut != null) {
      return signedOut(this);
    }
    return orElse();
  }
}

abstract class _SignedOut extends AuthState {
  const factory _SignedOut() = _$SignedOutImpl;
  const _SignedOut._() : super._();
}

/// @nodoc
abstract class _$$UnauthicatedImplCopyWith<$Res> {
  factory _$$UnauthicatedImplCopyWith(
          _$UnauthicatedImpl value, $Res Function(_$UnauthicatedImpl) then) =
      __$$UnauthicatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthicatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnauthicatedImpl>
    implements _$$UnauthicatedImplCopyWith<$Res> {
  __$$UnauthicatedImplCopyWithImpl(
      _$UnauthicatedImpl _value, $Res Function(_$UnauthicatedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UnauthicatedImpl extends _Unauthicated {
  const _$UnauthicatedImpl() : super._();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthicatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token) signedIn,
    required TResult Function() initial,
    required TResult Function() signedOut,
    required TResult Function() unauthenticated,
    required TResult Function(AuthFailure failure) failure,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token)? signedIn,
    TResult? Function()? initial,
    TResult? Function()? signedOut,
    TResult? Function()? unauthenticated,
    TResult? Function(AuthFailure failure)? failure,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token)? signedIn,
    TResult Function()? initial,
    TResult Function()? signedOut,
    TResult Function()? unauthenticated,
    TResult Function(AuthFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignedIn value) signedIn,
    required TResult Function(_Initial value) initial,
    required TResult Function(_SignedOut value) signedOut,
    required TResult Function(_Unauthicated value) unauthenticated,
    required TResult Function(_Failure value) failure,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SignedIn value)? signedIn,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SignedOut value)? signedOut,
    TResult? Function(_Unauthicated value)? unauthenticated,
    TResult? Function(_Failure value)? failure,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignedIn value)? signedIn,
    TResult Function(_Initial value)? initial,
    TResult Function(_SignedOut value)? signedOut,
    TResult Function(_Unauthicated value)? unauthenticated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _Unauthicated extends AuthState {
  const factory _Unauthicated() = _$UnauthicatedImpl;
  const _Unauthicated._() : super._();
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthFailure failure});

  $AuthFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$FailureImpl(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as AuthFailure,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthFailureCopyWith<$Res> get failure {
    return $AuthFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$FailureImpl extends _Failure {
  const _$FailureImpl(this.failure) : super._();

  @override
  final AuthFailure failure;

  @override
  String toString() {
    return 'AuthState.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token) signedIn,
    required TResult Function() initial,
    required TResult Function() signedOut,
    required TResult Function() unauthenticated,
    required TResult Function(AuthFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token)? signedIn,
    TResult? Function()? initial,
    TResult? Function()? signedOut,
    TResult? Function()? unauthenticated,
    TResult? Function(AuthFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token)? signedIn,
    TResult Function()? initial,
    TResult Function()? signedOut,
    TResult Function()? unauthenticated,
    TResult Function(AuthFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignedIn value) signedIn,
    required TResult Function(_Initial value) initial,
    required TResult Function(_SignedOut value) signedOut,
    required TResult Function(_Unauthicated value) unauthenticated,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SignedIn value)? signedIn,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SignedOut value)? signedOut,
    TResult? Function(_Unauthicated value)? unauthenticated,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignedIn value)? signedIn,
    TResult Function(_Initial value)? initial,
    TResult Function(_SignedOut value)? signedOut,
    TResult Function(_Unauthicated value)? unauthenticated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure extends AuthState {
  const factory _Failure(final AuthFailure failure) = _$FailureImpl;
  const _Failure._() : super._();

  AuthFailure get failure;
  @JsonKey(ignore: true)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
