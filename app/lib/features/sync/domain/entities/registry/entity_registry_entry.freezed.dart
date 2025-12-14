// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entity_registry_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EntityRegistryEntry {

 double get createdAt; double get modifiedAt; String get id; String get entityId; String? get name; String? get icon; String get platform; String? get configEntryId; String? get configSubentryId; String? get deviceId; String? get areaId; List<String> get labels; EntityRegistryDisabledBy? get disabledBy; EntityRegistryHiddenBy? get hiddenBy; EntityCategory? get entityCategory; bool get hasEntityName; String? get originalName; String get uniqueId; String? get translationKey; EntityRegistryOptions? get options; Map<String, String> get categories;
/// Create a copy of EntityRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntityRegistryEntryCopyWith<EntityRegistryEntry> get copyWith => _$EntityRegistryEntryCopyWithImpl<EntityRegistryEntry>(this as EntityRegistryEntry, _$identity);

  /// Serializes this EntityRegistryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntityRegistryEntry&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.configEntryId, configEntryId) || other.configEntryId == configEntryId)&&(identical(other.configSubentryId, configSubentryId) || other.configSubentryId == configSubentryId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&const DeepCollectionEquality().equals(other.labels, labels)&&(identical(other.disabledBy, disabledBy) || other.disabledBy == disabledBy)&&(identical(other.hiddenBy, hiddenBy) || other.hiddenBy == hiddenBy)&&(identical(other.entityCategory, entityCategory) || other.entityCategory == entityCategory)&&(identical(other.hasEntityName, hasEntityName) || other.hasEntityName == hasEntityName)&&(identical(other.originalName, originalName) || other.originalName == originalName)&&(identical(other.uniqueId, uniqueId) || other.uniqueId == uniqueId)&&(identical(other.translationKey, translationKey) || other.translationKey == translationKey)&&(identical(other.options, options) || other.options == options)&&const DeepCollectionEquality().equals(other.categories, categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,createdAt,modifiedAt,id,entityId,name,icon,platform,configEntryId,configSubentryId,deviceId,areaId,const DeepCollectionEquality().hash(labels),disabledBy,hiddenBy,entityCategory,hasEntityName,originalName,uniqueId,translationKey,options,const DeepCollectionEquality().hash(categories)]);

@override
String toString() {
  return 'EntityRegistryEntry(createdAt: $createdAt, modifiedAt: $modifiedAt, id: $id, entityId: $entityId, name: $name, icon: $icon, platform: $platform, configEntryId: $configEntryId, configSubentryId: $configSubentryId, deviceId: $deviceId, areaId: $areaId, labels: $labels, disabledBy: $disabledBy, hiddenBy: $hiddenBy, entityCategory: $entityCategory, hasEntityName: $hasEntityName, originalName: $originalName, uniqueId: $uniqueId, translationKey: $translationKey, options: $options, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $EntityRegistryEntryCopyWith<$Res>  {
  factory $EntityRegistryEntryCopyWith(EntityRegistryEntry value, $Res Function(EntityRegistryEntry) _then) = _$EntityRegistryEntryCopyWithImpl;
@useResult
$Res call({
 double createdAt, double modifiedAt, String id, String entityId, String? name, String? icon, String platform, String? configEntryId, String? configSubentryId, String? deviceId, String? areaId, List<String> labels, EntityRegistryDisabledBy? disabledBy, EntityRegistryHiddenBy? hiddenBy, EntityCategory? entityCategory, bool hasEntityName, String? originalName, String uniqueId, String? translationKey, EntityRegistryOptions? options, Map<String, String> categories
});


$EntityRegistryOptionsCopyWith<$Res>? get options;

}
/// @nodoc
class _$EntityRegistryEntryCopyWithImpl<$Res>
    implements $EntityRegistryEntryCopyWith<$Res> {
  _$EntityRegistryEntryCopyWithImpl(this._self, this._then);

  final EntityRegistryEntry _self;
  final $Res Function(EntityRegistryEntry) _then;

/// Create a copy of EntityRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? createdAt = null,Object? modifiedAt = null,Object? id = null,Object? entityId = null,Object? name = freezed,Object? icon = freezed,Object? platform = null,Object? configEntryId = freezed,Object? configSubentryId = freezed,Object? deviceId = freezed,Object? areaId = freezed,Object? labels = null,Object? disabledBy = freezed,Object? hiddenBy = freezed,Object? entityCategory = freezed,Object? hasEntityName = null,Object? originalName = freezed,Object? uniqueId = null,Object? translationKey = freezed,Object? options = freezed,Object? categories = null,}) {
  return _then(_self.copyWith(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as double,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as double,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,configEntryId: freezed == configEntryId ? _self.configEntryId : configEntryId // ignore: cast_nullable_to_non_nullable
as String?,configSubentryId: freezed == configSubentryId ? _self.configSubentryId : configSubentryId // ignore: cast_nullable_to_non_nullable
as String?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,areaId: freezed == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,disabledBy: freezed == disabledBy ? _self.disabledBy : disabledBy // ignore: cast_nullable_to_non_nullable
as EntityRegistryDisabledBy?,hiddenBy: freezed == hiddenBy ? _self.hiddenBy : hiddenBy // ignore: cast_nullable_to_non_nullable
as EntityRegistryHiddenBy?,entityCategory: freezed == entityCategory ? _self.entityCategory : entityCategory // ignore: cast_nullable_to_non_nullable
as EntityCategory?,hasEntityName: null == hasEntityName ? _self.hasEntityName : hasEntityName // ignore: cast_nullable_to_non_nullable
as bool,originalName: freezed == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String?,uniqueId: null == uniqueId ? _self.uniqueId : uniqueId // ignore: cast_nullable_to_non_nullable
as String,translationKey: freezed == translationKey ? _self.translationKey : translationKey // ignore: cast_nullable_to_non_nullable
as String?,options: freezed == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as EntityRegistryOptions?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}
/// Create a copy of EntityRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntityRegistryOptionsCopyWith<$Res>? get options {
    if (_self.options == null) {
    return null;
  }

  return $EntityRegistryOptionsCopyWith<$Res>(_self.options!, (value) {
    return _then(_self.copyWith(options: value));
  });
}
}


/// Adds pattern-matching-related methods to [EntityRegistryEntry].
extension EntityRegistryEntryPatterns on EntityRegistryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntityRegistryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntityRegistryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntityRegistryEntry value)  $default,){
final _that = this;
switch (_that) {
case _EntityRegistryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntityRegistryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _EntityRegistryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double createdAt,  double modifiedAt,  String id,  String entityId,  String? name,  String? icon,  String platform,  String? configEntryId,  String? configSubentryId,  String? deviceId,  String? areaId,  List<String> labels,  EntityRegistryDisabledBy? disabledBy,  EntityRegistryHiddenBy? hiddenBy,  EntityCategory? entityCategory,  bool hasEntityName,  String? originalName,  String uniqueId,  String? translationKey,  EntityRegistryOptions? options,  Map<String, String> categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntityRegistryEntry() when $default != null:
return $default(_that.createdAt,_that.modifiedAt,_that.id,_that.entityId,_that.name,_that.icon,_that.platform,_that.configEntryId,_that.configSubentryId,_that.deviceId,_that.areaId,_that.labels,_that.disabledBy,_that.hiddenBy,_that.entityCategory,_that.hasEntityName,_that.originalName,_that.uniqueId,_that.translationKey,_that.options,_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double createdAt,  double modifiedAt,  String id,  String entityId,  String? name,  String? icon,  String platform,  String? configEntryId,  String? configSubentryId,  String? deviceId,  String? areaId,  List<String> labels,  EntityRegistryDisabledBy? disabledBy,  EntityRegistryHiddenBy? hiddenBy,  EntityCategory? entityCategory,  bool hasEntityName,  String? originalName,  String uniqueId,  String? translationKey,  EntityRegistryOptions? options,  Map<String, String> categories)  $default,) {final _that = this;
switch (_that) {
case _EntityRegistryEntry():
return $default(_that.createdAt,_that.modifiedAt,_that.id,_that.entityId,_that.name,_that.icon,_that.platform,_that.configEntryId,_that.configSubentryId,_that.deviceId,_that.areaId,_that.labels,_that.disabledBy,_that.hiddenBy,_that.entityCategory,_that.hasEntityName,_that.originalName,_that.uniqueId,_that.translationKey,_that.options,_that.categories);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double createdAt,  double modifiedAt,  String id,  String entityId,  String? name,  String? icon,  String platform,  String? configEntryId,  String? configSubentryId,  String? deviceId,  String? areaId,  List<String> labels,  EntityRegistryDisabledBy? disabledBy,  EntityRegistryHiddenBy? hiddenBy,  EntityCategory? entityCategory,  bool hasEntityName,  String? originalName,  String uniqueId,  String? translationKey,  EntityRegistryOptions? options,  Map<String, String> categories)?  $default,) {final _that = this;
switch (_that) {
case _EntityRegistryEntry() when $default != null:
return $default(_that.createdAt,_that.modifiedAt,_that.id,_that.entityId,_that.name,_that.icon,_that.platform,_that.configEntryId,_that.configSubentryId,_that.deviceId,_that.areaId,_that.labels,_that.disabledBy,_that.hiddenBy,_that.entityCategory,_that.hasEntityName,_that.originalName,_that.uniqueId,_that.translationKey,_that.options,_that.categories);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _EntityRegistryEntry implements EntityRegistryEntry, RegistryEntry {
  const _EntityRegistryEntry({required this.createdAt, required this.modifiedAt, required this.id, required this.entityId, this.name, this.icon, required this.platform, this.configEntryId, this.configSubentryId, this.deviceId, this.areaId, required final  List<String> labels, this.disabledBy, this.hiddenBy, this.entityCategory, required this.hasEntityName, this.originalName, required this.uniqueId, this.translationKey, this.options, required final  Map<String, String> categories}): _labels = labels,_categories = categories;
  factory _EntityRegistryEntry.fromJson(Map<String, dynamic> json) => _$EntityRegistryEntryFromJson(json);

@override final  double createdAt;
@override final  double modifiedAt;
@override final  String id;
@override final  String entityId;
@override final  String? name;
@override final  String? icon;
@override final  String platform;
@override final  String? configEntryId;
@override final  String? configSubentryId;
@override final  String? deviceId;
@override final  String? areaId;
 final  List<String> _labels;
@override List<String> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override final  EntityRegistryDisabledBy? disabledBy;
@override final  EntityRegistryHiddenBy? hiddenBy;
@override final  EntityCategory? entityCategory;
@override final  bool hasEntityName;
@override final  String? originalName;
@override final  String uniqueId;
@override final  String? translationKey;
@override final  EntityRegistryOptions? options;
 final  Map<String, String> _categories;
@override Map<String, String> get categories {
  if (_categories is EqualUnmodifiableMapView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_categories);
}


/// Create a copy of EntityRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntityRegistryEntryCopyWith<_EntityRegistryEntry> get copyWith => __$EntityRegistryEntryCopyWithImpl<_EntityRegistryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntityRegistryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntityRegistryEntry&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.configEntryId, configEntryId) || other.configEntryId == configEntryId)&&(identical(other.configSubentryId, configSubentryId) || other.configSubentryId == configSubentryId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&const DeepCollectionEquality().equals(other._labels, _labels)&&(identical(other.disabledBy, disabledBy) || other.disabledBy == disabledBy)&&(identical(other.hiddenBy, hiddenBy) || other.hiddenBy == hiddenBy)&&(identical(other.entityCategory, entityCategory) || other.entityCategory == entityCategory)&&(identical(other.hasEntityName, hasEntityName) || other.hasEntityName == hasEntityName)&&(identical(other.originalName, originalName) || other.originalName == originalName)&&(identical(other.uniqueId, uniqueId) || other.uniqueId == uniqueId)&&(identical(other.translationKey, translationKey) || other.translationKey == translationKey)&&(identical(other.options, options) || other.options == options)&&const DeepCollectionEquality().equals(other._categories, _categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,createdAt,modifiedAt,id,entityId,name,icon,platform,configEntryId,configSubentryId,deviceId,areaId,const DeepCollectionEquality().hash(_labels),disabledBy,hiddenBy,entityCategory,hasEntityName,originalName,uniqueId,translationKey,options,const DeepCollectionEquality().hash(_categories)]);

@override
String toString() {
  return 'EntityRegistryEntry(createdAt: $createdAt, modifiedAt: $modifiedAt, id: $id, entityId: $entityId, name: $name, icon: $icon, platform: $platform, configEntryId: $configEntryId, configSubentryId: $configSubentryId, deviceId: $deviceId, areaId: $areaId, labels: $labels, disabledBy: $disabledBy, hiddenBy: $hiddenBy, entityCategory: $entityCategory, hasEntityName: $hasEntityName, originalName: $originalName, uniqueId: $uniqueId, translationKey: $translationKey, options: $options, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$EntityRegistryEntryCopyWith<$Res> implements $EntityRegistryEntryCopyWith<$Res> {
  factory _$EntityRegistryEntryCopyWith(_EntityRegistryEntry value, $Res Function(_EntityRegistryEntry) _then) = __$EntityRegistryEntryCopyWithImpl;
@override @useResult
$Res call({
 double createdAt, double modifiedAt, String id, String entityId, String? name, String? icon, String platform, String? configEntryId, String? configSubentryId, String? deviceId, String? areaId, List<String> labels, EntityRegistryDisabledBy? disabledBy, EntityRegistryHiddenBy? hiddenBy, EntityCategory? entityCategory, bool hasEntityName, String? originalName, String uniqueId, String? translationKey, EntityRegistryOptions? options, Map<String, String> categories
});


@override $EntityRegistryOptionsCopyWith<$Res>? get options;

}
/// @nodoc
class __$EntityRegistryEntryCopyWithImpl<$Res>
    implements _$EntityRegistryEntryCopyWith<$Res> {
  __$EntityRegistryEntryCopyWithImpl(this._self, this._then);

  final _EntityRegistryEntry _self;
  final $Res Function(_EntityRegistryEntry) _then;

/// Create a copy of EntityRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? createdAt = null,Object? modifiedAt = null,Object? id = null,Object? entityId = null,Object? name = freezed,Object? icon = freezed,Object? platform = null,Object? configEntryId = freezed,Object? configSubentryId = freezed,Object? deviceId = freezed,Object? areaId = freezed,Object? labels = null,Object? disabledBy = freezed,Object? hiddenBy = freezed,Object? entityCategory = freezed,Object? hasEntityName = null,Object? originalName = freezed,Object? uniqueId = null,Object? translationKey = freezed,Object? options = freezed,Object? categories = null,}) {
  return _then(_EntityRegistryEntry(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as double,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as double,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,configEntryId: freezed == configEntryId ? _self.configEntryId : configEntryId // ignore: cast_nullable_to_non_nullable
as String?,configSubentryId: freezed == configSubentryId ? _self.configSubentryId : configSubentryId // ignore: cast_nullable_to_non_nullable
as String?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,areaId: freezed == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,disabledBy: freezed == disabledBy ? _self.disabledBy : disabledBy // ignore: cast_nullable_to_non_nullable
as EntityRegistryDisabledBy?,hiddenBy: freezed == hiddenBy ? _self.hiddenBy : hiddenBy // ignore: cast_nullable_to_non_nullable
as EntityRegistryHiddenBy?,entityCategory: freezed == entityCategory ? _self.entityCategory : entityCategory // ignore: cast_nullable_to_non_nullable
as EntityCategory?,hasEntityName: null == hasEntityName ? _self.hasEntityName : hasEntityName // ignore: cast_nullable_to_non_nullable
as bool,originalName: freezed == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String?,uniqueId: null == uniqueId ? _self.uniqueId : uniqueId // ignore: cast_nullable_to_non_nullable
as String,translationKey: freezed == translationKey ? _self.translationKey : translationKey // ignore: cast_nullable_to_non_nullable
as String?,options: freezed == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as EntityRegistryOptions?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

/// Create a copy of EntityRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntityRegistryOptionsCopyWith<$Res>? get options {
    if (_self.options == null) {
    return null;
  }

  return $EntityRegistryOptionsCopyWith<$Res>(_self.options!, (value) {
    return _then(_self.copyWith(options: value));
  });
}
}

// dart format on
