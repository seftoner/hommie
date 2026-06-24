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
mixin _$HubConnectionStatus {

 HubConnectionStatusKind get kind; String get label; String get description; Server? get server;
/// Create a copy of HubConnectionStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HubConnectionStatusCopyWith<HubConnectionStatus> get copyWith => _$HubConnectionStatusCopyWithImpl<HubConnectionStatus>(this as HubConnectionStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HubConnectionStatus&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.server, server) || other.server == server));
}


@override
int get hashCode => Object.hash(runtimeType,kind,label,description,server);

@override
String toString() {
  return 'HubConnectionStatus(kind: $kind, label: $label, description: $description, server: $server)';
}


}

/// @nodoc
abstract mixin class $HubConnectionStatusCopyWith<$Res>  {
  factory $HubConnectionStatusCopyWith(HubConnectionStatus value, $Res Function(HubConnectionStatus) _then) = _$HubConnectionStatusCopyWithImpl;
@useResult
$Res call({
 HubConnectionStatusKind kind, String label, String description, Server? server
});




}
/// @nodoc
class _$HubConnectionStatusCopyWithImpl<$Res>
    implements $HubConnectionStatusCopyWith<$Res> {
  _$HubConnectionStatusCopyWithImpl(this._self, this._then);

  final HubConnectionStatus _self;
  final $Res Function(HubConnectionStatus) _then;

/// Create a copy of HubConnectionStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? label = null,Object? description = null,Object? server = freezed,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as HubConnectionStatusKind,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,server: freezed == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as Server?,
  ));
}

}


/// Adds pattern-matching-related methods to [HubConnectionStatus].
extension HubConnectionStatusPatterns on HubConnectionStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HubConnectionStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HubConnectionStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HubConnectionStatus value)  $default,){
final _that = this;
switch (_that) {
case _HubConnectionStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HubConnectionStatus value)?  $default,){
final _that = this;
switch (_that) {
case _HubConnectionStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HubConnectionStatusKind kind,  String label,  String description,  Server? server)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HubConnectionStatus() when $default != null:
return $default(_that.kind,_that.label,_that.description,_that.server);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HubConnectionStatusKind kind,  String label,  String description,  Server? server)  $default,) {final _that = this;
switch (_that) {
case _HubConnectionStatus():
return $default(_that.kind,_that.label,_that.description,_that.server);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HubConnectionStatusKind kind,  String label,  String description,  Server? server)?  $default,) {final _that = this;
switch (_that) {
case _HubConnectionStatus() when $default != null:
return $default(_that.kind,_that.label,_that.description,_that.server);case _:
  return null;

}
}

}

/// @nodoc


class _HubConnectionStatus implements HubConnectionStatus {
  const _HubConnectionStatus({required this.kind, required this.label, required this.description, required this.server});


@override final  HubConnectionStatusKind kind;
@override final  String label;
@override final  String description;
@override final  Server? server;

/// Create a copy of HubConnectionStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HubConnectionStatusCopyWith<_HubConnectionStatus> get copyWith => __$HubConnectionStatusCopyWithImpl<_HubConnectionStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HubConnectionStatus&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.server, server) || other.server == server));
}


@override
int get hashCode => Object.hash(runtimeType,kind,label,description,server);

@override
String toString() {
  return 'HubConnectionStatus(kind: $kind, label: $label, description: $description, server: $server)';
}


}

/// @nodoc
abstract mixin class _$HubConnectionStatusCopyWith<$Res> implements $HubConnectionStatusCopyWith<$Res> {
  factory _$HubConnectionStatusCopyWith(_HubConnectionStatus value, $Res Function(_HubConnectionStatus) _then) = __$HubConnectionStatusCopyWithImpl;
@override @useResult
$Res call({
 HubConnectionStatusKind kind, String label, String description, Server? server
});




}
/// @nodoc
class __$HubConnectionStatusCopyWithImpl<$Res>
    implements _$HubConnectionStatusCopyWith<$Res> {
  __$HubConnectionStatusCopyWithImpl(this._self, this._then);

  final _HubConnectionStatus _self;
  final $Res Function(_HubConnectionStatus) _then;

/// Create a copy of HubConnectionStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? label = null,Object? description = null,Object? server = freezed,}) {
  return _then(_HubConnectionStatus(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as HubConnectionStatusKind,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,server: freezed == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as Server?,
  ));
}


}

/// @nodoc
mixin _$HubStatusState {

 HubConnectionStatus get connectionStatus; AuthState get authState; String get deviceName;
/// Create a copy of HubStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HubStatusStateCopyWith<HubStatusState> get copyWith => _$HubStatusStateCopyWithImpl<HubStatusState>(this as HubStatusState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HubStatusState&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&(identical(other.authState, authState) || other.authState == authState)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName));
}


@override
int get hashCode => Object.hash(runtimeType,connectionStatus,authState,deviceName);

@override
String toString() {
  return 'HubStatusState(connectionStatus: $connectionStatus, authState: $authState, deviceName: $deviceName)';
}


}

/// @nodoc
abstract mixin class $HubStatusStateCopyWith<$Res>  {
  factory $HubStatusStateCopyWith(HubStatusState value, $Res Function(HubStatusState) _then) = _$HubStatusStateCopyWithImpl;
@useResult
$Res call({
 HubConnectionStatus connectionStatus, AuthState authState, String deviceName
});


$HubConnectionStatusCopyWith<$Res> get connectionStatus;$AuthStateCopyWith<$Res> get authState;

}
/// @nodoc
class _$HubStatusStateCopyWithImpl<$Res>
    implements $HubStatusStateCopyWith<$Res> {
  _$HubStatusStateCopyWithImpl(this._self, this._then);

  final HubStatusState _self;
  final $Res Function(HubStatusState) _then;

/// Create a copy of HubStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? connectionStatus = null,Object? authState = null,Object? deviceName = null,}) {
  return _then(_self.copyWith(
connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as HubConnectionStatus,authState: null == authState ? _self.authState : authState // ignore: cast_nullable_to_non_nullable
as AuthState,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of HubStatusState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HubConnectionStatusCopyWith<$Res> get connectionStatus {

  return $HubConnectionStatusCopyWith<$Res>(_self.connectionStatus, (value) {
    return _then(_self.copyWith(connectionStatus: value));
  });
}/// Create a copy of HubStatusState
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HubConnectionStatus connectionStatus,  AuthState authState,  String deviceName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HubStatusState() when $default != null:
return $default(_that.connectionStatus,_that.authState,_that.deviceName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HubConnectionStatus connectionStatus,  AuthState authState,  String deviceName)  $default,) {final _that = this;
switch (_that) {
case _HubStatusState():
return $default(_that.connectionStatus,_that.authState,_that.deviceName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HubConnectionStatus connectionStatus,  AuthState authState,  String deviceName)?  $default,) {final _that = this;
switch (_that) {
case _HubStatusState() when $default != null:
return $default(_that.connectionStatus,_that.authState,_that.deviceName);case _:
  return null;

}
}

}

/// @nodoc


class _HubStatusState implements HubStatusState {
  const _HubStatusState({required this.connectionStatus, required this.authState, required this.deviceName});


@override final  HubConnectionStatus connectionStatus;
@override final  AuthState authState;
@override final  String deviceName;

/// Create a copy of HubStatusState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HubStatusStateCopyWith<_HubStatusState> get copyWith => __$HubStatusStateCopyWithImpl<_HubStatusState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HubStatusState&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&(identical(other.authState, authState) || other.authState == authState)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName));
}


@override
int get hashCode => Object.hash(runtimeType,connectionStatus,authState,deviceName);

@override
String toString() {
  return 'HubStatusState(connectionStatus: $connectionStatus, authState: $authState, deviceName: $deviceName)';
}


}

/// @nodoc
abstract mixin class _$HubStatusStateCopyWith<$Res> implements $HubStatusStateCopyWith<$Res> {
  factory _$HubStatusStateCopyWith(_HubStatusState value, $Res Function(_HubStatusState) _then) = __$HubStatusStateCopyWithImpl;
@override @useResult
$Res call({
 HubConnectionStatus connectionStatus, AuthState authState, String deviceName
});


@override $HubConnectionStatusCopyWith<$Res> get connectionStatus;@override $AuthStateCopyWith<$Res> get authState;

}
/// @nodoc
class __$HubStatusStateCopyWithImpl<$Res>
    implements _$HubStatusStateCopyWith<$Res> {
  __$HubStatusStateCopyWithImpl(this._self, this._then);

  final _HubStatusState _self;
  final $Res Function(_HubStatusState) _then;

/// Create a copy of HubStatusState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? connectionStatus = null,Object? authState = null,Object? deviceName = null,}) {
  return _then(_HubStatusState(
connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as HubConnectionStatus,authState: null == authState ? _self.authState : authState // ignore: cast_nullable_to_non_nullable
as AuthState,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of HubStatusState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HubConnectionStatusCopyWith<$Res> get connectionStatus {

  return $HubConnectionStatusCopyWith<$Res>(_self.connectionStatus, (value) {
    return _then(_self.copyWith(connectionStatus: value));
  });
}/// Create a copy of HubStatusState
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
