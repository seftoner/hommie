// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_registry_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceRegistryEntry {

 double get createdAt; double get modifiedAt; String get id; List<String> get configEntries; Map<String, List<String?>> get configEntriesSubentries; List<List<String>> get connections; List<List<String>> get identifiers; String? get manufacturer; String? get model; String? get modelId; String? get name; List<String> get labels; String? get swVersion; String? get hwVersion; String? get serialNumber; String? get viaDeviceId; String? get areaId; String? get nameByUser; DeviceRegistryEntryType? get entryType; DeviceRegistryDisabledBy? get disabledBy; String? get configurationUrl; String? get primaryConfigEntry;
/// Create a copy of DeviceRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceRegistryEntryCopyWith<DeviceRegistryEntry> get copyWith => _$DeviceRegistryEntryCopyWithImpl<DeviceRegistryEntry>(this as DeviceRegistryEntry, _$identity);

  /// Serializes this DeviceRegistryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceRegistryEntry&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.configEntries, configEntries)&&const DeepCollectionEquality().equals(other.configEntriesSubentries, configEntriesSubentries)&&const DeepCollectionEquality().equals(other.connections, connections)&&const DeepCollectionEquality().equals(other.identifiers, identifiers)&&(identical(other.manufacturer, manufacturer) || other.manufacturer == manufacturer)&&(identical(other.model, model) || other.model == model)&&(identical(other.modelId, modelId) || other.modelId == modelId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.labels, labels)&&(identical(other.swVersion, swVersion) || other.swVersion == swVersion)&&(identical(other.hwVersion, hwVersion) || other.hwVersion == hwVersion)&&(identical(other.serialNumber, serialNumber) || other.serialNumber == serialNumber)&&(identical(other.viaDeviceId, viaDeviceId) || other.viaDeviceId == viaDeviceId)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.nameByUser, nameByUser) || other.nameByUser == nameByUser)&&(identical(other.entryType, entryType) || other.entryType == entryType)&&(identical(other.disabledBy, disabledBy) || other.disabledBy == disabledBy)&&(identical(other.configurationUrl, configurationUrl) || other.configurationUrl == configurationUrl)&&(identical(other.primaryConfigEntry, primaryConfigEntry) || other.primaryConfigEntry == primaryConfigEntry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,createdAt,modifiedAt,id,const DeepCollectionEquality().hash(configEntries),const DeepCollectionEquality().hash(configEntriesSubentries),const DeepCollectionEquality().hash(connections),const DeepCollectionEquality().hash(identifiers),manufacturer,model,modelId,name,const DeepCollectionEquality().hash(labels),swVersion,hwVersion,serialNumber,viaDeviceId,areaId,nameByUser,entryType,disabledBy,configurationUrl,primaryConfigEntry]);

@override
String toString() {
  return 'DeviceRegistryEntry(createdAt: $createdAt, modifiedAt: $modifiedAt, id: $id, configEntries: $configEntries, configEntriesSubentries: $configEntriesSubentries, connections: $connections, identifiers: $identifiers, manufacturer: $manufacturer, model: $model, modelId: $modelId, name: $name, labels: $labels, swVersion: $swVersion, hwVersion: $hwVersion, serialNumber: $serialNumber, viaDeviceId: $viaDeviceId, areaId: $areaId, nameByUser: $nameByUser, entryType: $entryType, disabledBy: $disabledBy, configurationUrl: $configurationUrl, primaryConfigEntry: $primaryConfigEntry)';
}


}

/// @nodoc
abstract mixin class $DeviceRegistryEntryCopyWith<$Res>  {
  factory $DeviceRegistryEntryCopyWith(DeviceRegistryEntry value, $Res Function(DeviceRegistryEntry) _then) = _$DeviceRegistryEntryCopyWithImpl;
@useResult
$Res call({
 double createdAt, double modifiedAt, String id, List<String> configEntries, Map<String, List<String?>> configEntriesSubentries, List<List<String>> connections, List<List<String>> identifiers, String? manufacturer, String? model, String? modelId, String? name, List<String> labels, String? swVersion, String? hwVersion, String? serialNumber, String? viaDeviceId, String? areaId, String? nameByUser, DeviceRegistryEntryType? entryType, DeviceRegistryDisabledBy? disabledBy, String? configurationUrl, String? primaryConfigEntry
});




}
/// @nodoc
class _$DeviceRegistryEntryCopyWithImpl<$Res>
    implements $DeviceRegistryEntryCopyWith<$Res> {
  _$DeviceRegistryEntryCopyWithImpl(this._self, this._then);

  final DeviceRegistryEntry _self;
  final $Res Function(DeviceRegistryEntry) _then;

/// Create a copy of DeviceRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? createdAt = null,Object? modifiedAt = null,Object? id = null,Object? configEntries = null,Object? configEntriesSubentries = null,Object? connections = null,Object? identifiers = null,Object? manufacturer = freezed,Object? model = freezed,Object? modelId = freezed,Object? name = freezed,Object? labels = null,Object? swVersion = freezed,Object? hwVersion = freezed,Object? serialNumber = freezed,Object? viaDeviceId = freezed,Object? areaId = freezed,Object? nameByUser = freezed,Object? entryType = freezed,Object? disabledBy = freezed,Object? configurationUrl = freezed,Object? primaryConfigEntry = freezed,}) {
  return _then(_self.copyWith(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as double,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as double,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,configEntries: null == configEntries ? _self.configEntries : configEntries // ignore: cast_nullable_to_non_nullable
as List<String>,configEntriesSubentries: null == configEntriesSubentries ? _self.configEntriesSubentries : configEntriesSubentries // ignore: cast_nullable_to_non_nullable
as Map<String, List<String?>>,connections: null == connections ? _self.connections : connections // ignore: cast_nullable_to_non_nullable
as List<List<String>>,identifiers: null == identifiers ? _self.identifiers : identifiers // ignore: cast_nullable_to_non_nullable
as List<List<String>>,manufacturer: freezed == manufacturer ? _self.manufacturer : manufacturer // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,modelId: freezed == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,swVersion: freezed == swVersion ? _self.swVersion : swVersion // ignore: cast_nullable_to_non_nullable
as String?,hwVersion: freezed == hwVersion ? _self.hwVersion : hwVersion // ignore: cast_nullable_to_non_nullable
as String?,serialNumber: freezed == serialNumber ? _self.serialNumber : serialNumber // ignore: cast_nullable_to_non_nullable
as String?,viaDeviceId: freezed == viaDeviceId ? _self.viaDeviceId : viaDeviceId // ignore: cast_nullable_to_non_nullable
as String?,areaId: freezed == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as String?,nameByUser: freezed == nameByUser ? _self.nameByUser : nameByUser // ignore: cast_nullable_to_non_nullable
as String?,entryType: freezed == entryType ? _self.entryType : entryType // ignore: cast_nullable_to_non_nullable
as DeviceRegistryEntryType?,disabledBy: freezed == disabledBy ? _self.disabledBy : disabledBy // ignore: cast_nullable_to_non_nullable
as DeviceRegistryDisabledBy?,configurationUrl: freezed == configurationUrl ? _self.configurationUrl : configurationUrl // ignore: cast_nullable_to_non_nullable
as String?,primaryConfigEntry: freezed == primaryConfigEntry ? _self.primaryConfigEntry : primaryConfigEntry // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceRegistryEntry].
extension DeviceRegistryEntryPatterns on DeviceRegistryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceRegistryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceRegistryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceRegistryEntry value)  $default,){
final _that = this;
switch (_that) {
case _DeviceRegistryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceRegistryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceRegistryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double createdAt,  double modifiedAt,  String id,  List<String> configEntries,  Map<String, List<String?>> configEntriesSubentries,  List<List<String>> connections,  List<List<String>> identifiers,  String? manufacturer,  String? model,  String? modelId,  String? name,  List<String> labels,  String? swVersion,  String? hwVersion,  String? serialNumber,  String? viaDeviceId,  String? areaId,  String? nameByUser,  DeviceRegistryEntryType? entryType,  DeviceRegistryDisabledBy? disabledBy,  String? configurationUrl,  String? primaryConfigEntry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceRegistryEntry() when $default != null:
return $default(_that.createdAt,_that.modifiedAt,_that.id,_that.configEntries,_that.configEntriesSubentries,_that.connections,_that.identifiers,_that.manufacturer,_that.model,_that.modelId,_that.name,_that.labels,_that.swVersion,_that.hwVersion,_that.serialNumber,_that.viaDeviceId,_that.areaId,_that.nameByUser,_that.entryType,_that.disabledBy,_that.configurationUrl,_that.primaryConfigEntry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double createdAt,  double modifiedAt,  String id,  List<String> configEntries,  Map<String, List<String?>> configEntriesSubentries,  List<List<String>> connections,  List<List<String>> identifiers,  String? manufacturer,  String? model,  String? modelId,  String? name,  List<String> labels,  String? swVersion,  String? hwVersion,  String? serialNumber,  String? viaDeviceId,  String? areaId,  String? nameByUser,  DeviceRegistryEntryType? entryType,  DeviceRegistryDisabledBy? disabledBy,  String? configurationUrl,  String? primaryConfigEntry)  $default,) {final _that = this;
switch (_that) {
case _DeviceRegistryEntry():
return $default(_that.createdAt,_that.modifiedAt,_that.id,_that.configEntries,_that.configEntriesSubentries,_that.connections,_that.identifiers,_that.manufacturer,_that.model,_that.modelId,_that.name,_that.labels,_that.swVersion,_that.hwVersion,_that.serialNumber,_that.viaDeviceId,_that.areaId,_that.nameByUser,_that.entryType,_that.disabledBy,_that.configurationUrl,_that.primaryConfigEntry);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double createdAt,  double modifiedAt,  String id,  List<String> configEntries,  Map<String, List<String?>> configEntriesSubentries,  List<List<String>> connections,  List<List<String>> identifiers,  String? manufacturer,  String? model,  String? modelId,  String? name,  List<String> labels,  String? swVersion,  String? hwVersion,  String? serialNumber,  String? viaDeviceId,  String? areaId,  String? nameByUser,  DeviceRegistryEntryType? entryType,  DeviceRegistryDisabledBy? disabledBy,  String? configurationUrl,  String? primaryConfigEntry)?  $default,) {final _that = this;
switch (_that) {
case _DeviceRegistryEntry() when $default != null:
return $default(_that.createdAt,_that.modifiedAt,_that.id,_that.configEntries,_that.configEntriesSubentries,_that.connections,_that.identifiers,_that.manufacturer,_that.model,_that.modelId,_that.name,_that.labels,_that.swVersion,_that.hwVersion,_that.serialNumber,_that.viaDeviceId,_that.areaId,_that.nameByUser,_that.entryType,_that.disabledBy,_that.configurationUrl,_that.primaryConfigEntry);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DeviceRegistryEntry implements DeviceRegistryEntry, RegistryEntry {
  const _DeviceRegistryEntry({required this.createdAt, required this.modifiedAt, required this.id, required final  List<String> configEntries, required final  Map<String, List<String?>> configEntriesSubentries, required final  List<List<String>> connections, required final  List<List<String>> identifiers, this.manufacturer, this.model, this.modelId, this.name, required final  List<String> labels, this.swVersion, this.hwVersion, this.serialNumber, this.viaDeviceId, this.areaId, this.nameByUser, this.entryType, this.disabledBy, this.configurationUrl, this.primaryConfigEntry}): _configEntries = configEntries,_configEntriesSubentries = configEntriesSubentries,_connections = connections,_identifiers = identifiers,_labels = labels;
  factory _DeviceRegistryEntry.fromJson(Map<String, dynamic> json) => _$DeviceRegistryEntryFromJson(json);

@override final  double createdAt;
@override final  double modifiedAt;
@override final  String id;
 final  List<String> _configEntries;
@override List<String> get configEntries {
  if (_configEntries is EqualUnmodifiableListView) return _configEntries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_configEntries);
}

 final  Map<String, List<String?>> _configEntriesSubentries;
@override Map<String, List<String?>> get configEntriesSubentries {
  if (_configEntriesSubentries is EqualUnmodifiableMapView) return _configEntriesSubentries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_configEntriesSubentries);
}

 final  List<List<String>> _connections;
@override List<List<String>> get connections {
  if (_connections is EqualUnmodifiableListView) return _connections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_connections);
}

 final  List<List<String>> _identifiers;
@override List<List<String>> get identifiers {
  if (_identifiers is EqualUnmodifiableListView) return _identifiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_identifiers);
}

@override final  String? manufacturer;
@override final  String? model;
@override final  String? modelId;
@override final  String? name;
 final  List<String> _labels;
@override List<String> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override final  String? swVersion;
@override final  String? hwVersion;
@override final  String? serialNumber;
@override final  String? viaDeviceId;
@override final  String? areaId;
@override final  String? nameByUser;
@override final  DeviceRegistryEntryType? entryType;
@override final  DeviceRegistryDisabledBy? disabledBy;
@override final  String? configurationUrl;
@override final  String? primaryConfigEntry;

/// Create a copy of DeviceRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceRegistryEntryCopyWith<_DeviceRegistryEntry> get copyWith => __$DeviceRegistryEntryCopyWithImpl<_DeviceRegistryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceRegistryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceRegistryEntry&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._configEntries, _configEntries)&&const DeepCollectionEquality().equals(other._configEntriesSubentries, _configEntriesSubentries)&&const DeepCollectionEquality().equals(other._connections, _connections)&&const DeepCollectionEquality().equals(other._identifiers, _identifiers)&&(identical(other.manufacturer, manufacturer) || other.manufacturer == manufacturer)&&(identical(other.model, model) || other.model == model)&&(identical(other.modelId, modelId) || other.modelId == modelId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._labels, _labels)&&(identical(other.swVersion, swVersion) || other.swVersion == swVersion)&&(identical(other.hwVersion, hwVersion) || other.hwVersion == hwVersion)&&(identical(other.serialNumber, serialNumber) || other.serialNumber == serialNumber)&&(identical(other.viaDeviceId, viaDeviceId) || other.viaDeviceId == viaDeviceId)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.nameByUser, nameByUser) || other.nameByUser == nameByUser)&&(identical(other.entryType, entryType) || other.entryType == entryType)&&(identical(other.disabledBy, disabledBy) || other.disabledBy == disabledBy)&&(identical(other.configurationUrl, configurationUrl) || other.configurationUrl == configurationUrl)&&(identical(other.primaryConfigEntry, primaryConfigEntry) || other.primaryConfigEntry == primaryConfigEntry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,createdAt,modifiedAt,id,const DeepCollectionEquality().hash(_configEntries),const DeepCollectionEquality().hash(_configEntriesSubentries),const DeepCollectionEquality().hash(_connections),const DeepCollectionEquality().hash(_identifiers),manufacturer,model,modelId,name,const DeepCollectionEquality().hash(_labels),swVersion,hwVersion,serialNumber,viaDeviceId,areaId,nameByUser,entryType,disabledBy,configurationUrl,primaryConfigEntry]);

@override
String toString() {
  return 'DeviceRegistryEntry(createdAt: $createdAt, modifiedAt: $modifiedAt, id: $id, configEntries: $configEntries, configEntriesSubentries: $configEntriesSubentries, connections: $connections, identifiers: $identifiers, manufacturer: $manufacturer, model: $model, modelId: $modelId, name: $name, labels: $labels, swVersion: $swVersion, hwVersion: $hwVersion, serialNumber: $serialNumber, viaDeviceId: $viaDeviceId, areaId: $areaId, nameByUser: $nameByUser, entryType: $entryType, disabledBy: $disabledBy, configurationUrl: $configurationUrl, primaryConfigEntry: $primaryConfigEntry)';
}


}

/// @nodoc
abstract mixin class _$DeviceRegistryEntryCopyWith<$Res> implements $DeviceRegistryEntryCopyWith<$Res> {
  factory _$DeviceRegistryEntryCopyWith(_DeviceRegistryEntry value, $Res Function(_DeviceRegistryEntry) _then) = __$DeviceRegistryEntryCopyWithImpl;
@override @useResult
$Res call({
 double createdAt, double modifiedAt, String id, List<String> configEntries, Map<String, List<String?>> configEntriesSubentries, List<List<String>> connections, List<List<String>> identifiers, String? manufacturer, String? model, String? modelId, String? name, List<String> labels, String? swVersion, String? hwVersion, String? serialNumber, String? viaDeviceId, String? areaId, String? nameByUser, DeviceRegistryEntryType? entryType, DeviceRegistryDisabledBy? disabledBy, String? configurationUrl, String? primaryConfigEntry
});




}
/// @nodoc
class __$DeviceRegistryEntryCopyWithImpl<$Res>
    implements _$DeviceRegistryEntryCopyWith<$Res> {
  __$DeviceRegistryEntryCopyWithImpl(this._self, this._then);

  final _DeviceRegistryEntry _self;
  final $Res Function(_DeviceRegistryEntry) _then;

/// Create a copy of DeviceRegistryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? createdAt = null,Object? modifiedAt = null,Object? id = null,Object? configEntries = null,Object? configEntriesSubentries = null,Object? connections = null,Object? identifiers = null,Object? manufacturer = freezed,Object? model = freezed,Object? modelId = freezed,Object? name = freezed,Object? labels = null,Object? swVersion = freezed,Object? hwVersion = freezed,Object? serialNumber = freezed,Object? viaDeviceId = freezed,Object? areaId = freezed,Object? nameByUser = freezed,Object? entryType = freezed,Object? disabledBy = freezed,Object? configurationUrl = freezed,Object? primaryConfigEntry = freezed,}) {
  return _then(_DeviceRegistryEntry(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as double,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as double,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,configEntries: null == configEntries ? _self._configEntries : configEntries // ignore: cast_nullable_to_non_nullable
as List<String>,configEntriesSubentries: null == configEntriesSubentries ? _self._configEntriesSubentries : configEntriesSubentries // ignore: cast_nullable_to_non_nullable
as Map<String, List<String?>>,connections: null == connections ? _self._connections : connections // ignore: cast_nullable_to_non_nullable
as List<List<String>>,identifiers: null == identifiers ? _self._identifiers : identifiers // ignore: cast_nullable_to_non_nullable
as List<List<String>>,manufacturer: freezed == manufacturer ? _self.manufacturer : manufacturer // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,modelId: freezed == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,swVersion: freezed == swVersion ? _self.swVersion : swVersion // ignore: cast_nullable_to_non_nullable
as String?,hwVersion: freezed == hwVersion ? _self.hwVersion : hwVersion // ignore: cast_nullable_to_non_nullable
as String?,serialNumber: freezed == serialNumber ? _self.serialNumber : serialNumber // ignore: cast_nullable_to_non_nullable
as String?,viaDeviceId: freezed == viaDeviceId ? _self.viaDeviceId : viaDeviceId // ignore: cast_nullable_to_non_nullable
as String?,areaId: freezed == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as String?,nameByUser: freezed == nameByUser ? _self.nameByUser : nameByUser // ignore: cast_nullable_to_non_nullable
as String?,entryType: freezed == entryType ? _self.entryType : entryType // ignore: cast_nullable_to_non_nullable
as DeviceRegistryEntryType?,disabledBy: freezed == disabledBy ? _self.disabledBy : disabledBy // ignore: cast_nullable_to_non_nullable
as DeviceRegistryDisabledBy?,configurationUrl: freezed == configurationUrl ? _self.configurationUrl : configurationUrl // ignore: cast_nullable_to_non_nullable
as String?,primaryConfigEntry: freezed == primaryConfigEntry ? _self.primaryConfigEntry : primaryConfigEntry // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
