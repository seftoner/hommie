// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure()';
}


}

/// @nodoc
class $AuthFailureCopyWith<$Res>  {
$AuthFailureCopyWith(AuthFailure _, $Res Function(AuthFailure) __);
}


/// Adds pattern-matching-related methods to [AuthFailure].
extension AuthFailurePatterns on AuthFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServerFailure value)?  server,TResult Function( UserBrake value)?  userBrake,TResult Function( Storage value)?  storage,TResult Function( MissingCredentials value)?  missingCredentials,TResult Function( InvalidToken value)?  invalidToken,TResult Function( Connection value)?  connection,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that);case UserBrake() when userBrake != null:
return userBrake(_that);case Storage() when storage != null:
return storage(_that);case MissingCredentials() when missingCredentials != null:
return missingCredentials(_that);case InvalidToken() when invalidToken != null:
return invalidToken(_that);case Connection() when connection != null:
return connection(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServerFailure value)  server,required TResult Function( UserBrake value)  userBrake,required TResult Function( Storage value)  storage,required TResult Function( MissingCredentials value)  missingCredentials,required TResult Function( InvalidToken value)  invalidToken,required TResult Function( Connection value)  connection,}){
final _that = this;
switch (_that) {
case ServerFailure():
return server(_that);case UserBrake():
return userBrake(_that);case Storage():
return storage(_that);case MissingCredentials():
return missingCredentials(_that);case InvalidToken():
return invalidToken(_that);case Connection():
return connection(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServerFailure value)?  server,TResult? Function( UserBrake value)?  userBrake,TResult? Function( Storage value)?  storage,TResult? Function( MissingCredentials value)?  missingCredentials,TResult? Function( InvalidToken value)?  invalidToken,TResult? Function( Connection value)?  connection,}){
final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that);case UserBrake() when userBrake != null:
return userBrake(_that);case Storage() when storage != null:
return storage(_that);case MissingCredentials() when missingCredentials != null:
return missingCredentials(_that);case InvalidToken() when invalidToken != null:
return invalidToken(_that);case Connection() when connection != null:
return connection(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? message)?  server,TResult Function( String? message)?  userBrake,TResult Function()?  storage,TResult Function()?  missingCredentials,TResult Function( String? message)?  invalidToken,TResult Function()?  connection,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that.message);case UserBrake() when userBrake != null:
return userBrake(_that.message);case Storage() when storage != null:
return storage();case MissingCredentials() when missingCredentials != null:
return missingCredentials();case InvalidToken() when invalidToken != null:
return invalidToken(_that.message);case Connection() when connection != null:
return connection();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? message)  server,required TResult Function( String? message)  userBrake,required TResult Function()  storage,required TResult Function()  missingCredentials,required TResult Function( String? message)  invalidToken,required TResult Function()  connection,}) {final _that = this;
switch (_that) {
case ServerFailure():
return server(_that.message);case UserBrake():
return userBrake(_that.message);case Storage():
return storage();case MissingCredentials():
return missingCredentials();case InvalidToken():
return invalidToken(_that.message);case Connection():
return connection();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? message)?  server,TResult? Function( String? message)?  userBrake,TResult? Function()?  storage,TResult? Function()?  missingCredentials,TResult? Function( String? message)?  invalidToken,TResult? Function()?  connection,}) {final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that.message);case UserBrake() when userBrake != null:
return userBrake(_that.message);case Storage() when storage != null:
return storage();case MissingCredentials() when missingCredentials != null:
return missingCredentials();case InvalidToken() when invalidToken != null:
return invalidToken(_that.message);case Connection() when connection != null:
return connection();case _:
  return null;

}
}

}

/// @nodoc


class ServerFailure extends AuthFailure {
  const ServerFailure([this.message]): super._();
  

 final  String? message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.server(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(ServerFailure(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UserBrake extends AuthFailure {
  const UserBrake([this.message]): super._();
  

 final  String? message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserBrakeCopyWith<UserBrake> get copyWith => _$UserBrakeCopyWithImpl<UserBrake>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserBrake&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.userBrake(message: $message)';
}


}

/// @nodoc
abstract mixin class $UserBrakeCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $UserBrakeCopyWith(UserBrake value, $Res Function(UserBrake) _then) = _$UserBrakeCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$UserBrakeCopyWithImpl<$Res>
    implements $UserBrakeCopyWith<$Res> {
  _$UserBrakeCopyWithImpl(this._self, this._then);

  final UserBrake _self;
  final $Res Function(UserBrake) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(UserBrake(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class Storage extends AuthFailure {
  const Storage(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Storage);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.storage()';
}


}




/// @nodoc


class MissingCredentials extends AuthFailure {
  const MissingCredentials(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissingCredentials);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.missingCredentials()';
}


}




/// @nodoc


class InvalidToken extends AuthFailure {
  const InvalidToken([this.message]): super._();
  

 final  String? message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidTokenCopyWith<InvalidToken> get copyWith => _$InvalidTokenCopyWithImpl<InvalidToken>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidToken&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.invalidToken(message: $message)';
}


}

/// @nodoc
abstract mixin class $InvalidTokenCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $InvalidTokenCopyWith(InvalidToken value, $Res Function(InvalidToken) _then) = _$InvalidTokenCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$InvalidTokenCopyWithImpl<$Res>
    implements $InvalidTokenCopyWith<$Res> {
  _$InvalidTokenCopyWithImpl(this._self, this._then);

  final InvalidToken _self;
  final $Res Function(InvalidToken) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(InvalidToken(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class Connection extends AuthFailure {
  const Connection(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Connection);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.connection()';
}


}




// dart format on
