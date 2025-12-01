// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ha_server.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HaServer {

 String? get uuid; String get name; Uri get uri; HaVersion get version; Uri? get internalUrl; Uri? get externalUrl;
/// Create a copy of HaServer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HaServerCopyWith<HaServer> get copyWith => _$HaServerCopyWithImpl<HaServer>(this as HaServer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HaServer&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.name, name) || other.name == name)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.version, version) || other.version == version)&&(identical(other.internalUrl, internalUrl) || other.internalUrl == internalUrl)&&(identical(other.externalUrl, externalUrl) || other.externalUrl == externalUrl));
}


@override
int get hashCode => Object.hash(runtimeType,uuid,name,uri,version,internalUrl,externalUrl);

@override
String toString() {
  return 'HaServer(uuid: $uuid, name: $name, uri: $uri, version: $version, internalUrl: $internalUrl, externalUrl: $externalUrl)';
}


}

/// @nodoc
abstract mixin class $HaServerCopyWith<$Res>  {
  factory $HaServerCopyWith(HaServer value, $Res Function(HaServer) _then) = _$HaServerCopyWithImpl;
@useResult
$Res call({
 String? uuid, String name, Uri uri, HaVersion version, Uri? internalUrl, Uri? externalUrl
});


$HaVersionCopyWith<$Res> get version;

}
/// @nodoc
class _$HaServerCopyWithImpl<$Res>
    implements $HaServerCopyWith<$Res> {
  _$HaServerCopyWithImpl(this._self, this._then);

  final HaServer _self;
  final $Res Function(HaServer) _then;

/// Create a copy of HaServer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uuid = freezed,Object? name = null,Object? uri = null,Object? version = null,Object? internalUrl = freezed,Object? externalUrl = freezed,}) {
  return _then(_self.copyWith(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as Uri,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as HaVersion,internalUrl: freezed == internalUrl ? _self.internalUrl : internalUrl // ignore: cast_nullable_to_non_nullable
as Uri?,externalUrl: freezed == externalUrl ? _self.externalUrl : externalUrl // ignore: cast_nullable_to_non_nullable
as Uri?,
  ));
}
/// Create a copy of HaServer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HaVersionCopyWith<$Res> get version {
  
  return $HaVersionCopyWith<$Res>(_self.version, (value) {
    return _then(_self.copyWith(version: value));
  });
}
}


/// Adds pattern-matching-related methods to [HaServer].
extension HaServerPatterns on HaServer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HaServer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HaServer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HaServer value)  $default,){
final _that = this;
switch (_that) {
case _HaServer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HaServer value)?  $default,){
final _that = this;
switch (_that) {
case _HaServer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? uuid,  String name,  Uri uri,  HaVersion version,  Uri? internalUrl,  Uri? externalUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HaServer() when $default != null:
return $default(_that.uuid,_that.name,_that.uri,_that.version,_that.internalUrl,_that.externalUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? uuid,  String name,  Uri uri,  HaVersion version,  Uri? internalUrl,  Uri? externalUrl)  $default,) {final _that = this;
switch (_that) {
case _HaServer():
return $default(_that.uuid,_that.name,_that.uri,_that.version,_that.internalUrl,_that.externalUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? uuid,  String name,  Uri uri,  HaVersion version,  Uri? internalUrl,  Uri? externalUrl)?  $default,) {final _that = this;
switch (_that) {
case _HaServer() when $default != null:
return $default(_that.uuid,_that.name,_that.uri,_that.version,_that.internalUrl,_that.externalUrl);case _:
  return null;

}
}

}

/// @nodoc


class _HaServer implements HaServer {
   _HaServer({this.uuid, required this.name, required this.uri, required this.version, this.internalUrl, this.externalUrl});
  

@override final  String? uuid;
@override final  String name;
@override final  Uri uri;
@override final  HaVersion version;
@override final  Uri? internalUrl;
@override final  Uri? externalUrl;

/// Create a copy of HaServer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HaServerCopyWith<_HaServer> get copyWith => __$HaServerCopyWithImpl<_HaServer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HaServer&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.name, name) || other.name == name)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.version, version) || other.version == version)&&(identical(other.internalUrl, internalUrl) || other.internalUrl == internalUrl)&&(identical(other.externalUrl, externalUrl) || other.externalUrl == externalUrl));
}


@override
int get hashCode => Object.hash(runtimeType,uuid,name,uri,version,internalUrl,externalUrl);

@override
String toString() {
  return 'HaServer(uuid: $uuid, name: $name, uri: $uri, version: $version, internalUrl: $internalUrl, externalUrl: $externalUrl)';
}


}

/// @nodoc
abstract mixin class _$HaServerCopyWith<$Res> implements $HaServerCopyWith<$Res> {
  factory _$HaServerCopyWith(_HaServer value, $Res Function(_HaServer) _then) = __$HaServerCopyWithImpl;
@override @useResult
$Res call({
 String? uuid, String name, Uri uri, HaVersion version, Uri? internalUrl, Uri? externalUrl
});


@override $HaVersionCopyWith<$Res> get version;

}
/// @nodoc
class __$HaServerCopyWithImpl<$Res>
    implements _$HaServerCopyWith<$Res> {
  __$HaServerCopyWithImpl(this._self, this._then);

  final _HaServer _self;
  final $Res Function(_HaServer) _then;

/// Create a copy of HaServer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uuid = freezed,Object? name = null,Object? uri = null,Object? version = null,Object? internalUrl = freezed,Object? externalUrl = freezed,}) {
  return _then(_HaServer(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as Uri,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as HaVersion,internalUrl: freezed == internalUrl ? _self.internalUrl : internalUrl // ignore: cast_nullable_to_non_nullable
as Uri?,externalUrl: freezed == externalUrl ? _self.externalUrl : externalUrl // ignore: cast_nullable_to_non_nullable
as Uri?,
  ));
}

/// Create a copy of HaServer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HaVersionCopyWith<$Res> get version {
  
  return $HaVersionCopyWith<$Res>(_self.version, (value) {
    return _then(_self.copyWith(version: value));
  });
}
}

// dart format on
