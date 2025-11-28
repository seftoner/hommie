// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../domain/entities/auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Unauthenticated value)?  unauthenticated,TResult Function( Authenticating value)?  authenticating,TResult Function( Authenticated value)?  authenticated,TResult Function( Refreshing value)?  refreshing,TResult Function( Revoked value)?  revoked,TResult Function( Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case Authenticating() when authenticating != null:
return authenticating(_that);case Authenticated() when authenticated != null:
return authenticated(_that);case Refreshing() when refreshing != null:
return refreshing(_that);case Revoked() when revoked != null:
return revoked(_that);case Failure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Unauthenticated value)  unauthenticated,required TResult Function( Authenticating value)  authenticating,required TResult Function( Authenticated value)  authenticated,required TResult Function( Refreshing value)  refreshing,required TResult Function( Revoked value)  revoked,required TResult Function( Failure value)  failure,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Unauthenticated():
return unauthenticated(_that);case Authenticating():
return authenticating(_that);case Authenticated():
return authenticated(_that);case Refreshing():
return refreshing(_that);case Revoked():
return revoked(_that);case Failure():
return failure(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Unauthenticated value)?  unauthenticated,TResult? Function( Authenticating value)?  authenticating,TResult? Function( Authenticated value)?  authenticated,TResult? Function( Refreshing value)?  refreshing,TResult? Function( Revoked value)?  revoked,TResult? Function( Failure value)?  failure,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case Authenticating() when authenticating != null:
return authenticating(_that);case Authenticated() when authenticated != null:
return authenticated(_that);case Refreshing() when refreshing != null:
return refreshing(_that);case Revoked() when revoked != null:
return revoked(_that);case Failure() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  unauthenticated,TResult Function()?  authenticating,TResult Function( Credentials credentials)?  authenticated,TResult Function( Credentials credentials)?  refreshing,TResult Function( AuthFailure? failure)?  revoked,TResult Function( AuthFailure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Unauthenticated() when unauthenticated != null:
return unauthenticated();case Authenticating() when authenticating != null:
return authenticating();case Authenticated() when authenticated != null:
return authenticated(_that.credentials);case Refreshing() when refreshing != null:
return refreshing(_that.credentials);case Revoked() when revoked != null:
return revoked(_that.failure);case Failure() when failure != null:
return failure(_that.failure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  unauthenticated,required TResult Function()  authenticating,required TResult Function( Credentials credentials)  authenticated,required TResult Function( Credentials credentials)  refreshing,required TResult Function( AuthFailure? failure)  revoked,required TResult Function( AuthFailure failure)  failure,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case Unauthenticated():
return unauthenticated();case Authenticating():
return authenticating();case Authenticated():
return authenticated(_that.credentials);case Refreshing():
return refreshing(_that.credentials);case Revoked():
return revoked(_that.failure);case Failure():
return failure(_that.failure);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  unauthenticated,TResult? Function()?  authenticating,TResult? Function( Credentials credentials)?  authenticated,TResult? Function( Credentials credentials)?  refreshing,TResult? Function( AuthFailure? failure)?  revoked,TResult? Function( AuthFailure failure)?  failure,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Unauthenticated() when unauthenticated != null:
return unauthenticated();case Authenticating() when authenticating != null:
return authenticating();case Authenticated() when authenticated != null:
return authenticated(_that.credentials);case Refreshing() when refreshing != null:
return refreshing(_that.credentials);case Revoked() when revoked != null:
return revoked(_that.failure);case Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class Initial extends AuthState {
  const Initial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.initial()';
}


}




/// @nodoc


class Unauthenticated extends AuthState {
  const Unauthenticated(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Unauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}




/// @nodoc


class Authenticating extends AuthState {
  const Authenticating(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Authenticating);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.authenticating()';
}


}




/// @nodoc


class Authenticated extends AuthState {
  const Authenticated(this.credentials): super._();
  

 final  Credentials credentials;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticatedCopyWith<Authenticated> get copyWith => _$AuthenticatedCopyWithImpl<Authenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Authenticated&&(identical(other.credentials, credentials) || other.credentials == credentials));
}


@override
int get hashCode => Object.hash(runtimeType,credentials);

@override
String toString() {
  return 'AuthState.authenticated(credentials: $credentials)';
}


}

/// @nodoc
abstract mixin class $AuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthenticatedCopyWith(Authenticated value, $Res Function(Authenticated) _then) = _$AuthenticatedCopyWithImpl;
@useResult
$Res call({
 Credentials credentials
});




}
/// @nodoc
class _$AuthenticatedCopyWithImpl<$Res>
    implements $AuthenticatedCopyWith<$Res> {
  _$AuthenticatedCopyWithImpl(this._self, this._then);

  final Authenticated _self;
  final $Res Function(Authenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? credentials = null,}) {
  return _then(Authenticated(
null == credentials ? _self.credentials : credentials // ignore: cast_nullable_to_non_nullable
as Credentials,
  ));
}


}

/// @nodoc


class Refreshing extends AuthState {
  const Refreshing(this.credentials): super._();
  

 final  Credentials credentials;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefreshingCopyWith<Refreshing> get copyWith => _$RefreshingCopyWithImpl<Refreshing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Refreshing&&(identical(other.credentials, credentials) || other.credentials == credentials));
}


@override
int get hashCode => Object.hash(runtimeType,credentials);

@override
String toString() {
  return 'AuthState.refreshing(credentials: $credentials)';
}


}

/// @nodoc
abstract mixin class $RefreshingCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $RefreshingCopyWith(Refreshing value, $Res Function(Refreshing) _then) = _$RefreshingCopyWithImpl;
@useResult
$Res call({
 Credentials credentials
});




}
/// @nodoc
class _$RefreshingCopyWithImpl<$Res>
    implements $RefreshingCopyWith<$Res> {
  _$RefreshingCopyWithImpl(this._self, this._then);

  final Refreshing _self;
  final $Res Function(Refreshing) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? credentials = null,}) {
  return _then(Refreshing(
null == credentials ? _self.credentials : credentials // ignore: cast_nullable_to_non_nullable
as Credentials,
  ));
}


}

/// @nodoc


class Revoked extends AuthState {
  const Revoked({this.failure}): super._();
  

 final  AuthFailure? failure;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevokedCopyWith<Revoked> get copyWith => _$RevokedCopyWithImpl<Revoked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Revoked&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'AuthState.revoked(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $RevokedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $RevokedCopyWith(Revoked value, $Res Function(Revoked) _then) = _$RevokedCopyWithImpl;
@useResult
$Res call({
 AuthFailure? failure
});


$AuthFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$RevokedCopyWithImpl<$Res>
    implements $RevokedCopyWith<$Res> {
  _$RevokedCopyWithImpl(this._self, this._then);

  final Revoked _self;
  final $Res Function(Revoked) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = freezed,}) {
  return _then(Revoked(
failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AuthFailure?,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $AuthFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

/// @nodoc


class Failure extends AuthState {
  const Failure(this.failure): super._();
  

 final  AuthFailure failure;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'AuthState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 AuthFailure failure
});


$AuthFailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AuthFailure,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthFailureCopyWith<$Res> get failure {
  
  return $AuthFailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
