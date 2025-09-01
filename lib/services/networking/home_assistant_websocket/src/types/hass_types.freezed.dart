// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hass_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
HassError _$HassErrorFromJson(
  Map<String, dynamic> json
) {
    return _Error.fromJson(
      json
    );
}

/// @nodoc
mixin _$HassError {

 String get code; String get message;
/// Create a copy of HassError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HassErrorCopyWith<HassError> get copyWith => _$HassErrorCopyWithImpl<HassError>(this as HassError, _$identity);

  /// Serializes this HassError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HassError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'HassError(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $HassErrorCopyWith<$Res>  {
  factory $HassErrorCopyWith(HassError value, $Res Function(HassError) _then) = _$HassErrorCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$HassErrorCopyWithImpl<$Res>
    implements $HassErrorCopyWith<$Res> {
  _$HassErrorCopyWithImpl(this._self, this._then);

  final HassError _self;
  final $Res Function(HassError) _then;

/// Create a copy of HassError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HassError].
extension HassErrorPatterns on HassError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Error value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Error() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Error value)  $default,){
final _that = this;
switch (_that) {
case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Error value)?  $default,){
final _that = this;
switch (_that) {
case _Error() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Error() when $default != null:
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String message)  $default,) {final _that = this;
switch (_that) {
case _Error():
return $default(_that.code,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String message)?  $default,) {final _that = this;
switch (_that) {
case _Error() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Error implements HassError {
  const _Error({required this.code, required this.message});
  factory _Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

@override final  String code;
@override final  String message;

/// Create a copy of HassError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'HassError(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $HassErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of HassError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_Error(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AreaEntity {

 String get area_id; String get name; String? get picture; List<String>? get aliases;
/// Create a copy of AreaEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaEntityCopyWith<AreaEntity> get copyWith => _$AreaEntityCopyWithImpl<AreaEntity>(this as AreaEntity, _$identity);

  /// Serializes this AreaEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreaEntity&&(identical(other.area_id, area_id) || other.area_id == area_id)&&(identical(other.name, name) || other.name == name)&&(identical(other.picture, picture) || other.picture == picture)&&const DeepCollectionEquality().equals(other.aliases, aliases));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,area_id,name,picture,const DeepCollectionEquality().hash(aliases));

@override
String toString() {
  return 'AreaEntity(area_id: $area_id, name: $name, picture: $picture, aliases: $aliases)';
}


}

/// @nodoc
abstract mixin class $AreaEntityCopyWith<$Res>  {
  factory $AreaEntityCopyWith(AreaEntity value, $Res Function(AreaEntity) _then) = _$AreaEntityCopyWithImpl;
@useResult
$Res call({
 String area_id, String name, String? picture, List<String>? aliases
});




}
/// @nodoc
class _$AreaEntityCopyWithImpl<$Res>
    implements $AreaEntityCopyWith<$Res> {
  _$AreaEntityCopyWithImpl(this._self, this._then);

  final AreaEntity _self;
  final $Res Function(AreaEntity) _then;

/// Create a copy of AreaEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? area_id = null,Object? name = null,Object? picture = freezed,Object? aliases = freezed,}) {
  return _then(_self.copyWith(
area_id: null == area_id ? _self.area_id : area_id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,picture: freezed == picture ? _self.picture : picture // ignore: cast_nullable_to_non_nullable
as String?,aliases: freezed == aliases ? _self.aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AreaEntity].
extension AreaEntityPatterns on AreaEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AreaEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AreaEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AreaEntity value)  $default,){
final _that = this;
switch (_that) {
case _AreaEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AreaEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AreaEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String area_id,  String name,  String? picture,  List<String>? aliases)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AreaEntity() when $default != null:
return $default(_that.area_id,_that.name,_that.picture,_that.aliases);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String area_id,  String name,  String? picture,  List<String>? aliases)  $default,) {final _that = this;
switch (_that) {
case _AreaEntity():
return $default(_that.area_id,_that.name,_that.picture,_that.aliases);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String area_id,  String name,  String? picture,  List<String>? aliases)?  $default,) {final _that = this;
switch (_that) {
case _AreaEntity() when $default != null:
return $default(_that.area_id,_that.name,_that.picture,_that.aliases);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AreaEntity implements AreaEntity {
  const _AreaEntity({required this.area_id, required this.name, this.picture, final  List<String>? aliases}): _aliases = aliases;
  factory _AreaEntity.fromJson(Map<String, dynamic> json) => _$AreaEntityFromJson(json);

@override final  String area_id;
@override final  String name;
@override final  String? picture;
 final  List<String>? _aliases;
@override List<String>? get aliases {
  final value = _aliases;
  if (value == null) return null;
  if (_aliases is EqualUnmodifiableListView) return _aliases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of AreaEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AreaEntityCopyWith<_AreaEntity> get copyWith => __$AreaEntityCopyWithImpl<_AreaEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AreaEntity&&(identical(other.area_id, area_id) || other.area_id == area_id)&&(identical(other.name, name) || other.name == name)&&(identical(other.picture, picture) || other.picture == picture)&&const DeepCollectionEquality().equals(other._aliases, _aliases));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,area_id,name,picture,const DeepCollectionEquality().hash(_aliases));

@override
String toString() {
  return 'AreaEntity(area_id: $area_id, name: $name, picture: $picture, aliases: $aliases)';
}


}

/// @nodoc
abstract mixin class _$AreaEntityCopyWith<$Res> implements $AreaEntityCopyWith<$Res> {
  factory _$AreaEntityCopyWith(_AreaEntity value, $Res Function(_AreaEntity) _then) = __$AreaEntityCopyWithImpl;
@override @useResult
$Res call({
 String area_id, String name, String? picture, List<String>? aliases
});




}
/// @nodoc
class __$AreaEntityCopyWithImpl<$Res>
    implements _$AreaEntityCopyWith<$Res> {
  __$AreaEntityCopyWithImpl(this._self, this._then);

  final _AreaEntity _self;
  final $Res Function(_AreaEntity) _then;

/// Create a copy of AreaEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? area_id = null,Object? name = null,Object? picture = freezed,Object? aliases = freezed,}) {
  return _then(_AreaEntity(
area_id: null == area_id ? _self.area_id : area_id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,picture: freezed == picture ? _self.picture : picture // ignore: cast_nullable_to_non_nullable
as String?,aliases: freezed == aliases ? _self._aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$AreaEntityList {

 List<AreaEntity> get areasList;
/// Create a copy of AreaEntityList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaEntityListCopyWith<AreaEntityList> get copyWith => _$AreaEntityListCopyWithImpl<AreaEntityList>(this as AreaEntityList, _$identity);

  /// Serializes this AreaEntityList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreaEntityList&&const DeepCollectionEquality().equals(other.areasList, areasList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(areasList));

@override
String toString() {
  return 'AreaEntityList(areasList: $areasList)';
}


}

/// @nodoc
abstract mixin class $AreaEntityListCopyWith<$Res>  {
  factory $AreaEntityListCopyWith(AreaEntityList value, $Res Function(AreaEntityList) _then) = _$AreaEntityListCopyWithImpl;
@useResult
$Res call({
 List<AreaEntity> areasList
});




}
/// @nodoc
class _$AreaEntityListCopyWithImpl<$Res>
    implements $AreaEntityListCopyWith<$Res> {
  _$AreaEntityListCopyWithImpl(this._self, this._then);

  final AreaEntityList _self;
  final $Res Function(AreaEntityList) _then;

/// Create a copy of AreaEntityList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? areasList = null,}) {
  return _then(_self.copyWith(
areasList: null == areasList ? _self.areasList : areasList // ignore: cast_nullable_to_non_nullable
as List<AreaEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [AreaEntityList].
extension AreaEntityListPatterns on AreaEntityList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AreaEntityList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AreaEntityList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AreaEntityList value)  $default,){
final _that = this;
switch (_that) {
case _AreaEntityList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AreaEntityList value)?  $default,){
final _that = this;
switch (_that) {
case _AreaEntityList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AreaEntity> areasList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AreaEntityList() when $default != null:
return $default(_that.areasList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AreaEntity> areasList)  $default,) {final _that = this;
switch (_that) {
case _AreaEntityList():
return $default(_that.areasList);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AreaEntity> areasList)?  $default,) {final _that = this;
switch (_that) {
case _AreaEntityList() when $default != null:
return $default(_that.areasList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AreaEntityList implements AreaEntityList {
  const _AreaEntityList(final  List<AreaEntity> areasList): _areasList = areasList;
  factory _AreaEntityList.fromJson(Map<String, dynamic> json) => _$AreaEntityListFromJson(json);

 final  List<AreaEntity> _areasList;
@override List<AreaEntity> get areasList {
  if (_areasList is EqualUnmodifiableListView) return _areasList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areasList);
}


/// Create a copy of AreaEntityList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AreaEntityListCopyWith<_AreaEntityList> get copyWith => __$AreaEntityListCopyWithImpl<_AreaEntityList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaEntityListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AreaEntityList&&const DeepCollectionEquality().equals(other._areasList, _areasList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_areasList));

@override
String toString() {
  return 'AreaEntityList(areasList: $areasList)';
}


}

/// @nodoc
abstract mixin class _$AreaEntityListCopyWith<$Res> implements $AreaEntityListCopyWith<$Res> {
  factory _$AreaEntityListCopyWith(_AreaEntityList value, $Res Function(_AreaEntityList) _then) = __$AreaEntityListCopyWithImpl;
@override @useResult
$Res call({
 List<AreaEntity> areasList
});




}
/// @nodoc
class __$AreaEntityListCopyWithImpl<$Res>
    implements _$AreaEntityListCopyWith<$Res> {
  __$AreaEntityListCopyWithImpl(this._self, this._then);

  final _AreaEntityList _self;
  final $Res Function(_AreaEntityList) _then;

/// Create a copy of AreaEntityList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? areasList = null,}) {
  return _then(_AreaEntityList(
null == areasList ? _self._areasList : areasList // ignore: cast_nullable_to_non_nullable
as List<AreaEntity>,
  ));
}


}


/// @nodoc
mixin _$HassUser {

 String get id; bool get is_admin; bool get is_owner; String get name;
/// Create a copy of HassUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HassUserCopyWith<HassUser> get copyWith => _$HassUserCopyWithImpl<HassUser>(this as HassUser, _$identity);

  /// Serializes this HassUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HassUser&&(identical(other.id, id) || other.id == id)&&(identical(other.is_admin, is_admin) || other.is_admin == is_admin)&&(identical(other.is_owner, is_owner) || other.is_owner == is_owner)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,is_admin,is_owner,name);

@override
String toString() {
  return 'HassUser(id: $id, is_admin: $is_admin, is_owner: $is_owner, name: $name)';
}


}

/// @nodoc
abstract mixin class $HassUserCopyWith<$Res>  {
  factory $HassUserCopyWith(HassUser value, $Res Function(HassUser) _then) = _$HassUserCopyWithImpl;
@useResult
$Res call({
 String id, bool is_admin, bool is_owner, String name
});




}
/// @nodoc
class _$HassUserCopyWithImpl<$Res>
    implements $HassUserCopyWith<$Res> {
  _$HassUserCopyWithImpl(this._self, this._then);

  final HassUser _self;
  final $Res Function(HassUser) _then;

/// Create a copy of HassUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? is_admin = null,Object? is_owner = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,is_admin: null == is_admin ? _self.is_admin : is_admin // ignore: cast_nullable_to_non_nullable
as bool,is_owner: null == is_owner ? _self.is_owner : is_owner // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HassUser].
extension HassUserPatterns on HassUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HassUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HassUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HassUser value)  $default,){
final _that = this;
switch (_that) {
case _HassUser():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HassUser value)?  $default,){
final _that = this;
switch (_that) {
case _HassUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  bool is_admin,  bool is_owner,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HassUser() when $default != null:
return $default(_that.id,_that.is_admin,_that.is_owner,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  bool is_admin,  bool is_owner,  String name)  $default,) {final _that = this;
switch (_that) {
case _HassUser():
return $default(_that.id,_that.is_admin,_that.is_owner,_that.name);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  bool is_admin,  bool is_owner,  String name)?  $default,) {final _that = this;
switch (_that) {
case _HassUser() when $default != null:
return $default(_that.id,_that.is_admin,_that.is_owner,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HassUser implements HassUser {
  const _HassUser({required this.id, required this.is_admin, required this.is_owner, required this.name});
  factory _HassUser.fromJson(Map<String, dynamic> json) => _$HassUserFromJson(json);

@override final  String id;
@override final  bool is_admin;
@override final  bool is_owner;
@override final  String name;

/// Create a copy of HassUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HassUserCopyWith<_HassUser> get copyWith => __$HassUserCopyWithImpl<_HassUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HassUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HassUser&&(identical(other.id, id) || other.id == id)&&(identical(other.is_admin, is_admin) || other.is_admin == is_admin)&&(identical(other.is_owner, is_owner) || other.is_owner == is_owner)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,is_admin,is_owner,name);

@override
String toString() {
  return 'HassUser(id: $id, is_admin: $is_admin, is_owner: $is_owner, name: $name)';
}


}

/// @nodoc
abstract mixin class _$HassUserCopyWith<$Res> implements $HassUserCopyWith<$Res> {
  factory _$HassUserCopyWith(_HassUser value, $Res Function(_HassUser) _then) = __$HassUserCopyWithImpl;
@override @useResult
$Res call({
 String id, bool is_admin, bool is_owner, String name
});




}
/// @nodoc
class __$HassUserCopyWithImpl<$Res>
    implements _$HassUserCopyWith<$Res> {
  __$HassUserCopyWithImpl(this._self, this._then);

  final _HassUser _self;
  final $Res Function(_HassUser) _then;

/// Create a copy of HassUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? is_admin = null,Object? is_owner = null,Object? name = null,}) {
  return _then(_HassUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,is_admin: null == is_admin ? _self.is_admin : is_admin // ignore: cast_nullable_to_non_nullable
as bool,is_owner: null == is_owner ? _self.is_owner : is_owner // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HassConfig {

 double get latitude; double get longitude; double get elevation; double get radius; UnitSystem get unit_system; String get location_name; String get time_zone; List<String> get components; String get config_dir; List<String> get allowlist_external_dirs; List<String> get allowlist_external_urls; String get version; String get config_source; bool get recovery_mode; bool get safe_mode;// @StringEnum('NOT_RUNNING', 'STARTING', 'RUNNING', 'STOPPING', 'FINAL_WRITE')
 State get state; String? get external_url; String? get internal_url; List<String>? get whitelist_external_dirs; String get currency; String? get country; String get language;
/// Create a copy of HassConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HassConfigCopyWith<HassConfig> get copyWith => _$HassConfigCopyWithImpl<HassConfig>(this as HassConfig, _$identity);

  /// Serializes this HassConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HassConfig&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.elevation, elevation) || other.elevation == elevation)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.unit_system, unit_system) || other.unit_system == unit_system)&&(identical(other.location_name, location_name) || other.location_name == location_name)&&(identical(other.time_zone, time_zone) || other.time_zone == time_zone)&&const DeepCollectionEquality().equals(other.components, components)&&(identical(other.config_dir, config_dir) || other.config_dir == config_dir)&&const DeepCollectionEquality().equals(other.allowlist_external_dirs, allowlist_external_dirs)&&const DeepCollectionEquality().equals(other.allowlist_external_urls, allowlist_external_urls)&&(identical(other.version, version) || other.version == version)&&(identical(other.config_source, config_source) || other.config_source == config_source)&&(identical(other.recovery_mode, recovery_mode) || other.recovery_mode == recovery_mode)&&(identical(other.safe_mode, safe_mode) || other.safe_mode == safe_mode)&&(identical(other.state, state) || other.state == state)&&(identical(other.external_url, external_url) || other.external_url == external_url)&&(identical(other.internal_url, internal_url) || other.internal_url == internal_url)&&const DeepCollectionEquality().equals(other.whitelist_external_dirs, whitelist_external_dirs)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.country, country) || other.country == country)&&(identical(other.language, language) || other.language == language));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,latitude,longitude,elevation,radius,unit_system,location_name,time_zone,const DeepCollectionEquality().hash(components),config_dir,const DeepCollectionEquality().hash(allowlist_external_dirs),const DeepCollectionEquality().hash(allowlist_external_urls),version,config_source,recovery_mode,safe_mode,state,external_url,internal_url,const DeepCollectionEquality().hash(whitelist_external_dirs),currency,country,language]);

@override
String toString() {
  return 'HassConfig(latitude: $latitude, longitude: $longitude, elevation: $elevation, radius: $radius, unit_system: $unit_system, location_name: $location_name, time_zone: $time_zone, components: $components, config_dir: $config_dir, allowlist_external_dirs: $allowlist_external_dirs, allowlist_external_urls: $allowlist_external_urls, version: $version, config_source: $config_source, recovery_mode: $recovery_mode, safe_mode: $safe_mode, state: $state, external_url: $external_url, internal_url: $internal_url, whitelist_external_dirs: $whitelist_external_dirs, currency: $currency, country: $country, language: $language)';
}


}

/// @nodoc
abstract mixin class $HassConfigCopyWith<$Res>  {
  factory $HassConfigCopyWith(HassConfig value, $Res Function(HassConfig) _then) = _$HassConfigCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, double elevation, double radius, UnitSystem unit_system, String location_name, String time_zone, List<String> components, String config_dir, List<String> allowlist_external_dirs, List<String> allowlist_external_urls, String version, String config_source, bool recovery_mode, bool safe_mode, State state, String? external_url, String? internal_url, List<String>? whitelist_external_dirs, String currency, String? country, String language
});


$UnitSystemCopyWith<$Res> get unit_system;

}
/// @nodoc
class _$HassConfigCopyWithImpl<$Res>
    implements $HassConfigCopyWith<$Res> {
  _$HassConfigCopyWithImpl(this._self, this._then);

  final HassConfig _self;
  final $Res Function(HassConfig) _then;

/// Create a copy of HassConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? elevation = null,Object? radius = null,Object? unit_system = null,Object? location_name = null,Object? time_zone = null,Object? components = null,Object? config_dir = null,Object? allowlist_external_dirs = null,Object? allowlist_external_urls = null,Object? version = null,Object? config_source = null,Object? recovery_mode = null,Object? safe_mode = null,Object? state = null,Object? external_url = freezed,Object? internal_url = freezed,Object? whitelist_external_dirs = freezed,Object? currency = null,Object? country = freezed,Object? language = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,elevation: null == elevation ? _self.elevation : elevation // ignore: cast_nullable_to_non_nullable
as double,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,unit_system: null == unit_system ? _self.unit_system : unit_system // ignore: cast_nullable_to_non_nullable
as UnitSystem,location_name: null == location_name ? _self.location_name : location_name // ignore: cast_nullable_to_non_nullable
as String,time_zone: null == time_zone ? _self.time_zone : time_zone // ignore: cast_nullable_to_non_nullable
as String,components: null == components ? _self.components : components // ignore: cast_nullable_to_non_nullable
as List<String>,config_dir: null == config_dir ? _self.config_dir : config_dir // ignore: cast_nullable_to_non_nullable
as String,allowlist_external_dirs: null == allowlist_external_dirs ? _self.allowlist_external_dirs : allowlist_external_dirs // ignore: cast_nullable_to_non_nullable
as List<String>,allowlist_external_urls: null == allowlist_external_urls ? _self.allowlist_external_urls : allowlist_external_urls // ignore: cast_nullable_to_non_nullable
as List<String>,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,config_source: null == config_source ? _self.config_source : config_source // ignore: cast_nullable_to_non_nullable
as String,recovery_mode: null == recovery_mode ? _self.recovery_mode : recovery_mode // ignore: cast_nullable_to_non_nullable
as bool,safe_mode: null == safe_mode ? _self.safe_mode : safe_mode // ignore: cast_nullable_to_non_nullable
as bool,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as State,external_url: freezed == external_url ? _self.external_url : external_url // ignore: cast_nullable_to_non_nullable
as String?,internal_url: freezed == internal_url ? _self.internal_url : internal_url // ignore: cast_nullable_to_non_nullable
as String?,whitelist_external_dirs: freezed == whitelist_external_dirs ? _self.whitelist_external_dirs : whitelist_external_dirs // ignore: cast_nullable_to_non_nullable
as List<String>?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of HassConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitSystemCopyWith<$Res> get unit_system {
  
  return $UnitSystemCopyWith<$Res>(_self.unit_system, (value) {
    return _then(_self.copyWith(unit_system: value));
  });
}
}


/// Adds pattern-matching-related methods to [HassConfig].
extension HassConfigPatterns on HassConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HassConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HassConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HassConfig value)  $default,){
final _that = this;
switch (_that) {
case _HassConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HassConfig value)?  $default,){
final _that = this;
switch (_that) {
case _HassConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double elevation,  double radius,  UnitSystem unit_system,  String location_name,  String time_zone,  List<String> components,  String config_dir,  List<String> allowlist_external_dirs,  List<String> allowlist_external_urls,  String version,  String config_source,  bool recovery_mode,  bool safe_mode,  State state,  String? external_url,  String? internal_url,  List<String>? whitelist_external_dirs,  String currency,  String? country,  String language)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HassConfig() when $default != null:
return $default(_that.latitude,_that.longitude,_that.elevation,_that.radius,_that.unit_system,_that.location_name,_that.time_zone,_that.components,_that.config_dir,_that.allowlist_external_dirs,_that.allowlist_external_urls,_that.version,_that.config_source,_that.recovery_mode,_that.safe_mode,_that.state,_that.external_url,_that.internal_url,_that.whitelist_external_dirs,_that.currency,_that.country,_that.language);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double elevation,  double radius,  UnitSystem unit_system,  String location_name,  String time_zone,  List<String> components,  String config_dir,  List<String> allowlist_external_dirs,  List<String> allowlist_external_urls,  String version,  String config_source,  bool recovery_mode,  bool safe_mode,  State state,  String? external_url,  String? internal_url,  List<String>? whitelist_external_dirs,  String currency,  String? country,  String language)  $default,) {final _that = this;
switch (_that) {
case _HassConfig():
return $default(_that.latitude,_that.longitude,_that.elevation,_that.radius,_that.unit_system,_that.location_name,_that.time_zone,_that.components,_that.config_dir,_that.allowlist_external_dirs,_that.allowlist_external_urls,_that.version,_that.config_source,_that.recovery_mode,_that.safe_mode,_that.state,_that.external_url,_that.internal_url,_that.whitelist_external_dirs,_that.currency,_that.country,_that.language);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  double elevation,  double radius,  UnitSystem unit_system,  String location_name,  String time_zone,  List<String> components,  String config_dir,  List<String> allowlist_external_dirs,  List<String> allowlist_external_urls,  String version,  String config_source,  bool recovery_mode,  bool safe_mode,  State state,  String? external_url,  String? internal_url,  List<String>? whitelist_external_dirs,  String currency,  String? country,  String language)?  $default,) {final _that = this;
switch (_that) {
case _HassConfig() when $default != null:
return $default(_that.latitude,_that.longitude,_that.elevation,_that.radius,_that.unit_system,_that.location_name,_that.time_zone,_that.components,_that.config_dir,_that.allowlist_external_dirs,_that.allowlist_external_urls,_that.version,_that.config_source,_that.recovery_mode,_that.safe_mode,_that.state,_that.external_url,_that.internal_url,_that.whitelist_external_dirs,_that.currency,_that.country,_that.language);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HassConfig implements HassConfig {
  const _HassConfig({required this.latitude, required this.longitude, required this.elevation, required this.radius, required this.unit_system, required this.location_name, required this.time_zone, required final  List<String> components, required this.config_dir, required final  List<String> allowlist_external_dirs, required final  List<String> allowlist_external_urls, required this.version, required this.config_source, required this.recovery_mode, required this.safe_mode, required this.state, this.external_url, this.internal_url, final  List<String>? whitelist_external_dirs, required this.currency, this.country, required this.language}): _components = components,_allowlist_external_dirs = allowlist_external_dirs,_allowlist_external_urls = allowlist_external_urls,_whitelist_external_dirs = whitelist_external_dirs;
  factory _HassConfig.fromJson(Map<String, dynamic> json) => _$HassConfigFromJson(json);

@override final  double latitude;
@override final  double longitude;
@override final  double elevation;
@override final  double radius;
@override final  UnitSystem unit_system;
@override final  String location_name;
@override final  String time_zone;
 final  List<String> _components;
@override List<String> get components {
  if (_components is EqualUnmodifiableListView) return _components;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_components);
}

@override final  String config_dir;
 final  List<String> _allowlist_external_dirs;
@override List<String> get allowlist_external_dirs {
  if (_allowlist_external_dirs is EqualUnmodifiableListView) return _allowlist_external_dirs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowlist_external_dirs);
}

 final  List<String> _allowlist_external_urls;
@override List<String> get allowlist_external_urls {
  if (_allowlist_external_urls is EqualUnmodifiableListView) return _allowlist_external_urls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowlist_external_urls);
}

@override final  String version;
@override final  String config_source;
@override final  bool recovery_mode;
@override final  bool safe_mode;
// @StringEnum('NOT_RUNNING', 'STARTING', 'RUNNING', 'STOPPING', 'FINAL_WRITE')
@override final  State state;
@override final  String? external_url;
@override final  String? internal_url;
 final  List<String>? _whitelist_external_dirs;
@override List<String>? get whitelist_external_dirs {
  final value = _whitelist_external_dirs;
  if (value == null) return null;
  if (_whitelist_external_dirs is EqualUnmodifiableListView) return _whitelist_external_dirs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String currency;
@override final  String? country;
@override final  String language;

/// Create a copy of HassConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HassConfigCopyWith<_HassConfig> get copyWith => __$HassConfigCopyWithImpl<_HassConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HassConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HassConfig&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.elevation, elevation) || other.elevation == elevation)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.unit_system, unit_system) || other.unit_system == unit_system)&&(identical(other.location_name, location_name) || other.location_name == location_name)&&(identical(other.time_zone, time_zone) || other.time_zone == time_zone)&&const DeepCollectionEquality().equals(other._components, _components)&&(identical(other.config_dir, config_dir) || other.config_dir == config_dir)&&const DeepCollectionEquality().equals(other._allowlist_external_dirs, _allowlist_external_dirs)&&const DeepCollectionEquality().equals(other._allowlist_external_urls, _allowlist_external_urls)&&(identical(other.version, version) || other.version == version)&&(identical(other.config_source, config_source) || other.config_source == config_source)&&(identical(other.recovery_mode, recovery_mode) || other.recovery_mode == recovery_mode)&&(identical(other.safe_mode, safe_mode) || other.safe_mode == safe_mode)&&(identical(other.state, state) || other.state == state)&&(identical(other.external_url, external_url) || other.external_url == external_url)&&(identical(other.internal_url, internal_url) || other.internal_url == internal_url)&&const DeepCollectionEquality().equals(other._whitelist_external_dirs, _whitelist_external_dirs)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.country, country) || other.country == country)&&(identical(other.language, language) || other.language == language));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,latitude,longitude,elevation,radius,unit_system,location_name,time_zone,const DeepCollectionEquality().hash(_components),config_dir,const DeepCollectionEquality().hash(_allowlist_external_dirs),const DeepCollectionEquality().hash(_allowlist_external_urls),version,config_source,recovery_mode,safe_mode,state,external_url,internal_url,const DeepCollectionEquality().hash(_whitelist_external_dirs),currency,country,language]);

@override
String toString() {
  return 'HassConfig(latitude: $latitude, longitude: $longitude, elevation: $elevation, radius: $radius, unit_system: $unit_system, location_name: $location_name, time_zone: $time_zone, components: $components, config_dir: $config_dir, allowlist_external_dirs: $allowlist_external_dirs, allowlist_external_urls: $allowlist_external_urls, version: $version, config_source: $config_source, recovery_mode: $recovery_mode, safe_mode: $safe_mode, state: $state, external_url: $external_url, internal_url: $internal_url, whitelist_external_dirs: $whitelist_external_dirs, currency: $currency, country: $country, language: $language)';
}


}

/// @nodoc
abstract mixin class _$HassConfigCopyWith<$Res> implements $HassConfigCopyWith<$Res> {
  factory _$HassConfigCopyWith(_HassConfig value, $Res Function(_HassConfig) _then) = __$HassConfigCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, double elevation, double radius, UnitSystem unit_system, String location_name, String time_zone, List<String> components, String config_dir, List<String> allowlist_external_dirs, List<String> allowlist_external_urls, String version, String config_source, bool recovery_mode, bool safe_mode, State state, String? external_url, String? internal_url, List<String>? whitelist_external_dirs, String currency, String? country, String language
});


@override $UnitSystemCopyWith<$Res> get unit_system;

}
/// @nodoc
class __$HassConfigCopyWithImpl<$Res>
    implements _$HassConfigCopyWith<$Res> {
  __$HassConfigCopyWithImpl(this._self, this._then);

  final _HassConfig _self;
  final $Res Function(_HassConfig) _then;

/// Create a copy of HassConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? elevation = null,Object? radius = null,Object? unit_system = null,Object? location_name = null,Object? time_zone = null,Object? components = null,Object? config_dir = null,Object? allowlist_external_dirs = null,Object? allowlist_external_urls = null,Object? version = null,Object? config_source = null,Object? recovery_mode = null,Object? safe_mode = null,Object? state = null,Object? external_url = freezed,Object? internal_url = freezed,Object? whitelist_external_dirs = freezed,Object? currency = null,Object? country = freezed,Object? language = null,}) {
  return _then(_HassConfig(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,elevation: null == elevation ? _self.elevation : elevation // ignore: cast_nullable_to_non_nullable
as double,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,unit_system: null == unit_system ? _self.unit_system : unit_system // ignore: cast_nullable_to_non_nullable
as UnitSystem,location_name: null == location_name ? _self.location_name : location_name // ignore: cast_nullable_to_non_nullable
as String,time_zone: null == time_zone ? _self.time_zone : time_zone // ignore: cast_nullable_to_non_nullable
as String,components: null == components ? _self._components : components // ignore: cast_nullable_to_non_nullable
as List<String>,config_dir: null == config_dir ? _self.config_dir : config_dir // ignore: cast_nullable_to_non_nullable
as String,allowlist_external_dirs: null == allowlist_external_dirs ? _self._allowlist_external_dirs : allowlist_external_dirs // ignore: cast_nullable_to_non_nullable
as List<String>,allowlist_external_urls: null == allowlist_external_urls ? _self._allowlist_external_urls : allowlist_external_urls // ignore: cast_nullable_to_non_nullable
as List<String>,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,config_source: null == config_source ? _self.config_source : config_source // ignore: cast_nullable_to_non_nullable
as String,recovery_mode: null == recovery_mode ? _self.recovery_mode : recovery_mode // ignore: cast_nullable_to_non_nullable
as bool,safe_mode: null == safe_mode ? _self.safe_mode : safe_mode // ignore: cast_nullable_to_non_nullable
as bool,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as State,external_url: freezed == external_url ? _self.external_url : external_url // ignore: cast_nullable_to_non_nullable
as String?,internal_url: freezed == internal_url ? _self.internal_url : internal_url // ignore: cast_nullable_to_non_nullable
as String?,whitelist_external_dirs: freezed == whitelist_external_dirs ? _self._whitelist_external_dirs : whitelist_external_dirs // ignore: cast_nullable_to_non_nullable
as List<String>?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of HassConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitSystemCopyWith<$Res> get unit_system {
  
  return $UnitSystemCopyWith<$Res>(_self.unit_system, (value) {
    return _then(_self.copyWith(unit_system: value));
  });
}
}


/// @nodoc
mixin _$UnitSystem {

 String get length; String get mass; String get volume; String get temperature; String get pressure; String get wind_speed; String get accumulated_precipitation;
/// Create a copy of UnitSystem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnitSystemCopyWith<UnitSystem> get copyWith => _$UnitSystemCopyWithImpl<UnitSystem>(this as UnitSystem, _$identity);

  /// Serializes this UnitSystem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnitSystem&&(identical(other.length, length) || other.length == length)&&(identical(other.mass, mass) || other.mass == mass)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.wind_speed, wind_speed) || other.wind_speed == wind_speed)&&(identical(other.accumulated_precipitation, accumulated_precipitation) || other.accumulated_precipitation == accumulated_precipitation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,length,mass,volume,temperature,pressure,wind_speed,accumulated_precipitation);

@override
String toString() {
  return 'UnitSystem(length: $length, mass: $mass, volume: $volume, temperature: $temperature, pressure: $pressure, wind_speed: $wind_speed, accumulated_precipitation: $accumulated_precipitation)';
}


}

/// @nodoc
abstract mixin class $UnitSystemCopyWith<$Res>  {
  factory $UnitSystemCopyWith(UnitSystem value, $Res Function(UnitSystem) _then) = _$UnitSystemCopyWithImpl;
@useResult
$Res call({
 String length, String mass, String volume, String temperature, String pressure, String wind_speed, String accumulated_precipitation
});




}
/// @nodoc
class _$UnitSystemCopyWithImpl<$Res>
    implements $UnitSystemCopyWith<$Res> {
  _$UnitSystemCopyWithImpl(this._self, this._then);

  final UnitSystem _self;
  final $Res Function(UnitSystem) _then;

/// Create a copy of UnitSystem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? length = null,Object? mass = null,Object? volume = null,Object? temperature = null,Object? pressure = null,Object? wind_speed = null,Object? accumulated_precipitation = null,}) {
  return _then(_self.copyWith(
length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as String,mass: null == mass ? _self.mass : mass // ignore: cast_nullable_to_non_nullable
as String,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as String,pressure: null == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as String,wind_speed: null == wind_speed ? _self.wind_speed : wind_speed // ignore: cast_nullable_to_non_nullable
as String,accumulated_precipitation: null == accumulated_precipitation ? _self.accumulated_precipitation : accumulated_precipitation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UnitSystem].
extension UnitSystemPatterns on UnitSystem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnitSystem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnitSystem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnitSystem value)  $default,){
final _that = this;
switch (_that) {
case _UnitSystem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnitSystem value)?  $default,){
final _that = this;
switch (_that) {
case _UnitSystem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String length,  String mass,  String volume,  String temperature,  String pressure,  String wind_speed,  String accumulated_precipitation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnitSystem() when $default != null:
return $default(_that.length,_that.mass,_that.volume,_that.temperature,_that.pressure,_that.wind_speed,_that.accumulated_precipitation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String length,  String mass,  String volume,  String temperature,  String pressure,  String wind_speed,  String accumulated_precipitation)  $default,) {final _that = this;
switch (_that) {
case _UnitSystem():
return $default(_that.length,_that.mass,_that.volume,_that.temperature,_that.pressure,_that.wind_speed,_that.accumulated_precipitation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String length,  String mass,  String volume,  String temperature,  String pressure,  String wind_speed,  String accumulated_precipitation)?  $default,) {final _that = this;
switch (_that) {
case _UnitSystem() when $default != null:
return $default(_that.length,_that.mass,_that.volume,_that.temperature,_that.pressure,_that.wind_speed,_that.accumulated_precipitation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnitSystem implements UnitSystem {
  const _UnitSystem({required this.length, required this.mass, required this.volume, required this.temperature, required this.pressure, required this.wind_speed, required this.accumulated_precipitation});
  factory _UnitSystem.fromJson(Map<String, dynamic> json) => _$UnitSystemFromJson(json);

@override final  String length;
@override final  String mass;
@override final  String volume;
@override final  String temperature;
@override final  String pressure;
@override final  String wind_speed;
@override final  String accumulated_precipitation;

/// Create a copy of UnitSystem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnitSystemCopyWith<_UnitSystem> get copyWith => __$UnitSystemCopyWithImpl<_UnitSystem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnitSystemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnitSystem&&(identical(other.length, length) || other.length == length)&&(identical(other.mass, mass) || other.mass == mass)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.wind_speed, wind_speed) || other.wind_speed == wind_speed)&&(identical(other.accumulated_precipitation, accumulated_precipitation) || other.accumulated_precipitation == accumulated_precipitation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,length,mass,volume,temperature,pressure,wind_speed,accumulated_precipitation);

@override
String toString() {
  return 'UnitSystem(length: $length, mass: $mass, volume: $volume, temperature: $temperature, pressure: $pressure, wind_speed: $wind_speed, accumulated_precipitation: $accumulated_precipitation)';
}


}

/// @nodoc
abstract mixin class _$UnitSystemCopyWith<$Res> implements $UnitSystemCopyWith<$Res> {
  factory _$UnitSystemCopyWith(_UnitSystem value, $Res Function(_UnitSystem) _then) = __$UnitSystemCopyWithImpl;
@override @useResult
$Res call({
 String length, String mass, String volume, String temperature, String pressure, String wind_speed, String accumulated_precipitation
});




}
/// @nodoc
class __$UnitSystemCopyWithImpl<$Res>
    implements _$UnitSystemCopyWith<$Res> {
  __$UnitSystemCopyWithImpl(this._self, this._then);

  final _UnitSystem _self;
  final $Res Function(_UnitSystem) _then;

/// Create a copy of UnitSystem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? length = null,Object? mass = null,Object? volume = null,Object? temperature = null,Object? pressure = null,Object? wind_speed = null,Object? accumulated_precipitation = null,}) {
  return _then(_UnitSystem(
length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as String,mass: null == mass ? _self.mass : mass // ignore: cast_nullable_to_non_nullable
as String,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as String,pressure: null == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as String,wind_speed: null == wind_speed ? _self.wind_speed : wind_speed // ignore: cast_nullable_to_non_nullable
as String,accumulated_precipitation: null == accumulated_precipitation ? _self.accumulated_precipitation : accumulated_precipitation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
