// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hub_status_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HubStatusState {

 Server? get server; HAServerConnectionState get connectionState; AuthState get authState;
/// Create a copy of HubStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HubStatusStateCopyWith<HubStatusState> get copyWith => _$HubStatusStateCopyWithImpl<HubStatusState>(this as HubStatusState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HubStatusState&&(identical(other.server, server) || other.server == server)&&(identical(other.connectionState, connectionState) || other.connectionState == connectionState)&&(identical(other.authState, authState) || other.authState == authState));
}


@override
int get hashCode => Object.hash(runtimeType,server,connectionState,authState);

@override
String toString() {
  return 'HubStatusState(server: $server, connectionState: $connectionState, authState: $authState)';
}


}

/// @nodoc
abstract mixin class $HubStatusStateCopyWith<$Res>  {
  factory $HubStatusStateCopyWith(HubStatusState value, $Res Function(HubStatusState) _then) = _$HubStatusStateCopyWithImpl;
@useResult
$Res call({
 Server? server, HAServerConnectionState connectionState, AuthState authState
});


$AuthStateCopyWith<$Res> get authState;

}
/// @nodoc
class _$HubStatusStateCopyWithImpl<$Res>
    implements $HubStatusStateCopyWith<$Res> {
  _$HubStatusStateCopyWithImpl(this._self, this._then);

  final HubStatusState _self;
  final $Res Function(HubStatusState) _then;

/// Create a copy of HubStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? server = freezed,Object? connectionState = null,Object? authState = null,}) {
  return _then(_self.copyWith(
server: freezed == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as Server?,connectionState: null == connectionState ? _self.connectionState : connectionState // ignore: cast_nullable_to_non_nullable
as HAServerConnectionState,authState: null == authState ? _self.authState : authState // ignore: cast_nullable_to_non_nullable
as AuthState,
  ));
}
/// Create a copy of HubStatusState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthStateCopyWith<$Res> get authState {
  
  return $AuthStateCopyWith<$Res>(_self.authState, (value) {
    return _then(_self.copyWith(authState: value));
  });
}
}


/// Adds pattern-matching-related methods to [HubStatusState].
extension HubStatusStatePatterns on HubStatusState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HubStatusState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HubStatusState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HubStatusState value)  $default,){
final _that = this;
switch (_that) {
case _HubStatusState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HubStatusState value)?  $default,){
final _that = this;
switch (_that) {
case _HubStatusState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Server? server,  HAServerConnectionState connectionState,  AuthState authState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HubStatusState() when $default != null:
return $default(_that.server,_that.connectionState,_that.authState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Server? server,  HAServerConnectionState connectionState,  AuthState authState)  $default,) {final _that = this;
switch (_that) {
case _HubStatusState():
return $default(_that.server,_that.connectionState,_that.authState);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Server? server,  HAServerConnectionState connectionState,  AuthState authState)?  $default,) {final _that = this;
switch (_that) {
case _HubStatusState() when $default != null:
return $default(_that.server,_that.connectionState,_that.authState);case _:
  return null;

}
}

}

/// @nodoc


class _HubStatusState implements HubStatusState {
  const _HubStatusState({required this.server, required this.connectionState, required this.authState});
  

@override final  Server? server;
@override final  HAServerConnectionState connectionState;
@override final  AuthState authState;

/// Create a copy of HubStatusState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HubStatusStateCopyWith<_HubStatusState> get copyWith => __$HubStatusStateCopyWithImpl<_HubStatusState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HubStatusState&&(identical(other.server, server) || other.server == server)&&(identical(other.connectionState, connectionState) || other.connectionState == connectionState)&&(identical(other.authState, authState) || other.authState == authState));
}


@override
int get hashCode => Object.hash(runtimeType,server,connectionState,authState);

@override
String toString() {
  return 'HubStatusState(server: $server, connectionState: $connectionState, authState: $authState)';
}


}

/// @nodoc
abstract mixin class _$HubStatusStateCopyWith<$Res> implements $HubStatusStateCopyWith<$Res> {
  factory _$HubStatusStateCopyWith(_HubStatusState value, $Res Function(_HubStatusState) _then) = __$HubStatusStateCopyWithImpl;
@override @useResult
$Res call({
 Server? server, HAServerConnectionState connectionState, AuthState authState
});


@override $AuthStateCopyWith<$Res> get authState;

}
/// @nodoc
class __$HubStatusStateCopyWithImpl<$Res>
    implements _$HubStatusStateCopyWith<$Res> {
  __$HubStatusStateCopyWithImpl(this._self, this._then);

  final _HubStatusState _self;
  final $Res Function(_HubStatusState) _then;

/// Create a copy of HubStatusState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? server = freezed,Object? connectionState = null,Object? authState = null,}) {
  return _then(_HubStatusState(
server: freezed == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as Server?,connectionState: null == connectionState ? _self.connectionState : connectionState // ignore: cast_nullable_to_non_nullable
as HAServerConnectionState,authState: null == authState ? _self.authState : authState // ignore: cast_nullable_to_non_nullable
as AuthState,
  ));
}

/// Create a copy of HubStatusState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthStateCopyWith<$Res> get authState {
  
  return $AuthStateCopyWith<$Res>(_self.authState, (value) {
    return _then(_self.copyWith(authState: value));
  });
}
}

// dart format on
