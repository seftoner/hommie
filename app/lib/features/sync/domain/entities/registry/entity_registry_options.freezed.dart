// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entity_registry_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SensorEntityOptions {

 int? get displayPrecision; int? get suggestedDisplayPrecision; String? get unitOfMeasurement;
/// Create a copy of SensorEntityOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SensorEntityOptionsCopyWith<SensorEntityOptions> get copyWith => _$SensorEntityOptionsCopyWithImpl<SensorEntityOptions>(this as SensorEntityOptions, _$identity);

  /// Serializes this SensorEntityOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SensorEntityOptions&&(identical(other.displayPrecision, displayPrecision) || other.displayPrecision == displayPrecision)&&(identical(other.suggestedDisplayPrecision, suggestedDisplayPrecision) || other.suggestedDisplayPrecision == suggestedDisplayPrecision)&&(identical(other.unitOfMeasurement, unitOfMeasurement) || other.unitOfMeasurement == unitOfMeasurement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayPrecision,suggestedDisplayPrecision,unitOfMeasurement);

@override
String toString() {
  return 'SensorEntityOptions(displayPrecision: $displayPrecision, suggestedDisplayPrecision: $suggestedDisplayPrecision, unitOfMeasurement: $unitOfMeasurement)';
}


}

/// @nodoc
abstract mixin class $SensorEntityOptionsCopyWith<$Res>  {
  factory $SensorEntityOptionsCopyWith(SensorEntityOptions value, $Res Function(SensorEntityOptions) _then) = _$SensorEntityOptionsCopyWithImpl;
@useResult
$Res call({
 int? displayPrecision, int? suggestedDisplayPrecision, String? unitOfMeasurement
});




}
/// @nodoc
class _$SensorEntityOptionsCopyWithImpl<$Res>
    implements $SensorEntityOptionsCopyWith<$Res> {
  _$SensorEntityOptionsCopyWithImpl(this._self, this._then);

  final SensorEntityOptions _self;
  final $Res Function(SensorEntityOptions) _then;

/// Create a copy of SensorEntityOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayPrecision = freezed,Object? suggestedDisplayPrecision = freezed,Object? unitOfMeasurement = freezed,}) {
  return _then(_self.copyWith(
displayPrecision: freezed == displayPrecision ? _self.displayPrecision : displayPrecision // ignore: cast_nullable_to_non_nullable
as int?,suggestedDisplayPrecision: freezed == suggestedDisplayPrecision ? _self.suggestedDisplayPrecision : suggestedDisplayPrecision // ignore: cast_nullable_to_non_nullable
as int?,unitOfMeasurement: freezed == unitOfMeasurement ? _self.unitOfMeasurement : unitOfMeasurement // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SensorEntityOptions].
extension SensorEntityOptionsPatterns on SensorEntityOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SensorEntityOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SensorEntityOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SensorEntityOptions value)  $default,){
final _that = this;
switch (_that) {
case _SensorEntityOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SensorEntityOptions value)?  $default,){
final _that = this;
switch (_that) {
case _SensorEntityOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? displayPrecision,  int? suggestedDisplayPrecision,  String? unitOfMeasurement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SensorEntityOptions() when $default != null:
return $default(_that.displayPrecision,_that.suggestedDisplayPrecision,_that.unitOfMeasurement);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? displayPrecision,  int? suggestedDisplayPrecision,  String? unitOfMeasurement)  $default,) {final _that = this;
switch (_that) {
case _SensorEntityOptions():
return $default(_that.displayPrecision,_that.suggestedDisplayPrecision,_that.unitOfMeasurement);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? displayPrecision,  int? suggestedDisplayPrecision,  String? unitOfMeasurement)?  $default,) {final _that = this;
switch (_that) {
case _SensorEntityOptions() when $default != null:
return $default(_that.displayPrecision,_that.suggestedDisplayPrecision,_that.unitOfMeasurement);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _SensorEntityOptions implements SensorEntityOptions {
  const _SensorEntityOptions({this.displayPrecision, this.suggestedDisplayPrecision, this.unitOfMeasurement});
  factory _SensorEntityOptions.fromJson(Map<String, dynamic> json) => _$SensorEntityOptionsFromJson(json);

@override final  int? displayPrecision;
@override final  int? suggestedDisplayPrecision;
@override final  String? unitOfMeasurement;

/// Create a copy of SensorEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SensorEntityOptionsCopyWith<_SensorEntityOptions> get copyWith => __$SensorEntityOptionsCopyWithImpl<_SensorEntityOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SensorEntityOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SensorEntityOptions&&(identical(other.displayPrecision, displayPrecision) || other.displayPrecision == displayPrecision)&&(identical(other.suggestedDisplayPrecision, suggestedDisplayPrecision) || other.suggestedDisplayPrecision == suggestedDisplayPrecision)&&(identical(other.unitOfMeasurement, unitOfMeasurement) || other.unitOfMeasurement == unitOfMeasurement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayPrecision,suggestedDisplayPrecision,unitOfMeasurement);

@override
String toString() {
  return 'SensorEntityOptions(displayPrecision: $displayPrecision, suggestedDisplayPrecision: $suggestedDisplayPrecision, unitOfMeasurement: $unitOfMeasurement)';
}


}

/// @nodoc
abstract mixin class _$SensorEntityOptionsCopyWith<$Res> implements $SensorEntityOptionsCopyWith<$Res> {
  factory _$SensorEntityOptionsCopyWith(_SensorEntityOptions value, $Res Function(_SensorEntityOptions) _then) = __$SensorEntityOptionsCopyWithImpl;
@override @useResult
$Res call({
 int? displayPrecision, int? suggestedDisplayPrecision, String? unitOfMeasurement
});




}
/// @nodoc
class __$SensorEntityOptionsCopyWithImpl<$Res>
    implements _$SensorEntityOptionsCopyWith<$Res> {
  __$SensorEntityOptionsCopyWithImpl(this._self, this._then);

  final _SensorEntityOptions _self;
  final $Res Function(_SensorEntityOptions) _then;

/// Create a copy of SensorEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayPrecision = freezed,Object? suggestedDisplayPrecision = freezed,Object? unitOfMeasurement = freezed,}) {
  return _then(_SensorEntityOptions(
displayPrecision: freezed == displayPrecision ? _self.displayPrecision : displayPrecision // ignore: cast_nullable_to_non_nullable
as int?,suggestedDisplayPrecision: freezed == suggestedDisplayPrecision ? _self.suggestedDisplayPrecision : suggestedDisplayPrecision // ignore: cast_nullable_to_non_nullable
as int?,unitOfMeasurement: freezed == unitOfMeasurement ? _self.unitOfMeasurement : unitOfMeasurement // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NumberEntityOptions {

 String? get unitOfMeasurement;
/// Create a copy of NumberEntityOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumberEntityOptionsCopyWith<NumberEntityOptions> get copyWith => _$NumberEntityOptionsCopyWithImpl<NumberEntityOptions>(this as NumberEntityOptions, _$identity);

  /// Serializes this NumberEntityOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumberEntityOptions&&(identical(other.unitOfMeasurement, unitOfMeasurement) || other.unitOfMeasurement == unitOfMeasurement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unitOfMeasurement);

@override
String toString() {
  return 'NumberEntityOptions(unitOfMeasurement: $unitOfMeasurement)';
}


}

/// @nodoc
abstract mixin class $NumberEntityOptionsCopyWith<$Res>  {
  factory $NumberEntityOptionsCopyWith(NumberEntityOptions value, $Res Function(NumberEntityOptions) _then) = _$NumberEntityOptionsCopyWithImpl;
@useResult
$Res call({
 String? unitOfMeasurement
});




}
/// @nodoc
class _$NumberEntityOptionsCopyWithImpl<$Res>
    implements $NumberEntityOptionsCopyWith<$Res> {
  _$NumberEntityOptionsCopyWithImpl(this._self, this._then);

  final NumberEntityOptions _self;
  final $Res Function(NumberEntityOptions) _then;

/// Create a copy of NumberEntityOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unitOfMeasurement = freezed,}) {
  return _then(_self.copyWith(
unitOfMeasurement: freezed == unitOfMeasurement ? _self.unitOfMeasurement : unitOfMeasurement // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NumberEntityOptions].
extension NumberEntityOptionsPatterns on NumberEntityOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NumberEntityOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NumberEntityOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NumberEntityOptions value)  $default,){
final _that = this;
switch (_that) {
case _NumberEntityOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NumberEntityOptions value)?  $default,){
final _that = this;
switch (_that) {
case _NumberEntityOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? unitOfMeasurement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NumberEntityOptions() when $default != null:
return $default(_that.unitOfMeasurement);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? unitOfMeasurement)  $default,) {final _that = this;
switch (_that) {
case _NumberEntityOptions():
return $default(_that.unitOfMeasurement);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? unitOfMeasurement)?  $default,) {final _that = this;
switch (_that) {
case _NumberEntityOptions() when $default != null:
return $default(_that.unitOfMeasurement);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _NumberEntityOptions implements NumberEntityOptions {
  const _NumberEntityOptions({this.unitOfMeasurement});
  factory _NumberEntityOptions.fromJson(Map<String, dynamic> json) => _$NumberEntityOptionsFromJson(json);

@override final  String? unitOfMeasurement;

/// Create a copy of NumberEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NumberEntityOptionsCopyWith<_NumberEntityOptions> get copyWith => __$NumberEntityOptionsCopyWithImpl<_NumberEntityOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NumberEntityOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NumberEntityOptions&&(identical(other.unitOfMeasurement, unitOfMeasurement) || other.unitOfMeasurement == unitOfMeasurement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unitOfMeasurement);

@override
String toString() {
  return 'NumberEntityOptions(unitOfMeasurement: $unitOfMeasurement)';
}


}

/// @nodoc
abstract mixin class _$NumberEntityOptionsCopyWith<$Res> implements $NumberEntityOptionsCopyWith<$Res> {
  factory _$NumberEntityOptionsCopyWith(_NumberEntityOptions value, $Res Function(_NumberEntityOptions) _then) = __$NumberEntityOptionsCopyWithImpl;
@override @useResult
$Res call({
 String? unitOfMeasurement
});




}
/// @nodoc
class __$NumberEntityOptionsCopyWithImpl<$Res>
    implements _$NumberEntityOptionsCopyWith<$Res> {
  __$NumberEntityOptionsCopyWithImpl(this._self, this._then);

  final _NumberEntityOptions _self;
  final $Res Function(_NumberEntityOptions) _then;

/// Create a copy of NumberEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unitOfMeasurement = freezed,}) {
  return _then(_NumberEntityOptions(
unitOfMeasurement: freezed == unitOfMeasurement ? _self.unitOfMeasurement : unitOfMeasurement // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LockEntityOptions {

 String? get defaultCode;
/// Create a copy of LockEntityOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LockEntityOptionsCopyWith<LockEntityOptions> get copyWith => _$LockEntityOptionsCopyWithImpl<LockEntityOptions>(this as LockEntityOptions, _$identity);

  /// Serializes this LockEntityOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LockEntityOptions&&(identical(other.defaultCode, defaultCode) || other.defaultCode == defaultCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultCode);

@override
String toString() {
  return 'LockEntityOptions(defaultCode: $defaultCode)';
}


}

/// @nodoc
abstract mixin class $LockEntityOptionsCopyWith<$Res>  {
  factory $LockEntityOptionsCopyWith(LockEntityOptions value, $Res Function(LockEntityOptions) _then) = _$LockEntityOptionsCopyWithImpl;
@useResult
$Res call({
 String? defaultCode
});




}
/// @nodoc
class _$LockEntityOptionsCopyWithImpl<$Res>
    implements $LockEntityOptionsCopyWith<$Res> {
  _$LockEntityOptionsCopyWithImpl(this._self, this._then);

  final LockEntityOptions _self;
  final $Res Function(LockEntityOptions) _then;

/// Create a copy of LockEntityOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultCode = freezed,}) {
  return _then(_self.copyWith(
defaultCode: freezed == defaultCode ? _self.defaultCode : defaultCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LockEntityOptions].
extension LockEntityOptionsPatterns on LockEntityOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LockEntityOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LockEntityOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LockEntityOptions value)  $default,){
final _that = this;
switch (_that) {
case _LockEntityOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LockEntityOptions value)?  $default,){
final _that = this;
switch (_that) {
case _LockEntityOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? defaultCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LockEntityOptions() when $default != null:
return $default(_that.defaultCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? defaultCode)  $default,) {final _that = this;
switch (_that) {
case _LockEntityOptions():
return $default(_that.defaultCode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? defaultCode)?  $default,) {final _that = this;
switch (_that) {
case _LockEntityOptions() when $default != null:
return $default(_that.defaultCode);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _LockEntityOptions implements LockEntityOptions {
  const _LockEntityOptions({this.defaultCode});
  factory _LockEntityOptions.fromJson(Map<String, dynamic> json) => _$LockEntityOptionsFromJson(json);

@override final  String? defaultCode;

/// Create a copy of LockEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LockEntityOptionsCopyWith<_LockEntityOptions> get copyWith => __$LockEntityOptionsCopyWithImpl<_LockEntityOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LockEntityOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LockEntityOptions&&(identical(other.defaultCode, defaultCode) || other.defaultCode == defaultCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultCode);

@override
String toString() {
  return 'LockEntityOptions(defaultCode: $defaultCode)';
}


}

/// @nodoc
abstract mixin class _$LockEntityOptionsCopyWith<$Res> implements $LockEntityOptionsCopyWith<$Res> {
  factory _$LockEntityOptionsCopyWith(_LockEntityOptions value, $Res Function(_LockEntityOptions) _then) = __$LockEntityOptionsCopyWithImpl;
@override @useResult
$Res call({
 String? defaultCode
});




}
/// @nodoc
class __$LockEntityOptionsCopyWithImpl<$Res>
    implements _$LockEntityOptionsCopyWith<$Res> {
  __$LockEntityOptionsCopyWithImpl(this._self, this._then);

  final _LockEntityOptions _self;
  final $Res Function(_LockEntityOptions) _then;

/// Create a copy of LockEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? defaultCode = freezed,}) {
  return _then(_LockEntityOptions(
defaultCode: freezed == defaultCode ? _self.defaultCode : defaultCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AlarmControlPanelEntityOptions {

 String? get defaultCode;
/// Create a copy of AlarmControlPanelEntityOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlarmControlPanelEntityOptionsCopyWith<AlarmControlPanelEntityOptions> get copyWith => _$AlarmControlPanelEntityOptionsCopyWithImpl<AlarmControlPanelEntityOptions>(this as AlarmControlPanelEntityOptions, _$identity);

  /// Serializes this AlarmControlPanelEntityOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlarmControlPanelEntityOptions&&(identical(other.defaultCode, defaultCode) || other.defaultCode == defaultCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultCode);

@override
String toString() {
  return 'AlarmControlPanelEntityOptions(defaultCode: $defaultCode)';
}


}

/// @nodoc
abstract mixin class $AlarmControlPanelEntityOptionsCopyWith<$Res>  {
  factory $AlarmControlPanelEntityOptionsCopyWith(AlarmControlPanelEntityOptions value, $Res Function(AlarmControlPanelEntityOptions) _then) = _$AlarmControlPanelEntityOptionsCopyWithImpl;
@useResult
$Res call({
 String? defaultCode
});




}
/// @nodoc
class _$AlarmControlPanelEntityOptionsCopyWithImpl<$Res>
    implements $AlarmControlPanelEntityOptionsCopyWith<$Res> {
  _$AlarmControlPanelEntityOptionsCopyWithImpl(this._self, this._then);

  final AlarmControlPanelEntityOptions _self;
  final $Res Function(AlarmControlPanelEntityOptions) _then;

/// Create a copy of AlarmControlPanelEntityOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultCode = freezed,}) {
  return _then(_self.copyWith(
defaultCode: freezed == defaultCode ? _self.defaultCode : defaultCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AlarmControlPanelEntityOptions].
extension AlarmControlPanelEntityOptionsPatterns on AlarmControlPanelEntityOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlarmControlPanelEntityOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlarmControlPanelEntityOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlarmControlPanelEntityOptions value)  $default,){
final _that = this;
switch (_that) {
case _AlarmControlPanelEntityOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlarmControlPanelEntityOptions value)?  $default,){
final _that = this;
switch (_that) {
case _AlarmControlPanelEntityOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? defaultCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlarmControlPanelEntityOptions() when $default != null:
return $default(_that.defaultCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? defaultCode)  $default,) {final _that = this;
switch (_that) {
case _AlarmControlPanelEntityOptions():
return $default(_that.defaultCode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? defaultCode)?  $default,) {final _that = this;
switch (_that) {
case _AlarmControlPanelEntityOptions() when $default != null:
return $default(_that.defaultCode);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _AlarmControlPanelEntityOptions implements AlarmControlPanelEntityOptions {
  const _AlarmControlPanelEntityOptions({this.defaultCode});
  factory _AlarmControlPanelEntityOptions.fromJson(Map<String, dynamic> json) => _$AlarmControlPanelEntityOptionsFromJson(json);

@override final  String? defaultCode;

/// Create a copy of AlarmControlPanelEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlarmControlPanelEntityOptionsCopyWith<_AlarmControlPanelEntityOptions> get copyWith => __$AlarmControlPanelEntityOptionsCopyWithImpl<_AlarmControlPanelEntityOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlarmControlPanelEntityOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlarmControlPanelEntityOptions&&(identical(other.defaultCode, defaultCode) || other.defaultCode == defaultCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultCode);

@override
String toString() {
  return 'AlarmControlPanelEntityOptions(defaultCode: $defaultCode)';
}


}

/// @nodoc
abstract mixin class _$AlarmControlPanelEntityOptionsCopyWith<$Res> implements $AlarmControlPanelEntityOptionsCopyWith<$Res> {
  factory _$AlarmControlPanelEntityOptionsCopyWith(_AlarmControlPanelEntityOptions value, $Res Function(_AlarmControlPanelEntityOptions) _then) = __$AlarmControlPanelEntityOptionsCopyWithImpl;
@override @useResult
$Res call({
 String? defaultCode
});




}
/// @nodoc
class __$AlarmControlPanelEntityOptionsCopyWithImpl<$Res>
    implements _$AlarmControlPanelEntityOptionsCopyWith<$Res> {
  __$AlarmControlPanelEntityOptionsCopyWithImpl(this._self, this._then);

  final _AlarmControlPanelEntityOptions _self;
  final $Res Function(_AlarmControlPanelEntityOptions) _then;

/// Create a copy of AlarmControlPanelEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? defaultCode = freezed,}) {
  return _then(_AlarmControlPanelEntityOptions(
defaultCode: freezed == defaultCode ? _self.defaultCode : defaultCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WeatherEntityOptions {

 String? get precipitationUnit; String? get pressureUnit; String? get temperatureUnit; String? get visibilityUnit; String? get windSpeedUnit;
/// Create a copy of WeatherEntityOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherEntityOptionsCopyWith<WeatherEntityOptions> get copyWith => _$WeatherEntityOptionsCopyWithImpl<WeatherEntityOptions>(this as WeatherEntityOptions, _$identity);

  /// Serializes this WeatherEntityOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherEntityOptions&&(identical(other.precipitationUnit, precipitationUnit) || other.precipitationUnit == precipitationUnit)&&(identical(other.pressureUnit, pressureUnit) || other.pressureUnit == pressureUnit)&&(identical(other.temperatureUnit, temperatureUnit) || other.temperatureUnit == temperatureUnit)&&(identical(other.visibilityUnit, visibilityUnit) || other.visibilityUnit == visibilityUnit)&&(identical(other.windSpeedUnit, windSpeedUnit) || other.windSpeedUnit == windSpeedUnit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,precipitationUnit,pressureUnit,temperatureUnit,visibilityUnit,windSpeedUnit);

@override
String toString() {
  return 'WeatherEntityOptions(precipitationUnit: $precipitationUnit, pressureUnit: $pressureUnit, temperatureUnit: $temperatureUnit, visibilityUnit: $visibilityUnit, windSpeedUnit: $windSpeedUnit)';
}


}

/// @nodoc
abstract mixin class $WeatherEntityOptionsCopyWith<$Res>  {
  factory $WeatherEntityOptionsCopyWith(WeatherEntityOptions value, $Res Function(WeatherEntityOptions) _then) = _$WeatherEntityOptionsCopyWithImpl;
@useResult
$Res call({
 String? precipitationUnit, String? pressureUnit, String? temperatureUnit, String? visibilityUnit, String? windSpeedUnit
});




}
/// @nodoc
class _$WeatherEntityOptionsCopyWithImpl<$Res>
    implements $WeatherEntityOptionsCopyWith<$Res> {
  _$WeatherEntityOptionsCopyWithImpl(this._self, this._then);

  final WeatherEntityOptions _self;
  final $Res Function(WeatherEntityOptions) _then;

/// Create a copy of WeatherEntityOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? precipitationUnit = freezed,Object? pressureUnit = freezed,Object? temperatureUnit = freezed,Object? visibilityUnit = freezed,Object? windSpeedUnit = freezed,}) {
  return _then(_self.copyWith(
precipitationUnit: freezed == precipitationUnit ? _self.precipitationUnit : precipitationUnit // ignore: cast_nullable_to_non_nullable
as String?,pressureUnit: freezed == pressureUnit ? _self.pressureUnit : pressureUnit // ignore: cast_nullable_to_non_nullable
as String?,temperatureUnit: freezed == temperatureUnit ? _self.temperatureUnit : temperatureUnit // ignore: cast_nullable_to_non_nullable
as String?,visibilityUnit: freezed == visibilityUnit ? _self.visibilityUnit : visibilityUnit // ignore: cast_nullable_to_non_nullable
as String?,windSpeedUnit: freezed == windSpeedUnit ? _self.windSpeedUnit : windSpeedUnit // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherEntityOptions].
extension WeatherEntityOptionsPatterns on WeatherEntityOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherEntityOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherEntityOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherEntityOptions value)  $default,){
final _that = this;
switch (_that) {
case _WeatherEntityOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherEntityOptions value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherEntityOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? precipitationUnit,  String? pressureUnit,  String? temperatureUnit,  String? visibilityUnit,  String? windSpeedUnit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherEntityOptions() when $default != null:
return $default(_that.precipitationUnit,_that.pressureUnit,_that.temperatureUnit,_that.visibilityUnit,_that.windSpeedUnit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? precipitationUnit,  String? pressureUnit,  String? temperatureUnit,  String? visibilityUnit,  String? windSpeedUnit)  $default,) {final _that = this;
switch (_that) {
case _WeatherEntityOptions():
return $default(_that.precipitationUnit,_that.pressureUnit,_that.temperatureUnit,_that.visibilityUnit,_that.windSpeedUnit);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? precipitationUnit,  String? pressureUnit,  String? temperatureUnit,  String? visibilityUnit,  String? windSpeedUnit)?  $default,) {final _that = this;
switch (_that) {
case _WeatherEntityOptions() when $default != null:
return $default(_that.precipitationUnit,_that.pressureUnit,_that.temperatureUnit,_that.visibilityUnit,_that.windSpeedUnit);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _WeatherEntityOptions implements WeatherEntityOptions {
  const _WeatherEntityOptions({this.precipitationUnit, this.pressureUnit, this.temperatureUnit, this.visibilityUnit, this.windSpeedUnit});
  factory _WeatherEntityOptions.fromJson(Map<String, dynamic> json) => _$WeatherEntityOptionsFromJson(json);

@override final  String? precipitationUnit;
@override final  String? pressureUnit;
@override final  String? temperatureUnit;
@override final  String? visibilityUnit;
@override final  String? windSpeedUnit;

/// Create a copy of WeatherEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherEntityOptionsCopyWith<_WeatherEntityOptions> get copyWith => __$WeatherEntityOptionsCopyWithImpl<_WeatherEntityOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherEntityOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherEntityOptions&&(identical(other.precipitationUnit, precipitationUnit) || other.precipitationUnit == precipitationUnit)&&(identical(other.pressureUnit, pressureUnit) || other.pressureUnit == pressureUnit)&&(identical(other.temperatureUnit, temperatureUnit) || other.temperatureUnit == temperatureUnit)&&(identical(other.visibilityUnit, visibilityUnit) || other.visibilityUnit == visibilityUnit)&&(identical(other.windSpeedUnit, windSpeedUnit) || other.windSpeedUnit == windSpeedUnit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,precipitationUnit,pressureUnit,temperatureUnit,visibilityUnit,windSpeedUnit);

@override
String toString() {
  return 'WeatherEntityOptions(precipitationUnit: $precipitationUnit, pressureUnit: $pressureUnit, temperatureUnit: $temperatureUnit, visibilityUnit: $visibilityUnit, windSpeedUnit: $windSpeedUnit)';
}


}

/// @nodoc
abstract mixin class _$WeatherEntityOptionsCopyWith<$Res> implements $WeatherEntityOptionsCopyWith<$Res> {
  factory _$WeatherEntityOptionsCopyWith(_WeatherEntityOptions value, $Res Function(_WeatherEntityOptions) _then) = __$WeatherEntityOptionsCopyWithImpl;
@override @useResult
$Res call({
 String? precipitationUnit, String? pressureUnit, String? temperatureUnit, String? visibilityUnit, String? windSpeedUnit
});




}
/// @nodoc
class __$WeatherEntityOptionsCopyWithImpl<$Res>
    implements _$WeatherEntityOptionsCopyWith<$Res> {
  __$WeatherEntityOptionsCopyWithImpl(this._self, this._then);

  final _WeatherEntityOptions _self;
  final $Res Function(_WeatherEntityOptions) _then;

/// Create a copy of WeatherEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? precipitationUnit = freezed,Object? pressureUnit = freezed,Object? temperatureUnit = freezed,Object? visibilityUnit = freezed,Object? windSpeedUnit = freezed,}) {
  return _then(_WeatherEntityOptions(
precipitationUnit: freezed == precipitationUnit ? _self.precipitationUnit : precipitationUnit // ignore: cast_nullable_to_non_nullable
as String?,pressureUnit: freezed == pressureUnit ? _self.pressureUnit : pressureUnit // ignore: cast_nullable_to_non_nullable
as String?,temperatureUnit: freezed == temperatureUnit ? _self.temperatureUnit : temperatureUnit // ignore: cast_nullable_to_non_nullable
as String?,visibilityUnit: freezed == visibilityUnit ? _self.visibilityUnit : visibilityUnit // ignore: cast_nullable_to_non_nullable
as String?,windSpeedUnit: freezed == windSpeedUnit ? _self.windSpeedUnit : windSpeedUnit // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LightEntityOptions {

@LightColorListConverter() List<LightColor>? get favoriteColors;
/// Create a copy of LightEntityOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LightEntityOptionsCopyWith<LightEntityOptions> get copyWith => _$LightEntityOptionsCopyWithImpl<LightEntityOptions>(this as LightEntityOptions, _$identity);

  /// Serializes this LightEntityOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightEntityOptions&&const DeepCollectionEquality().equals(other.favoriteColors, favoriteColors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(favoriteColors));

@override
String toString() {
  return 'LightEntityOptions(favoriteColors: $favoriteColors)';
}


}

/// @nodoc
abstract mixin class $LightEntityOptionsCopyWith<$Res>  {
  factory $LightEntityOptionsCopyWith(LightEntityOptions value, $Res Function(LightEntityOptions) _then) = _$LightEntityOptionsCopyWithImpl;
@useResult
$Res call({
@LightColorListConverter() List<LightColor>? favoriteColors
});




}
/// @nodoc
class _$LightEntityOptionsCopyWithImpl<$Res>
    implements $LightEntityOptionsCopyWith<$Res> {
  _$LightEntityOptionsCopyWithImpl(this._self, this._then);

  final LightEntityOptions _self;
  final $Res Function(LightEntityOptions) _then;

/// Create a copy of LightEntityOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? favoriteColors = freezed,}) {
  return _then(_self.copyWith(
favoriteColors: freezed == favoriteColors ? _self.favoriteColors : favoriteColors // ignore: cast_nullable_to_non_nullable
as List<LightColor>?,
  ));
}

}


/// Adds pattern-matching-related methods to [LightEntityOptions].
extension LightEntityOptionsPatterns on LightEntityOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LightEntityOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LightEntityOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LightEntityOptions value)  $default,){
final _that = this;
switch (_that) {
case _LightEntityOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LightEntityOptions value)?  $default,){
final _that = this;
switch (_that) {
case _LightEntityOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@LightColorListConverter()  List<LightColor>? favoriteColors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LightEntityOptions() when $default != null:
return $default(_that.favoriteColors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@LightColorListConverter()  List<LightColor>? favoriteColors)  $default,) {final _that = this;
switch (_that) {
case _LightEntityOptions():
return $default(_that.favoriteColors);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@LightColorListConverter()  List<LightColor>? favoriteColors)?  $default,) {final _that = this;
switch (_that) {
case _LightEntityOptions() when $default != null:
return $default(_that.favoriteColors);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _LightEntityOptions implements LightEntityOptions {
  const _LightEntityOptions({@LightColorListConverter() final  List<LightColor>? favoriteColors}): _favoriteColors = favoriteColors;
  factory _LightEntityOptions.fromJson(Map<String, dynamic> json) => _$LightEntityOptionsFromJson(json);

 final  List<LightColor>? _favoriteColors;
@override@LightColorListConverter() List<LightColor>? get favoriteColors {
  final value = _favoriteColors;
  if (value == null) return null;
  if (_favoriteColors is EqualUnmodifiableListView) return _favoriteColors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of LightEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LightEntityOptionsCopyWith<_LightEntityOptions> get copyWith => __$LightEntityOptionsCopyWithImpl<_LightEntityOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LightEntityOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LightEntityOptions&&const DeepCollectionEquality().equals(other._favoriteColors, _favoriteColors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_favoriteColors));

@override
String toString() {
  return 'LightEntityOptions(favoriteColors: $favoriteColors)';
}


}

/// @nodoc
abstract mixin class _$LightEntityOptionsCopyWith<$Res> implements $LightEntityOptionsCopyWith<$Res> {
  factory _$LightEntityOptionsCopyWith(_LightEntityOptions value, $Res Function(_LightEntityOptions) _then) = __$LightEntityOptionsCopyWithImpl;
@override @useResult
$Res call({
@LightColorListConverter() List<LightColor>? favoriteColors
});




}
/// @nodoc
class __$LightEntityOptionsCopyWithImpl<$Res>
    implements _$LightEntityOptionsCopyWith<$Res> {
  __$LightEntityOptionsCopyWithImpl(this._self, this._then);

  final _LightEntityOptions _self;
  final $Res Function(_LightEntityOptions) _then;

/// Create a copy of LightEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favoriteColors = freezed,}) {
  return _then(_LightEntityOptions(
favoriteColors: freezed == favoriteColors ? _self._favoriteColors : favoriteColors // ignore: cast_nullable_to_non_nullable
as List<LightColor>?,
  ));
}


}


/// @nodoc
mixin _$SwitchAsXEntityOptions {

 String get entityId; bool get invert;
/// Create a copy of SwitchAsXEntityOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwitchAsXEntityOptionsCopyWith<SwitchAsXEntityOptions> get copyWith => _$SwitchAsXEntityOptionsCopyWithImpl<SwitchAsXEntityOptions>(this as SwitchAsXEntityOptions, _$identity);

  /// Serializes this SwitchAsXEntityOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwitchAsXEntityOptions&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.invert, invert) || other.invert == invert));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entityId,invert);

@override
String toString() {
  return 'SwitchAsXEntityOptions(entityId: $entityId, invert: $invert)';
}


}

/// @nodoc
abstract mixin class $SwitchAsXEntityOptionsCopyWith<$Res>  {
  factory $SwitchAsXEntityOptionsCopyWith(SwitchAsXEntityOptions value, $Res Function(SwitchAsXEntityOptions) _then) = _$SwitchAsXEntityOptionsCopyWithImpl;
@useResult
$Res call({
 String entityId, bool invert
});




}
/// @nodoc
class _$SwitchAsXEntityOptionsCopyWithImpl<$Res>
    implements $SwitchAsXEntityOptionsCopyWith<$Res> {
  _$SwitchAsXEntityOptionsCopyWithImpl(this._self, this._then);

  final SwitchAsXEntityOptions _self;
  final $Res Function(SwitchAsXEntityOptions) _then;

/// Create a copy of SwitchAsXEntityOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entityId = null,Object? invert = null,}) {
  return _then(_self.copyWith(
entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,invert: null == invert ? _self.invert : invert // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SwitchAsXEntityOptions].
extension SwitchAsXEntityOptionsPatterns on SwitchAsXEntityOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SwitchAsXEntityOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SwitchAsXEntityOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SwitchAsXEntityOptions value)  $default,){
final _that = this;
switch (_that) {
case _SwitchAsXEntityOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SwitchAsXEntityOptions value)?  $default,){
final _that = this;
switch (_that) {
case _SwitchAsXEntityOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String entityId,  bool invert)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SwitchAsXEntityOptions() when $default != null:
return $default(_that.entityId,_that.invert);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String entityId,  bool invert)  $default,) {final _that = this;
switch (_that) {
case _SwitchAsXEntityOptions():
return $default(_that.entityId,_that.invert);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String entityId,  bool invert)?  $default,) {final _that = this;
switch (_that) {
case _SwitchAsXEntityOptions() when $default != null:
return $default(_that.entityId,_that.invert);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _SwitchAsXEntityOptions implements SwitchAsXEntityOptions {
  const _SwitchAsXEntityOptions({required this.entityId, required this.invert});
  factory _SwitchAsXEntityOptions.fromJson(Map<String, dynamic> json) => _$SwitchAsXEntityOptionsFromJson(json);

@override final  String entityId;
@override final  bool invert;

/// Create a copy of SwitchAsXEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SwitchAsXEntityOptionsCopyWith<_SwitchAsXEntityOptions> get copyWith => __$SwitchAsXEntityOptionsCopyWithImpl<_SwitchAsXEntityOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SwitchAsXEntityOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwitchAsXEntityOptions&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.invert, invert) || other.invert == invert));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entityId,invert);

@override
String toString() {
  return 'SwitchAsXEntityOptions(entityId: $entityId, invert: $invert)';
}


}

/// @nodoc
abstract mixin class _$SwitchAsXEntityOptionsCopyWith<$Res> implements $SwitchAsXEntityOptionsCopyWith<$Res> {
  factory _$SwitchAsXEntityOptionsCopyWith(_SwitchAsXEntityOptions value, $Res Function(_SwitchAsXEntityOptions) _then) = __$SwitchAsXEntityOptionsCopyWithImpl;
@override @useResult
$Res call({
 String entityId, bool invert
});




}
/// @nodoc
class __$SwitchAsXEntityOptionsCopyWithImpl<$Res>
    implements _$SwitchAsXEntityOptionsCopyWith<$Res> {
  __$SwitchAsXEntityOptionsCopyWithImpl(this._self, this._then);

  final _SwitchAsXEntityOptions _self;
  final $Res Function(_SwitchAsXEntityOptions) _then;

/// Create a copy of SwitchAsXEntityOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entityId = null,Object? invert = null,}) {
  return _then(_SwitchAsXEntityOptions(
entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,invert: null == invert ? _self.invert : invert // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EntityRegistryOptions {

 NumberEntityOptions? get number; SensorEntityOptions? get sensor; AlarmControlPanelEntityOptions? get alarmControlPanel; LockEntityOptions? get lock; WeatherEntityOptions? get weather; LightEntityOptions? get light; SwitchAsXEntityOptions? get switchAsX; Map<String, dynamic>? get conversation;@JsonKey(name: 'cloud.alexa') Map<String, dynamic>? get cloudAlexa;@JsonKey(name: 'cloud.google_assistant') Map<String, dynamic>? get cloudGoogleAssistant;
/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntityRegistryOptionsCopyWith<EntityRegistryOptions> get copyWith => _$EntityRegistryOptionsCopyWithImpl<EntityRegistryOptions>(this as EntityRegistryOptions, _$identity);

  /// Serializes this EntityRegistryOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntityRegistryOptions&&(identical(other.number, number) || other.number == number)&&(identical(other.sensor, sensor) || other.sensor == sensor)&&(identical(other.alarmControlPanel, alarmControlPanel) || other.alarmControlPanel == alarmControlPanel)&&(identical(other.lock, lock) || other.lock == lock)&&(identical(other.weather, weather) || other.weather == weather)&&(identical(other.light, light) || other.light == light)&&(identical(other.switchAsX, switchAsX) || other.switchAsX == switchAsX)&&const DeepCollectionEquality().equals(other.conversation, conversation)&&const DeepCollectionEquality().equals(other.cloudAlexa, cloudAlexa)&&const DeepCollectionEquality().equals(other.cloudGoogleAssistant, cloudGoogleAssistant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,sensor,alarmControlPanel,lock,weather,light,switchAsX,const DeepCollectionEquality().hash(conversation),const DeepCollectionEquality().hash(cloudAlexa),const DeepCollectionEquality().hash(cloudGoogleAssistant));

@override
String toString() {
  return 'EntityRegistryOptions(number: $number, sensor: $sensor, alarmControlPanel: $alarmControlPanel, lock: $lock, weather: $weather, light: $light, switchAsX: $switchAsX, conversation: $conversation, cloudAlexa: $cloudAlexa, cloudGoogleAssistant: $cloudGoogleAssistant)';
}


}

/// @nodoc
abstract mixin class $EntityRegistryOptionsCopyWith<$Res>  {
  factory $EntityRegistryOptionsCopyWith(EntityRegistryOptions value, $Res Function(EntityRegistryOptions) _then) = _$EntityRegistryOptionsCopyWithImpl;
@useResult
$Res call({
 NumberEntityOptions? number, SensorEntityOptions? sensor, AlarmControlPanelEntityOptions? alarmControlPanel, LockEntityOptions? lock, WeatherEntityOptions? weather, LightEntityOptions? light, SwitchAsXEntityOptions? switchAsX, Map<String, dynamic>? conversation,@JsonKey(name: 'cloud.alexa') Map<String, dynamic>? cloudAlexa,@JsonKey(name: 'cloud.google_assistant') Map<String, dynamic>? cloudGoogleAssistant
});


$NumberEntityOptionsCopyWith<$Res>? get number;$SensorEntityOptionsCopyWith<$Res>? get sensor;$AlarmControlPanelEntityOptionsCopyWith<$Res>? get alarmControlPanel;$LockEntityOptionsCopyWith<$Res>? get lock;$WeatherEntityOptionsCopyWith<$Res>? get weather;$LightEntityOptionsCopyWith<$Res>? get light;$SwitchAsXEntityOptionsCopyWith<$Res>? get switchAsX;

}
/// @nodoc
class _$EntityRegistryOptionsCopyWithImpl<$Res>
    implements $EntityRegistryOptionsCopyWith<$Res> {
  _$EntityRegistryOptionsCopyWithImpl(this._self, this._then);

  final EntityRegistryOptions _self;
  final $Res Function(EntityRegistryOptions) _then;

/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = freezed,Object? sensor = freezed,Object? alarmControlPanel = freezed,Object? lock = freezed,Object? weather = freezed,Object? light = freezed,Object? switchAsX = freezed,Object? conversation = freezed,Object? cloudAlexa = freezed,Object? cloudGoogleAssistant = freezed,}) {
  return _then(_self.copyWith(
number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as NumberEntityOptions?,sensor: freezed == sensor ? _self.sensor : sensor // ignore: cast_nullable_to_non_nullable
as SensorEntityOptions?,alarmControlPanel: freezed == alarmControlPanel ? _self.alarmControlPanel : alarmControlPanel // ignore: cast_nullable_to_non_nullable
as AlarmControlPanelEntityOptions?,lock: freezed == lock ? _self.lock : lock // ignore: cast_nullable_to_non_nullable
as LockEntityOptions?,weather: freezed == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as WeatherEntityOptions?,light: freezed == light ? _self.light : light // ignore: cast_nullable_to_non_nullable
as LightEntityOptions?,switchAsX: freezed == switchAsX ? _self.switchAsX : switchAsX // ignore: cast_nullable_to_non_nullable
as SwitchAsXEntityOptions?,conversation: freezed == conversation ? _self.conversation : conversation // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,cloudAlexa: freezed == cloudAlexa ? _self.cloudAlexa : cloudAlexa // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,cloudGoogleAssistant: freezed == cloudGoogleAssistant ? _self.cloudGoogleAssistant : cloudGoogleAssistant // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}
/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NumberEntityOptionsCopyWith<$Res>? get number {
    if (_self.number == null) {
    return null;
  }

  return $NumberEntityOptionsCopyWith<$Res>(_self.number!, (value) {
    return _then(_self.copyWith(number: value));
  });
}/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SensorEntityOptionsCopyWith<$Res>? get sensor {
    if (_self.sensor == null) {
    return null;
  }

  return $SensorEntityOptionsCopyWith<$Res>(_self.sensor!, (value) {
    return _then(_self.copyWith(sensor: value));
  });
}/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlarmControlPanelEntityOptionsCopyWith<$Res>? get alarmControlPanel {
    if (_self.alarmControlPanel == null) {
    return null;
  }

  return $AlarmControlPanelEntityOptionsCopyWith<$Res>(_self.alarmControlPanel!, (value) {
    return _then(_self.copyWith(alarmControlPanel: value));
  });
}/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LockEntityOptionsCopyWith<$Res>? get lock {
    if (_self.lock == null) {
    return null;
  }

  return $LockEntityOptionsCopyWith<$Res>(_self.lock!, (value) {
    return _then(_self.copyWith(lock: value));
  });
}/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherEntityOptionsCopyWith<$Res>? get weather {
    if (_self.weather == null) {
    return null;
  }

  return $WeatherEntityOptionsCopyWith<$Res>(_self.weather!, (value) {
    return _then(_self.copyWith(weather: value));
  });
}/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LightEntityOptionsCopyWith<$Res>? get light {
    if (_self.light == null) {
    return null;
  }

  return $LightEntityOptionsCopyWith<$Res>(_self.light!, (value) {
    return _then(_self.copyWith(light: value));
  });
}/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SwitchAsXEntityOptionsCopyWith<$Res>? get switchAsX {
    if (_self.switchAsX == null) {
    return null;
  }

  return $SwitchAsXEntityOptionsCopyWith<$Res>(_self.switchAsX!, (value) {
    return _then(_self.copyWith(switchAsX: value));
  });
}
}


/// Adds pattern-matching-related methods to [EntityRegistryOptions].
extension EntityRegistryOptionsPatterns on EntityRegistryOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntityRegistryOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntityRegistryOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntityRegistryOptions value)  $default,){
final _that = this;
switch (_that) {
case _EntityRegistryOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntityRegistryOptions value)?  $default,){
final _that = this;
switch (_that) {
case _EntityRegistryOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NumberEntityOptions? number,  SensorEntityOptions? sensor,  AlarmControlPanelEntityOptions? alarmControlPanel,  LockEntityOptions? lock,  WeatherEntityOptions? weather,  LightEntityOptions? light,  SwitchAsXEntityOptions? switchAsX,  Map<String, dynamic>? conversation, @JsonKey(name: 'cloud.alexa')  Map<String, dynamic>? cloudAlexa, @JsonKey(name: 'cloud.google_assistant')  Map<String, dynamic>? cloudGoogleAssistant)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntityRegistryOptions() when $default != null:
return $default(_that.number,_that.sensor,_that.alarmControlPanel,_that.lock,_that.weather,_that.light,_that.switchAsX,_that.conversation,_that.cloudAlexa,_that.cloudGoogleAssistant);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NumberEntityOptions? number,  SensorEntityOptions? sensor,  AlarmControlPanelEntityOptions? alarmControlPanel,  LockEntityOptions? lock,  WeatherEntityOptions? weather,  LightEntityOptions? light,  SwitchAsXEntityOptions? switchAsX,  Map<String, dynamic>? conversation, @JsonKey(name: 'cloud.alexa')  Map<String, dynamic>? cloudAlexa, @JsonKey(name: 'cloud.google_assistant')  Map<String, dynamic>? cloudGoogleAssistant)  $default,) {final _that = this;
switch (_that) {
case _EntityRegistryOptions():
return $default(_that.number,_that.sensor,_that.alarmControlPanel,_that.lock,_that.weather,_that.light,_that.switchAsX,_that.conversation,_that.cloudAlexa,_that.cloudGoogleAssistant);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NumberEntityOptions? number,  SensorEntityOptions? sensor,  AlarmControlPanelEntityOptions? alarmControlPanel,  LockEntityOptions? lock,  WeatherEntityOptions? weather,  LightEntityOptions? light,  SwitchAsXEntityOptions? switchAsX,  Map<String, dynamic>? conversation, @JsonKey(name: 'cloud.alexa')  Map<String, dynamic>? cloudAlexa, @JsonKey(name: 'cloud.google_assistant')  Map<String, dynamic>? cloudGoogleAssistant)?  $default,) {final _that = this;
switch (_that) {
case _EntityRegistryOptions() when $default != null:
return $default(_that.number,_that.sensor,_that.alarmControlPanel,_that.lock,_that.weather,_that.light,_that.switchAsX,_that.conversation,_that.cloudAlexa,_that.cloudGoogleAssistant);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _EntityRegistryOptions implements EntityRegistryOptions {
  const _EntityRegistryOptions({this.number, this.sensor, this.alarmControlPanel, this.lock, this.weather, this.light, this.switchAsX, final  Map<String, dynamic>? conversation, @JsonKey(name: 'cloud.alexa') final  Map<String, dynamic>? cloudAlexa, @JsonKey(name: 'cloud.google_assistant') final  Map<String, dynamic>? cloudGoogleAssistant}): _conversation = conversation,_cloudAlexa = cloudAlexa,_cloudGoogleAssistant = cloudGoogleAssistant;
  factory _EntityRegistryOptions.fromJson(Map<String, dynamic> json) => _$EntityRegistryOptionsFromJson(json);

@override final  NumberEntityOptions? number;
@override final  SensorEntityOptions? sensor;
@override final  AlarmControlPanelEntityOptions? alarmControlPanel;
@override final  LockEntityOptions? lock;
@override final  WeatherEntityOptions? weather;
@override final  LightEntityOptions? light;
@override final  SwitchAsXEntityOptions? switchAsX;
 final  Map<String, dynamic>? _conversation;
@override Map<String, dynamic>? get conversation {
  final value = _conversation;
  if (value == null) return null;
  if (_conversation is EqualUnmodifiableMapView) return _conversation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _cloudAlexa;
@override@JsonKey(name: 'cloud.alexa') Map<String, dynamic>? get cloudAlexa {
  final value = _cloudAlexa;
  if (value == null) return null;
  if (_cloudAlexa is EqualUnmodifiableMapView) return _cloudAlexa;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _cloudGoogleAssistant;
@override@JsonKey(name: 'cloud.google_assistant') Map<String, dynamic>? get cloudGoogleAssistant {
  final value = _cloudGoogleAssistant;
  if (value == null) return null;
  if (_cloudGoogleAssistant is EqualUnmodifiableMapView) return _cloudGoogleAssistant;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntityRegistryOptionsCopyWith<_EntityRegistryOptions> get copyWith => __$EntityRegistryOptionsCopyWithImpl<_EntityRegistryOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntityRegistryOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntityRegistryOptions&&(identical(other.number, number) || other.number == number)&&(identical(other.sensor, sensor) || other.sensor == sensor)&&(identical(other.alarmControlPanel, alarmControlPanel) || other.alarmControlPanel == alarmControlPanel)&&(identical(other.lock, lock) || other.lock == lock)&&(identical(other.weather, weather) || other.weather == weather)&&(identical(other.light, light) || other.light == light)&&(identical(other.switchAsX, switchAsX) || other.switchAsX == switchAsX)&&const DeepCollectionEquality().equals(other._conversation, _conversation)&&const DeepCollectionEquality().equals(other._cloudAlexa, _cloudAlexa)&&const DeepCollectionEquality().equals(other._cloudGoogleAssistant, _cloudGoogleAssistant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,sensor,alarmControlPanel,lock,weather,light,switchAsX,const DeepCollectionEquality().hash(_conversation),const DeepCollectionEquality().hash(_cloudAlexa),const DeepCollectionEquality().hash(_cloudGoogleAssistant));

@override
String toString() {
  return 'EntityRegistryOptions(number: $number, sensor: $sensor, alarmControlPanel: $alarmControlPanel, lock: $lock, weather: $weather, light: $light, switchAsX: $switchAsX, conversation: $conversation, cloudAlexa: $cloudAlexa, cloudGoogleAssistant: $cloudGoogleAssistant)';
}


}

/// @nodoc
abstract mixin class _$EntityRegistryOptionsCopyWith<$Res> implements $EntityRegistryOptionsCopyWith<$Res> {
  factory _$EntityRegistryOptionsCopyWith(_EntityRegistryOptions value, $Res Function(_EntityRegistryOptions) _then) = __$EntityRegistryOptionsCopyWithImpl;
@override @useResult
$Res call({
 NumberEntityOptions? number, SensorEntityOptions? sensor, AlarmControlPanelEntityOptions? alarmControlPanel, LockEntityOptions? lock, WeatherEntityOptions? weather, LightEntityOptions? light, SwitchAsXEntityOptions? switchAsX, Map<String, dynamic>? conversation,@JsonKey(name: 'cloud.alexa') Map<String, dynamic>? cloudAlexa,@JsonKey(name: 'cloud.google_assistant') Map<String, dynamic>? cloudGoogleAssistant
});


@override $NumberEntityOptionsCopyWith<$Res>? get number;@override $SensorEntityOptionsCopyWith<$Res>? get sensor;@override $AlarmControlPanelEntityOptionsCopyWith<$Res>? get alarmControlPanel;@override $LockEntityOptionsCopyWith<$Res>? get lock;@override $WeatherEntityOptionsCopyWith<$Res>? get weather;@override $LightEntityOptionsCopyWith<$Res>? get light;@override $SwitchAsXEntityOptionsCopyWith<$Res>? get switchAsX;

}
/// @nodoc
class __$EntityRegistryOptionsCopyWithImpl<$Res>
    implements _$EntityRegistryOptionsCopyWith<$Res> {
  __$EntityRegistryOptionsCopyWithImpl(this._self, this._then);

  final _EntityRegistryOptions _self;
  final $Res Function(_EntityRegistryOptions) _then;

/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = freezed,Object? sensor = freezed,Object? alarmControlPanel = freezed,Object? lock = freezed,Object? weather = freezed,Object? light = freezed,Object? switchAsX = freezed,Object? conversation = freezed,Object? cloudAlexa = freezed,Object? cloudGoogleAssistant = freezed,}) {
  return _then(_EntityRegistryOptions(
number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as NumberEntityOptions?,sensor: freezed == sensor ? _self.sensor : sensor // ignore: cast_nullable_to_non_nullable
as SensorEntityOptions?,alarmControlPanel: freezed == alarmControlPanel ? _self.alarmControlPanel : alarmControlPanel // ignore: cast_nullable_to_non_nullable
as AlarmControlPanelEntityOptions?,lock: freezed == lock ? _self.lock : lock // ignore: cast_nullable_to_non_nullable
as LockEntityOptions?,weather: freezed == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as WeatherEntityOptions?,light: freezed == light ? _self.light : light // ignore: cast_nullable_to_non_nullable
as LightEntityOptions?,switchAsX: freezed == switchAsX ? _self.switchAsX : switchAsX // ignore: cast_nullable_to_non_nullable
as SwitchAsXEntityOptions?,conversation: freezed == conversation ? _self._conversation : conversation // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,cloudAlexa: freezed == cloudAlexa ? _self._cloudAlexa : cloudAlexa // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,cloudGoogleAssistant: freezed == cloudGoogleAssistant ? _self._cloudGoogleAssistant : cloudGoogleAssistant // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NumberEntityOptionsCopyWith<$Res>? get number {
    if (_self.number == null) {
    return null;
  }

  return $NumberEntityOptionsCopyWith<$Res>(_self.number!, (value) {
    return _then(_self.copyWith(number: value));
  });
}/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SensorEntityOptionsCopyWith<$Res>? get sensor {
    if (_self.sensor == null) {
    return null;
  }

  return $SensorEntityOptionsCopyWith<$Res>(_self.sensor!, (value) {
    return _then(_self.copyWith(sensor: value));
  });
}/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlarmControlPanelEntityOptionsCopyWith<$Res>? get alarmControlPanel {
    if (_self.alarmControlPanel == null) {
    return null;
  }

  return $AlarmControlPanelEntityOptionsCopyWith<$Res>(_self.alarmControlPanel!, (value) {
    return _then(_self.copyWith(alarmControlPanel: value));
  });
}/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LockEntityOptionsCopyWith<$Res>? get lock {
    if (_self.lock == null) {
    return null;
  }

  return $LockEntityOptionsCopyWith<$Res>(_self.lock!, (value) {
    return _then(_self.copyWith(lock: value));
  });
}/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherEntityOptionsCopyWith<$Res>? get weather {
    if (_self.weather == null) {
    return null;
  }

  return $WeatherEntityOptionsCopyWith<$Res>(_self.weather!, (value) {
    return _then(_self.copyWith(weather: value));
  });
}/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LightEntityOptionsCopyWith<$Res>? get light {
    if (_self.light == null) {
    return null;
  }

  return $LightEntityOptionsCopyWith<$Res>(_self.light!, (value) {
    return _then(_self.copyWith(light: value));
  });
}/// Create a copy of EntityRegistryOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SwitchAsXEntityOptionsCopyWith<$Res>? get switchAsX {
    if (_self.switchAsX == null) {
    return null;
  }

  return $SwitchAsXEntityOptionsCopyWith<$Res>(_self.switchAsX!, (value) {
    return _then(_self.copyWith(switchAsX: value));
  });
}
}

// dart format on
