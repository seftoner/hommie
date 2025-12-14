// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'floor_registry_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FloorRegistryEntry {

 double get createdAt; double get modifiedAt; String get floorId; String get name; int? get level; String? get icon; List<String> get aliases;
/// Create a copy of FloorRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FloorRegistryEntryCopyWith<FloorRegistryEntry> get copyWith => _$FloorRegistryEntryCopyWithImpl<FloorRegistryEntry>(this as FloorRegistryEntry, _$identity);

  /// Serializes this FloorRegistryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FloorRegistryEntry&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt)&&(identical(other.floorId, floorId) || other.floorId == floorId)&&(identical(other.name, name) || other.name == name)&&(identical(other.level, level) || other.level == level)&&(identical(other.icon, icon) || other.icon == icon)&&const DeepCollectionEquality().equals(other.aliases, aliases));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,createdAt,modifiedAt,floorId,name,level,icon,const DeepCollectionEquality().hash(aliases));

@override
String toString() {
  return 'FloorRegistryEntry(createdAt: $createdAt, modifiedAt: $modifiedAt, floorId: $floorId, name: $name, level: $level, icon: $icon, aliases: $aliases)';
}


}

/// @nodoc
abstract mixin class $FloorRegistryEntryCopyWith<$Res>  {
  factory $FloorRegistryEntryCopyWith(FloorRegistryEntry value, $Res Function(FloorRegistryEntry) _then) = _$FloorRegistryEntryCopyWithImpl;
@useResult
$Res call({
 double createdAt, double modifiedAt, String floorId, String name, int? level, String? icon, List<String> aliases
});




}
/// @nodoc
class _$FloorRegistryEntryCopyWithImpl<$Res>
    implements $FloorRegistryEntryCopyWith<$Res> {
  _$FloorRegistryEntryCopyWithImpl(this._self, this._then);

  final FloorRegistryEntry _self;
  final $Res Function(FloorRegistryEntry) _then;

/// Create a copy of FloorRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? createdAt = null,Object? modifiedAt = null,Object? floorId = null,Object? name = null,Object? level = freezed,Object? icon = freezed,Object? aliases = null,}) {
  return _then(_self.copyWith(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as double,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as double,floorId: null == floorId ? _self.floorId : floorId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,aliases: null == aliases ? _self.aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [FloorRegistryEntry].
extension FloorRegistryEntryPatterns on FloorRegistryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FloorRegistryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FloorRegistryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FloorRegistryEntry value)  $default,){
final _that = this;
switch (_that) {
case _FloorRegistryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FloorRegistryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _FloorRegistryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double createdAt,  double modifiedAt,  String floorId,  String name,  int? level,  String? icon,  List<String> aliases)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FloorRegistryEntry() when $default != null:
return $default(_that.createdAt,_that.modifiedAt,_that.floorId,_that.name,_that.level,_that.icon,_that.aliases);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double createdAt,  double modifiedAt,  String floorId,  String name,  int? level,  String? icon,  List<String> aliases)  $default,) {final _that = this;
switch (_that) {
case _FloorRegistryEntry():
return $default(_that.createdAt,_that.modifiedAt,_that.floorId,_that.name,_that.level,_that.icon,_that.aliases);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double createdAt,  double modifiedAt,  String floorId,  String name,  int? level,  String? icon,  List<String> aliases)?  $default,) {final _that = this;
switch (_that) {
case _FloorRegistryEntry() when $default != null:
return $default(_that.createdAt,_that.modifiedAt,_that.floorId,_that.name,_that.level,_that.icon,_that.aliases);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _FloorRegistryEntry implements FloorRegistryEntry {
  const _FloorRegistryEntry({required this.createdAt, required this.modifiedAt, required this.floorId, required this.name, this.level, this.icon, required final  List<String> aliases}): _aliases = aliases;
  factory _FloorRegistryEntry.fromJson(Map<String, dynamic> json) => _$FloorRegistryEntryFromJson(json);

@override final  double createdAt;
@override final  double modifiedAt;
@override final  String floorId;
@override final  String name;
@override final  int? level;
@override final  String? icon;
 final  List<String> _aliases;
@override List<String> get aliases {
  if (_aliases is EqualUnmodifiableListView) return _aliases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aliases);
}


/// Create a copy of FloorRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FloorRegistryEntryCopyWith<_FloorRegistryEntry> get copyWith => __$FloorRegistryEntryCopyWithImpl<_FloorRegistryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FloorRegistryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FloorRegistryEntry&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt)&&(identical(other.floorId, floorId) || other.floorId == floorId)&&(identical(other.name, name) || other.name == name)&&(identical(other.level, level) || other.level == level)&&(identical(other.icon, icon) || other.icon == icon)&&const DeepCollectionEquality().equals(other._aliases, _aliases));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,createdAt,modifiedAt,floorId,name,level,icon,const DeepCollectionEquality().hash(_aliases));

@override
String toString() {
  return 'FloorRegistryEntry(createdAt: $createdAt, modifiedAt: $modifiedAt, floorId: $floorId, name: $name, level: $level, icon: $icon, aliases: $aliases)';
}


}

/// @nodoc
abstract mixin class _$FloorRegistryEntryCopyWith<$Res> implements $FloorRegistryEntryCopyWith<$Res> {
  factory _$FloorRegistryEntryCopyWith(_FloorRegistryEntry value, $Res Function(_FloorRegistryEntry) _then) = __$FloorRegistryEntryCopyWithImpl;
@override @useResult
$Res call({
 double createdAt, double modifiedAt, String floorId, String name, int? level, String? icon, List<String> aliases
});




}
/// @nodoc
class __$FloorRegistryEntryCopyWithImpl<$Res>
    implements _$FloorRegistryEntryCopyWith<$Res> {
  __$FloorRegistryEntryCopyWithImpl(this._self, this._then);

  final _FloorRegistryEntry _self;
  final $Res Function(_FloorRegistryEntry) _then;

/// Create a copy of FloorRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? createdAt = null,Object? modifiedAt = null,Object? floorId = null,Object? name = null,Object? level = freezed,Object? icon = freezed,Object? aliases = null,}) {
  return _then(_FloorRegistryEntry(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as double,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as double,floorId: null == floorId ? _self.floorId : floorId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,aliases: null == aliases ? _self._aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
