// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'area_registry_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AreaRegistryEntry {

 double get createdAt; double get modifiedAt; List<String> get aliases; String get areaId; String? get floorId; String? get humidityEntityId; String? get icon; List<String> get labels; String get name; String? get picture; String? get temperatureEntityId;
/// Create a copy of AreaRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaRegistryEntryCopyWith<AreaRegistryEntry> get copyWith => _$AreaRegistryEntryCopyWithImpl<AreaRegistryEntry>(this as AreaRegistryEntry, _$identity);

  /// Serializes this AreaRegistryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreaRegistryEntry&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt)&&const DeepCollectionEquality().equals(other.aliases, aliases)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.floorId, floorId) || other.floorId == floorId)&&(identical(other.humidityEntityId, humidityEntityId) || other.humidityEntityId == humidityEntityId)&&(identical(other.icon, icon) || other.icon == icon)&&const DeepCollectionEquality().equals(other.labels, labels)&&(identical(other.name, name) || other.name == name)&&(identical(other.picture, picture) || other.picture == picture)&&(identical(other.temperatureEntityId, temperatureEntityId) || other.temperatureEntityId == temperatureEntityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,createdAt,modifiedAt,const DeepCollectionEquality().hash(aliases),areaId,floorId,humidityEntityId,icon,const DeepCollectionEquality().hash(labels),name,picture,temperatureEntityId);

@override
String toString() {
  return 'AreaRegistryEntry(createdAt: $createdAt, modifiedAt: $modifiedAt, aliases: $aliases, areaId: $areaId, floorId: $floorId, humidityEntityId: $humidityEntityId, icon: $icon, labels: $labels, name: $name, picture: $picture, temperatureEntityId: $temperatureEntityId)';
}


}

/// @nodoc
abstract mixin class $AreaRegistryEntryCopyWith<$Res>  {
  factory $AreaRegistryEntryCopyWith(AreaRegistryEntry value, $Res Function(AreaRegistryEntry) _then) = _$AreaRegistryEntryCopyWithImpl;
@useResult
$Res call({
 double createdAt, double modifiedAt, List<String> aliases, String areaId, String? floorId, String? humidityEntityId, String? icon, List<String> labels, String name, String? picture, String? temperatureEntityId
});




}
/// @nodoc
class _$AreaRegistryEntryCopyWithImpl<$Res>
    implements $AreaRegistryEntryCopyWith<$Res> {
  _$AreaRegistryEntryCopyWithImpl(this._self, this._then);

  final AreaRegistryEntry _self;
  final $Res Function(AreaRegistryEntry) _then;

/// Create a copy of AreaRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? createdAt = null,Object? modifiedAt = null,Object? aliases = null,Object? areaId = null,Object? floorId = freezed,Object? humidityEntityId = freezed,Object? icon = freezed,Object? labels = null,Object? name = null,Object? picture = freezed,Object? temperatureEntityId = freezed,}) {
  return _then(_self.copyWith(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as double,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as double,aliases: null == aliases ? _self.aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as String,floorId: freezed == floorId ? _self.floorId : floorId // ignore: cast_nullable_to_non_nullable
as String?,humidityEntityId: freezed == humidityEntityId ? _self.humidityEntityId : humidityEntityId // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,picture: freezed == picture ? _self.picture : picture // ignore: cast_nullable_to_non_nullable
as String?,temperatureEntityId: freezed == temperatureEntityId ? _self.temperatureEntityId : temperatureEntityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AreaRegistryEntry].
extension AreaRegistryEntryPatterns on AreaRegistryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AreaRegistryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AreaRegistryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AreaRegistryEntry value)  $default,){
final _that = this;
switch (_that) {
case _AreaRegistryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AreaRegistryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _AreaRegistryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double createdAt,  double modifiedAt,  List<String> aliases,  String areaId,  String? floorId,  String? humidityEntityId,  String? icon,  List<String> labels,  String name,  String? picture,  String? temperatureEntityId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AreaRegistryEntry() when $default != null:
return $default(_that.createdAt,_that.modifiedAt,_that.aliases,_that.areaId,_that.floorId,_that.humidityEntityId,_that.icon,_that.labels,_that.name,_that.picture,_that.temperatureEntityId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double createdAt,  double modifiedAt,  List<String> aliases,  String areaId,  String? floorId,  String? humidityEntityId,  String? icon,  List<String> labels,  String name,  String? picture,  String? temperatureEntityId)  $default,) {final _that = this;
switch (_that) {
case _AreaRegistryEntry():
return $default(_that.createdAt,_that.modifiedAt,_that.aliases,_that.areaId,_that.floorId,_that.humidityEntityId,_that.icon,_that.labels,_that.name,_that.picture,_that.temperatureEntityId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double createdAt,  double modifiedAt,  List<String> aliases,  String areaId,  String? floorId,  String? humidityEntityId,  String? icon,  List<String> labels,  String name,  String? picture,  String? temperatureEntityId)?  $default,) {final _that = this;
switch (_that) {
case _AreaRegistryEntry() when $default != null:
return $default(_that.createdAt,_that.modifiedAt,_that.aliases,_that.areaId,_that.floorId,_that.humidityEntityId,_that.icon,_that.labels,_that.name,_that.picture,_that.temperatureEntityId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _AreaRegistryEntry implements AreaRegistryEntry, RegistryEntry {
  const _AreaRegistryEntry({required this.createdAt, required this.modifiedAt, required final  List<String> aliases, required this.areaId, this.floorId, this.humidityEntityId, this.icon, required final  List<String> labels, required this.name, this.picture, this.temperatureEntityId}): _aliases = aliases,_labels = labels;
  factory _AreaRegistryEntry.fromJson(Map<String, dynamic> json) => _$AreaRegistryEntryFromJson(json);

@override final  double createdAt;
@override final  double modifiedAt;
 final  List<String> _aliases;
@override List<String> get aliases {
  if (_aliases is EqualUnmodifiableListView) return _aliases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aliases);
}

@override final  String areaId;
@override final  String? floorId;
@override final  String? humidityEntityId;
@override final  String? icon;
 final  List<String> _labels;
@override List<String> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override final  String name;
@override final  String? picture;
@override final  String? temperatureEntityId;

/// Create a copy of AreaRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AreaRegistryEntryCopyWith<_AreaRegistryEntry> get copyWith => __$AreaRegistryEntryCopyWithImpl<_AreaRegistryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaRegistryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AreaRegistryEntry&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt)&&const DeepCollectionEquality().equals(other._aliases, _aliases)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.floorId, floorId) || other.floorId == floorId)&&(identical(other.humidityEntityId, humidityEntityId) || other.humidityEntityId == humidityEntityId)&&(identical(other.icon, icon) || other.icon == icon)&&const DeepCollectionEquality().equals(other._labels, _labels)&&(identical(other.name, name) || other.name == name)&&(identical(other.picture, picture) || other.picture == picture)&&(identical(other.temperatureEntityId, temperatureEntityId) || other.temperatureEntityId == temperatureEntityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,createdAt,modifiedAt,const DeepCollectionEquality().hash(_aliases),areaId,floorId,humidityEntityId,icon,const DeepCollectionEquality().hash(_labels),name,picture,temperatureEntityId);

@override
String toString() {
  return 'AreaRegistryEntry(createdAt: $createdAt, modifiedAt: $modifiedAt, aliases: $aliases, areaId: $areaId, floorId: $floorId, humidityEntityId: $humidityEntityId, icon: $icon, labels: $labels, name: $name, picture: $picture, temperatureEntityId: $temperatureEntityId)';
}


}

/// @nodoc
abstract mixin class _$AreaRegistryEntryCopyWith<$Res> implements $AreaRegistryEntryCopyWith<$Res> {
  factory _$AreaRegistryEntryCopyWith(_AreaRegistryEntry value, $Res Function(_AreaRegistryEntry) _then) = __$AreaRegistryEntryCopyWithImpl;
@override @useResult
$Res call({
 double createdAt, double modifiedAt, List<String> aliases, String areaId, String? floorId, String? humidityEntityId, String? icon, List<String> labels, String name, String? picture, String? temperatureEntityId
});




}
/// @nodoc
class __$AreaRegistryEntryCopyWithImpl<$Res>
    implements _$AreaRegistryEntryCopyWith<$Res> {
  __$AreaRegistryEntryCopyWithImpl(this._self, this._then);

  final _AreaRegistryEntry _self;
  final $Res Function(_AreaRegistryEntry) _then;

/// Create a copy of AreaRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? createdAt = null,Object? modifiedAt = null,Object? aliases = null,Object? areaId = null,Object? floorId = freezed,Object? humidityEntityId = freezed,Object? icon = freezed,Object? labels = null,Object? name = null,Object? picture = freezed,Object? temperatureEntityId = freezed,}) {
  return _then(_AreaRegistryEntry(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as double,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as double,aliases: null == aliases ? _self._aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as String,floorId: freezed == floorId ? _self.floorId : floorId // ignore: cast_nullable_to_non_nullable
as String?,humidityEntityId: freezed == humidityEntityId ? _self.humidityEntityId : humidityEntityId // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,picture: freezed == picture ? _self.picture : picture // ignore: cast_nullable_to_non_nullable
as String?,temperatureEntityId: freezed == temperatureEntityId ? _self.temperatureEntityId : temperatureEntityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
