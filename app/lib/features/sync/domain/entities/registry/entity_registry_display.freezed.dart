// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entity_registry_display.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EntityRegistryDisplayEntry {

 String get entity_id; String? get name; String? get icon; String? get device_id; String? get area_id; List<String> get labels; bool? get hidden; EntityCategory? get entity_category; String? get translation_key; String? get platform; int? get display_precision; bool? get has_entity_name;
/// Create a copy of EntityRegistryDisplayEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntityRegistryDisplayEntryCopyWith<EntityRegistryDisplayEntry> get copyWith => _$EntityRegistryDisplayEntryCopyWithImpl<EntityRegistryDisplayEntry>(this as EntityRegistryDisplayEntry, _$identity);

  /// Serializes this EntityRegistryDisplayEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntityRegistryDisplayEntry&&(identical(other.entity_id, entity_id) || other.entity_id == entity_id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.device_id, device_id) || other.device_id == device_id)&&(identical(other.area_id, area_id) || other.area_id == area_id)&&const DeepCollectionEquality().equals(other.labels, labels)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.entity_category, entity_category) || other.entity_category == entity_category)&&(identical(other.translation_key, translation_key) || other.translation_key == translation_key)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.display_precision, display_precision) || other.display_precision == display_precision)&&(identical(other.has_entity_name, has_entity_name) || other.has_entity_name == has_entity_name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entity_id,name,icon,device_id,area_id,const DeepCollectionEquality().hash(labels),hidden,entity_category,translation_key,platform,display_precision,has_entity_name);

@override
String toString() {
  return 'EntityRegistryDisplayEntry(entity_id: $entity_id, name: $name, icon: $icon, device_id: $device_id, area_id: $area_id, labels: $labels, hidden: $hidden, entity_category: $entity_category, translation_key: $translation_key, platform: $platform, display_precision: $display_precision, has_entity_name: $has_entity_name)';
}


}

/// @nodoc
abstract mixin class $EntityRegistryDisplayEntryCopyWith<$Res>  {
  factory $EntityRegistryDisplayEntryCopyWith(EntityRegistryDisplayEntry value, $Res Function(EntityRegistryDisplayEntry) _then) = _$EntityRegistryDisplayEntryCopyWithImpl;
@useResult
$Res call({
 String entity_id, String? name, String? icon, String? device_id, String? area_id, List<String> labels, bool? hidden, EntityCategory? entity_category, String? translation_key, String? platform, int? display_precision, bool? has_entity_name
});




}
/// @nodoc
class _$EntityRegistryDisplayEntryCopyWithImpl<$Res>
    implements $EntityRegistryDisplayEntryCopyWith<$Res> {
  _$EntityRegistryDisplayEntryCopyWithImpl(this._self, this._then);

  final EntityRegistryDisplayEntry _self;
  final $Res Function(EntityRegistryDisplayEntry) _then;

/// Create a copy of EntityRegistryDisplayEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entity_id = null,Object? name = freezed,Object? icon = freezed,Object? device_id = freezed,Object? area_id = freezed,Object? labels = null,Object? hidden = freezed,Object? entity_category = freezed,Object? translation_key = freezed,Object? platform = freezed,Object? display_precision = freezed,Object? has_entity_name = freezed,}) {
  return _then(_self.copyWith(
entity_id: null == entity_id ? _self.entity_id : entity_id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,device_id: freezed == device_id ? _self.device_id : device_id // ignore: cast_nullable_to_non_nullable
as String?,area_id: freezed == area_id ? _self.area_id : area_id // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,hidden: freezed == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool?,entity_category: freezed == entity_category ? _self.entity_category : entity_category // ignore: cast_nullable_to_non_nullable
as EntityCategory?,translation_key: freezed == translation_key ? _self.translation_key : translation_key // ignore: cast_nullable_to_non_nullable
as String?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,display_precision: freezed == display_precision ? _self.display_precision : display_precision // ignore: cast_nullable_to_non_nullable
as int?,has_entity_name: freezed == has_entity_name ? _self.has_entity_name : has_entity_name // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [EntityRegistryDisplayEntry].
extension EntityRegistryDisplayEntryPatterns on EntityRegistryDisplayEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntityRegistryDisplayEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntityRegistryDisplayEntry value)  $default,){
final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntityRegistryDisplayEntry value)?  $default,){
final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String entity_id,  String? name,  String? icon,  String? device_id,  String? area_id,  List<String> labels,  bool? hidden,  EntityCategory? entity_category,  String? translation_key,  String? platform,  int? display_precision,  bool? has_entity_name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntry() when $default != null:
return $default(_that.entity_id,_that.name,_that.icon,_that.device_id,_that.area_id,_that.labels,_that.hidden,_that.entity_category,_that.translation_key,_that.platform,_that.display_precision,_that.has_entity_name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String entity_id,  String? name,  String? icon,  String? device_id,  String? area_id,  List<String> labels,  bool? hidden,  EntityCategory? entity_category,  String? translation_key,  String? platform,  int? display_precision,  bool? has_entity_name)  $default,) {final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntry():
return $default(_that.entity_id,_that.name,_that.icon,_that.device_id,_that.area_id,_that.labels,_that.hidden,_that.entity_category,_that.translation_key,_that.platform,_that.display_precision,_that.has_entity_name);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String entity_id,  String? name,  String? icon,  String? device_id,  String? area_id,  List<String> labels,  bool? hidden,  EntityCategory? entity_category,  String? translation_key,  String? platform,  int? display_precision,  bool? has_entity_name)?  $default,) {final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntry() when $default != null:
return $default(_that.entity_id,_that.name,_that.icon,_that.device_id,_that.area_id,_that.labels,_that.hidden,_that.entity_category,_that.translation_key,_that.platform,_that.display_precision,_that.has_entity_name);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _EntityRegistryDisplayEntry implements EntityRegistryDisplayEntry {
  const _EntityRegistryDisplayEntry({required this.entity_id, this.name, this.icon, this.device_id, this.area_id, required final  List<String> labels, this.hidden, this.entity_category, this.translation_key, this.platform, this.display_precision, this.has_entity_name}): _labels = labels;
  factory _EntityRegistryDisplayEntry.fromJson(Map<String, dynamic> json) => _$EntityRegistryDisplayEntryFromJson(json);

@override final  String entity_id;
@override final  String? name;
@override final  String? icon;
@override final  String? device_id;
@override final  String? area_id;
 final  List<String> _labels;
@override List<String> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override final  bool? hidden;
@override final  EntityCategory? entity_category;
@override final  String? translation_key;
@override final  String? platform;
@override final  int? display_precision;
@override final  bool? has_entity_name;

/// Create a copy of EntityRegistryDisplayEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntityRegistryDisplayEntryCopyWith<_EntityRegistryDisplayEntry> get copyWith => __$EntityRegistryDisplayEntryCopyWithImpl<_EntityRegistryDisplayEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntityRegistryDisplayEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntityRegistryDisplayEntry&&(identical(other.entity_id, entity_id) || other.entity_id == entity_id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.device_id, device_id) || other.device_id == device_id)&&(identical(other.area_id, area_id) || other.area_id == area_id)&&const DeepCollectionEquality().equals(other._labels, _labels)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.entity_category, entity_category) || other.entity_category == entity_category)&&(identical(other.translation_key, translation_key) || other.translation_key == translation_key)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.display_precision, display_precision) || other.display_precision == display_precision)&&(identical(other.has_entity_name, has_entity_name) || other.has_entity_name == has_entity_name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entity_id,name,icon,device_id,area_id,const DeepCollectionEquality().hash(_labels),hidden,entity_category,translation_key,platform,display_precision,has_entity_name);

@override
String toString() {
  return 'EntityRegistryDisplayEntry(entity_id: $entity_id, name: $name, icon: $icon, device_id: $device_id, area_id: $area_id, labels: $labels, hidden: $hidden, entity_category: $entity_category, translation_key: $translation_key, platform: $platform, display_precision: $display_precision, has_entity_name: $has_entity_name)';
}


}

/// @nodoc
abstract mixin class _$EntityRegistryDisplayEntryCopyWith<$Res> implements $EntityRegistryDisplayEntryCopyWith<$Res> {
  factory _$EntityRegistryDisplayEntryCopyWith(_EntityRegistryDisplayEntry value, $Res Function(_EntityRegistryDisplayEntry) _then) = __$EntityRegistryDisplayEntryCopyWithImpl;
@override @useResult
$Res call({
 String entity_id, String? name, String? icon, String? device_id, String? area_id, List<String> labels, bool? hidden, EntityCategory? entity_category, String? translation_key, String? platform, int? display_precision, bool? has_entity_name
});




}
/// @nodoc
class __$EntityRegistryDisplayEntryCopyWithImpl<$Res>
    implements _$EntityRegistryDisplayEntryCopyWith<$Res> {
  __$EntityRegistryDisplayEntryCopyWithImpl(this._self, this._then);

  final _EntityRegistryDisplayEntry _self;
  final $Res Function(_EntityRegistryDisplayEntry) _then;

/// Create a copy of EntityRegistryDisplayEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entity_id = null,Object? name = freezed,Object? icon = freezed,Object? device_id = freezed,Object? area_id = freezed,Object? labels = null,Object? hidden = freezed,Object? entity_category = freezed,Object? translation_key = freezed,Object? platform = freezed,Object? display_precision = freezed,Object? has_entity_name = freezed,}) {
  return _then(_EntityRegistryDisplayEntry(
entity_id: null == entity_id ? _self.entity_id : entity_id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,device_id: freezed == device_id ? _self.device_id : device_id // ignore: cast_nullable_to_non_nullable
as String?,area_id: freezed == area_id ? _self.area_id : area_id // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,hidden: freezed == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool?,entity_category: freezed == entity_category ? _self.entity_category : entity_category // ignore: cast_nullable_to_non_nullable
as EntityCategory?,translation_key: freezed == translation_key ? _self.translation_key : translation_key // ignore: cast_nullable_to_non_nullable
as String?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,display_precision: freezed == display_precision ? _self.display_precision : display_precision // ignore: cast_nullable_to_non_nullable
as int?,has_entity_name: freezed == has_entity_name ? _self.has_entity_name : has_entity_name // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$EntityRegistryDisplayEntryResponseEntity {

@JsonKey(name: 'ei') String get entityId;@JsonKey(name: 'di') String? get deviceId;@JsonKey(name: 'ai') String? get areaId;@JsonKey(name: 'lb') List<String> get labels;@JsonKey(name: 'ec') int? get entityCategoryId;@JsonKey(name: 'en') String? get name;@JsonKey(name: 'ic') String? get icon;@JsonKey(name: 'pl') String? get platform;@JsonKey(name: 'tk') String? get translationKey;@JsonKey(name: 'hb') bool? get hidden;@JsonKey(name: 'dp') int? get displayPrecision;@JsonKey(name: 'hn') bool? get hasEntityName;
/// Create a copy of EntityRegistryDisplayEntryResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntityRegistryDisplayEntryResponseEntityCopyWith<EntityRegistryDisplayEntryResponseEntity> get copyWith => _$EntityRegistryDisplayEntryResponseEntityCopyWithImpl<EntityRegistryDisplayEntryResponseEntity>(this as EntityRegistryDisplayEntryResponseEntity, _$identity);

  /// Serializes this EntityRegistryDisplayEntryResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntityRegistryDisplayEntryResponseEntity&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&const DeepCollectionEquality().equals(other.labels, labels)&&(identical(other.entityCategoryId, entityCategoryId) || other.entityCategoryId == entityCategoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.translationKey, translationKey) || other.translationKey == translationKey)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.displayPrecision, displayPrecision) || other.displayPrecision == displayPrecision)&&(identical(other.hasEntityName, hasEntityName) || other.hasEntityName == hasEntityName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entityId,deviceId,areaId,const DeepCollectionEquality().hash(labels),entityCategoryId,name,icon,platform,translationKey,hidden,displayPrecision,hasEntityName);

@override
String toString() {
  return 'EntityRegistryDisplayEntryResponseEntity(entityId: $entityId, deviceId: $deviceId, areaId: $areaId, labels: $labels, entityCategoryId: $entityCategoryId, name: $name, icon: $icon, platform: $platform, translationKey: $translationKey, hidden: $hidden, displayPrecision: $displayPrecision, hasEntityName: $hasEntityName)';
}


}

/// @nodoc
abstract mixin class $EntityRegistryDisplayEntryResponseEntityCopyWith<$Res>  {
  factory $EntityRegistryDisplayEntryResponseEntityCopyWith(EntityRegistryDisplayEntryResponseEntity value, $Res Function(EntityRegistryDisplayEntryResponseEntity) _then) = _$EntityRegistryDisplayEntryResponseEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'ei') String entityId,@JsonKey(name: 'di') String? deviceId,@JsonKey(name: 'ai') String? areaId,@JsonKey(name: 'lb') List<String> labels,@JsonKey(name: 'ec') int? entityCategoryId,@JsonKey(name: 'en') String? name,@JsonKey(name: 'ic') String? icon,@JsonKey(name: 'pl') String? platform,@JsonKey(name: 'tk') String? translationKey,@JsonKey(name: 'hb') bool? hidden,@JsonKey(name: 'dp') int? displayPrecision,@JsonKey(name: 'hn') bool? hasEntityName
});




}
/// @nodoc
class _$EntityRegistryDisplayEntryResponseEntityCopyWithImpl<$Res>
    implements $EntityRegistryDisplayEntryResponseEntityCopyWith<$Res> {
  _$EntityRegistryDisplayEntryResponseEntityCopyWithImpl(this._self, this._then);

  final EntityRegistryDisplayEntryResponseEntity _self;
  final $Res Function(EntityRegistryDisplayEntryResponseEntity) _then;

/// Create a copy of EntityRegistryDisplayEntryResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entityId = null,Object? deviceId = freezed,Object? areaId = freezed,Object? labels = null,Object? entityCategoryId = freezed,Object? name = freezed,Object? icon = freezed,Object? platform = freezed,Object? translationKey = freezed,Object? hidden = freezed,Object? displayPrecision = freezed,Object? hasEntityName = freezed,}) {
  return _then(_self.copyWith(
entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,areaId: freezed == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,entityCategoryId: freezed == entityCategoryId ? _self.entityCategoryId : entityCategoryId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,translationKey: freezed == translationKey ? _self.translationKey : translationKey // ignore: cast_nullable_to_non_nullable
as String?,hidden: freezed == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool?,displayPrecision: freezed == displayPrecision ? _self.displayPrecision : displayPrecision // ignore: cast_nullable_to_non_nullable
as int?,hasEntityName: freezed == hasEntityName ? _self.hasEntityName : hasEntityName // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [EntityRegistryDisplayEntryResponseEntity].
extension EntityRegistryDisplayEntryResponseEntityPatterns on EntityRegistryDisplayEntryResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntityRegistryDisplayEntryResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntryResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntityRegistryDisplayEntryResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntryResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntityRegistryDisplayEntryResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntryResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'ei')  String entityId, @JsonKey(name: 'di')  String? deviceId, @JsonKey(name: 'ai')  String? areaId, @JsonKey(name: 'lb')  List<String> labels, @JsonKey(name: 'ec')  int? entityCategoryId, @JsonKey(name: 'en')  String? name, @JsonKey(name: 'ic')  String? icon, @JsonKey(name: 'pl')  String? platform, @JsonKey(name: 'tk')  String? translationKey, @JsonKey(name: 'hb')  bool? hidden, @JsonKey(name: 'dp')  int? displayPrecision, @JsonKey(name: 'hn')  bool? hasEntityName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntryResponseEntity() when $default != null:
return $default(_that.entityId,_that.deviceId,_that.areaId,_that.labels,_that.entityCategoryId,_that.name,_that.icon,_that.platform,_that.translationKey,_that.hidden,_that.displayPrecision,_that.hasEntityName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'ei')  String entityId, @JsonKey(name: 'di')  String? deviceId, @JsonKey(name: 'ai')  String? areaId, @JsonKey(name: 'lb')  List<String> labels, @JsonKey(name: 'ec')  int? entityCategoryId, @JsonKey(name: 'en')  String? name, @JsonKey(name: 'ic')  String? icon, @JsonKey(name: 'pl')  String? platform, @JsonKey(name: 'tk')  String? translationKey, @JsonKey(name: 'hb')  bool? hidden, @JsonKey(name: 'dp')  int? displayPrecision, @JsonKey(name: 'hn')  bool? hasEntityName)  $default,) {final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntryResponseEntity():
return $default(_that.entityId,_that.deviceId,_that.areaId,_that.labels,_that.entityCategoryId,_that.name,_that.icon,_that.platform,_that.translationKey,_that.hidden,_that.displayPrecision,_that.hasEntityName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'ei')  String entityId, @JsonKey(name: 'di')  String? deviceId, @JsonKey(name: 'ai')  String? areaId, @JsonKey(name: 'lb')  List<String> labels, @JsonKey(name: 'ec')  int? entityCategoryId, @JsonKey(name: 'en')  String? name, @JsonKey(name: 'ic')  String? icon, @JsonKey(name: 'pl')  String? platform, @JsonKey(name: 'tk')  String? translationKey, @JsonKey(name: 'hb')  bool? hidden, @JsonKey(name: 'dp')  int? displayPrecision, @JsonKey(name: 'hn')  bool? hasEntityName)?  $default,) {final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntryResponseEntity() when $default != null:
return $default(_that.entityId,_that.deviceId,_that.areaId,_that.labels,_that.entityCategoryId,_that.name,_that.icon,_that.platform,_that.translationKey,_that.hidden,_that.displayPrecision,_that.hasEntityName);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _EntityRegistryDisplayEntryResponseEntity implements EntityRegistryDisplayEntryResponseEntity {
  const _EntityRegistryDisplayEntryResponseEntity({@JsonKey(name: 'ei') required this.entityId, @JsonKey(name: 'di') this.deviceId, @JsonKey(name: 'ai') this.areaId, @JsonKey(name: 'lb') required final  List<String> labels, @JsonKey(name: 'ec') this.entityCategoryId, @JsonKey(name: 'en') this.name, @JsonKey(name: 'ic') this.icon, @JsonKey(name: 'pl') this.platform, @JsonKey(name: 'tk') this.translationKey, @JsonKey(name: 'hb') this.hidden, @JsonKey(name: 'dp') this.displayPrecision, @JsonKey(name: 'hn') this.hasEntityName}): _labels = labels;
  factory _EntityRegistryDisplayEntryResponseEntity.fromJson(Map<String, dynamic> json) => _$EntityRegistryDisplayEntryResponseEntityFromJson(json);

@override@JsonKey(name: 'ei') final  String entityId;
@override@JsonKey(name: 'di') final  String? deviceId;
@override@JsonKey(name: 'ai') final  String? areaId;
 final  List<String> _labels;
@override@JsonKey(name: 'lb') List<String> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override@JsonKey(name: 'ec') final  int? entityCategoryId;
@override@JsonKey(name: 'en') final  String? name;
@override@JsonKey(name: 'ic') final  String? icon;
@override@JsonKey(name: 'pl') final  String? platform;
@override@JsonKey(name: 'tk') final  String? translationKey;
@override@JsonKey(name: 'hb') final  bool? hidden;
@override@JsonKey(name: 'dp') final  int? displayPrecision;
@override@JsonKey(name: 'hn') final  bool? hasEntityName;

/// Create a copy of EntityRegistryDisplayEntryResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntityRegistryDisplayEntryResponseEntityCopyWith<_EntityRegistryDisplayEntryResponseEntity> get copyWith => __$EntityRegistryDisplayEntryResponseEntityCopyWithImpl<_EntityRegistryDisplayEntryResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntityRegistryDisplayEntryResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntityRegistryDisplayEntryResponseEntity&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&const DeepCollectionEquality().equals(other._labels, _labels)&&(identical(other.entityCategoryId, entityCategoryId) || other.entityCategoryId == entityCategoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.translationKey, translationKey) || other.translationKey == translationKey)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.displayPrecision, displayPrecision) || other.displayPrecision == displayPrecision)&&(identical(other.hasEntityName, hasEntityName) || other.hasEntityName == hasEntityName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entityId,deviceId,areaId,const DeepCollectionEquality().hash(_labels),entityCategoryId,name,icon,platform,translationKey,hidden,displayPrecision,hasEntityName);

@override
String toString() {
  return 'EntityRegistryDisplayEntryResponseEntity(entityId: $entityId, deviceId: $deviceId, areaId: $areaId, labels: $labels, entityCategoryId: $entityCategoryId, name: $name, icon: $icon, platform: $platform, translationKey: $translationKey, hidden: $hidden, displayPrecision: $displayPrecision, hasEntityName: $hasEntityName)';
}


}

/// @nodoc
abstract mixin class _$EntityRegistryDisplayEntryResponseEntityCopyWith<$Res> implements $EntityRegistryDisplayEntryResponseEntityCopyWith<$Res> {
  factory _$EntityRegistryDisplayEntryResponseEntityCopyWith(_EntityRegistryDisplayEntryResponseEntity value, $Res Function(_EntityRegistryDisplayEntryResponseEntity) _then) = __$EntityRegistryDisplayEntryResponseEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'ei') String entityId,@JsonKey(name: 'di') String? deviceId,@JsonKey(name: 'ai') String? areaId,@JsonKey(name: 'lb') List<String> labels,@JsonKey(name: 'ec') int? entityCategoryId,@JsonKey(name: 'en') String? name,@JsonKey(name: 'ic') String? icon,@JsonKey(name: 'pl') String? platform,@JsonKey(name: 'tk') String? translationKey,@JsonKey(name: 'hb') bool? hidden,@JsonKey(name: 'dp') int? displayPrecision,@JsonKey(name: 'hn') bool? hasEntityName
});




}
/// @nodoc
class __$EntityRegistryDisplayEntryResponseEntityCopyWithImpl<$Res>
    implements _$EntityRegistryDisplayEntryResponseEntityCopyWith<$Res> {
  __$EntityRegistryDisplayEntryResponseEntityCopyWithImpl(this._self, this._then);

  final _EntityRegistryDisplayEntryResponseEntity _self;
  final $Res Function(_EntityRegistryDisplayEntryResponseEntity) _then;

/// Create a copy of EntityRegistryDisplayEntryResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entityId = null,Object? deviceId = freezed,Object? areaId = freezed,Object? labels = null,Object? entityCategoryId = freezed,Object? name = freezed,Object? icon = freezed,Object? platform = freezed,Object? translationKey = freezed,Object? hidden = freezed,Object? displayPrecision = freezed,Object? hasEntityName = freezed,}) {
  return _then(_EntityRegistryDisplayEntryResponseEntity(
entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,areaId: freezed == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,entityCategoryId: freezed == entityCategoryId ? _self.entityCategoryId : entityCategoryId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,translationKey: freezed == translationKey ? _self.translationKey : translationKey // ignore: cast_nullable_to_non_nullable
as String?,hidden: freezed == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool?,displayPrecision: freezed == displayPrecision ? _self.displayPrecision : displayPrecision // ignore: cast_nullable_to_non_nullable
as int?,hasEntityName: freezed == hasEntityName ? _self.hasEntityName : hasEntityName // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$EntityRegistryDisplayEntryResponse {

 List<EntityRegistryDisplayEntryResponseEntity> get entities;@JsonKey(name: 'entity_categories', fromJson: _entityCategoriesFromJson, toJson: _entityCategoriesToJson) Map<int, EntityCategory> get entityCategories;
/// Create a copy of EntityRegistryDisplayEntryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntityRegistryDisplayEntryResponseCopyWith<EntityRegistryDisplayEntryResponse> get copyWith => _$EntityRegistryDisplayEntryResponseCopyWithImpl<EntityRegistryDisplayEntryResponse>(this as EntityRegistryDisplayEntryResponse, _$identity);

  /// Serializes this EntityRegistryDisplayEntryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntityRegistryDisplayEntryResponse&&const DeepCollectionEquality().equals(other.entities, entities)&&const DeepCollectionEquality().equals(other.entityCategories, entityCategories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entities),const DeepCollectionEquality().hash(entityCategories));

@override
String toString() {
  return 'EntityRegistryDisplayEntryResponse(entities: $entities, entityCategories: $entityCategories)';
}


}

/// @nodoc
abstract mixin class $EntityRegistryDisplayEntryResponseCopyWith<$Res>  {
  factory $EntityRegistryDisplayEntryResponseCopyWith(EntityRegistryDisplayEntryResponse value, $Res Function(EntityRegistryDisplayEntryResponse) _then) = _$EntityRegistryDisplayEntryResponseCopyWithImpl;
@useResult
$Res call({
 List<EntityRegistryDisplayEntryResponseEntity> entities,@JsonKey(name: 'entity_categories', fromJson: _entityCategoriesFromJson, toJson: _entityCategoriesToJson) Map<int, EntityCategory> entityCategories
});




}
/// @nodoc
class _$EntityRegistryDisplayEntryResponseCopyWithImpl<$Res>
    implements $EntityRegistryDisplayEntryResponseCopyWith<$Res> {
  _$EntityRegistryDisplayEntryResponseCopyWithImpl(this._self, this._then);

  final EntityRegistryDisplayEntryResponse _self;
  final $Res Function(EntityRegistryDisplayEntryResponse) _then;

/// Create a copy of EntityRegistryDisplayEntryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entities = null,Object? entityCategories = null,}) {
  return _then(_self.copyWith(
entities: null == entities ? _self.entities : entities // ignore: cast_nullable_to_non_nullable
as List<EntityRegistryDisplayEntryResponseEntity>,entityCategories: null == entityCategories ? _self.entityCategories : entityCategories // ignore: cast_nullable_to_non_nullable
as Map<int, EntityCategory>,
  ));
}

}


/// Adds pattern-matching-related methods to [EntityRegistryDisplayEntryResponse].
extension EntityRegistryDisplayEntryResponsePatterns on EntityRegistryDisplayEntryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntityRegistryDisplayEntryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntityRegistryDisplayEntryResponse value)  $default,){
final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntityRegistryDisplayEntryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EntityRegistryDisplayEntryResponseEntity> entities, @JsonKey(name: 'entity_categories', fromJson: _entityCategoriesFromJson, toJson: _entityCategoriesToJson)  Map<int, EntityCategory> entityCategories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntryResponse() when $default != null:
return $default(_that.entities,_that.entityCategories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EntityRegistryDisplayEntryResponseEntity> entities, @JsonKey(name: 'entity_categories', fromJson: _entityCategoriesFromJson, toJson: _entityCategoriesToJson)  Map<int, EntityCategory> entityCategories)  $default,) {final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntryResponse():
return $default(_that.entities,_that.entityCategories);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EntityRegistryDisplayEntryResponseEntity> entities, @JsonKey(name: 'entity_categories', fromJson: _entityCategoriesFromJson, toJson: _entityCategoriesToJson)  Map<int, EntityCategory> entityCategories)?  $default,) {final _that = this;
switch (_that) {
case _EntityRegistryDisplayEntryResponse() when $default != null:
return $default(_that.entities,_that.entityCategories);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _EntityRegistryDisplayEntryResponse implements EntityRegistryDisplayEntryResponse {
  const _EntityRegistryDisplayEntryResponse({required final  List<EntityRegistryDisplayEntryResponseEntity> entities, @JsonKey(name: 'entity_categories', fromJson: _entityCategoriesFromJson, toJson: _entityCategoriesToJson) required final  Map<int, EntityCategory> entityCategories}): _entities = entities,_entityCategories = entityCategories;
  factory _EntityRegistryDisplayEntryResponse.fromJson(Map<String, dynamic> json) => _$EntityRegistryDisplayEntryResponseFromJson(json);

 final  List<EntityRegistryDisplayEntryResponseEntity> _entities;
@override List<EntityRegistryDisplayEntryResponseEntity> get entities {
  if (_entities is EqualUnmodifiableListView) return _entities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entities);
}

 final  Map<int, EntityCategory> _entityCategories;
@override@JsonKey(name: 'entity_categories', fromJson: _entityCategoriesFromJson, toJson: _entityCategoriesToJson) Map<int, EntityCategory> get entityCategories {
  if (_entityCategories is EqualUnmodifiableMapView) return _entityCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_entityCategories);
}


/// Create a copy of EntityRegistryDisplayEntryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntityRegistryDisplayEntryResponseCopyWith<_EntityRegistryDisplayEntryResponse> get copyWith => __$EntityRegistryDisplayEntryResponseCopyWithImpl<_EntityRegistryDisplayEntryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntityRegistryDisplayEntryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntityRegistryDisplayEntryResponse&&const DeepCollectionEquality().equals(other._entities, _entities)&&const DeepCollectionEquality().equals(other._entityCategories, _entityCategories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_entities),const DeepCollectionEquality().hash(_entityCategories));

@override
String toString() {
  return 'EntityRegistryDisplayEntryResponse(entities: $entities, entityCategories: $entityCategories)';
}


}

/// @nodoc
abstract mixin class _$EntityRegistryDisplayEntryResponseCopyWith<$Res> implements $EntityRegistryDisplayEntryResponseCopyWith<$Res> {
  factory _$EntityRegistryDisplayEntryResponseCopyWith(_EntityRegistryDisplayEntryResponse value, $Res Function(_EntityRegistryDisplayEntryResponse) _then) = __$EntityRegistryDisplayEntryResponseCopyWithImpl;
@override @useResult
$Res call({
 List<EntityRegistryDisplayEntryResponseEntity> entities,@JsonKey(name: 'entity_categories', fromJson: _entityCategoriesFromJson, toJson: _entityCategoriesToJson) Map<int, EntityCategory> entityCategories
});




}
/// @nodoc
class __$EntityRegistryDisplayEntryResponseCopyWithImpl<$Res>
    implements _$EntityRegistryDisplayEntryResponseCopyWith<$Res> {
  __$EntityRegistryDisplayEntryResponseCopyWithImpl(this._self, this._then);

  final _EntityRegistryDisplayEntryResponse _self;
  final $Res Function(_EntityRegistryDisplayEntryResponse) _then;

/// Create a copy of EntityRegistryDisplayEntryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entities = null,Object? entityCategories = null,}) {
  return _then(_EntityRegistryDisplayEntryResponse(
entities: null == entities ? _self._entities : entities // ignore: cast_nullable_to_non_nullable
as List<EntityRegistryDisplayEntryResponseEntity>,entityCategories: null == entityCategories ? _self._entityCategories : entityCategories // ignore: cast_nullable_to_non_nullable
as Map<int, EntityCategory>,
  ));
}


}

// dart format on
