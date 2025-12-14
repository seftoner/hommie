// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'light_color.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LightColor {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightColor);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LightColor()';
}


}

/// @nodoc
class $LightColorCopyWith<$Res>  {
$LightColorCopyWith(LightColor _, $Res Function(LightColor) __);
}


/// Adds pattern-matching-related methods to [LightColor].
extension LightColorPatterns on LightColor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LightColorTempKelvin value)?  colorTempKelvin,TResult Function( LightColorHsColor value)?  hsColor,TResult Function( LightColorRgbColor value)?  rgbColor,TResult Function( LightColorRgbwColor value)?  rgbwColor,TResult Function( LightColorRgbwwColor value)?  rgbwwColor,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LightColorTempKelvin() when colorTempKelvin != null:
return colorTempKelvin(_that);case LightColorHsColor() when hsColor != null:
return hsColor(_that);case LightColorRgbColor() when rgbColor != null:
return rgbColor(_that);case LightColorRgbwColor() when rgbwColor != null:
return rgbwColor(_that);case LightColorRgbwwColor() when rgbwwColor != null:
return rgbwwColor(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LightColorTempKelvin value)  colorTempKelvin,required TResult Function( LightColorHsColor value)  hsColor,required TResult Function( LightColorRgbColor value)  rgbColor,required TResult Function( LightColorRgbwColor value)  rgbwColor,required TResult Function( LightColorRgbwwColor value)  rgbwwColor,}){
final _that = this;
switch (_that) {
case LightColorTempKelvin():
return colorTempKelvin(_that);case LightColorHsColor():
return hsColor(_that);case LightColorRgbColor():
return rgbColor(_that);case LightColorRgbwColor():
return rgbwColor(_that);case LightColorRgbwwColor():
return rgbwwColor(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LightColorTempKelvin value)?  colorTempKelvin,TResult? Function( LightColorHsColor value)?  hsColor,TResult? Function( LightColorRgbColor value)?  rgbColor,TResult? Function( LightColorRgbwColor value)?  rgbwColor,TResult? Function( LightColorRgbwwColor value)?  rgbwwColor,}){
final _that = this;
switch (_that) {
case LightColorTempKelvin() when colorTempKelvin != null:
return colorTempKelvin(_that);case LightColorHsColor() when hsColor != null:
return hsColor(_that);case LightColorRgbColor() when rgbColor != null:
return rgbColor(_that);case LightColorRgbwColor() when rgbwColor != null:
return rgbwColor(_that);case LightColorRgbwwColor() when rgbwwColor != null:
return rgbwwColor(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@JsonKey(name: 'color_temp_kelvin')  int colorTempKelvin)?  colorTempKelvin,TResult Function(@JsonKey(name: 'hs_color')  List<num> hsColor)?  hsColor,TResult Function(@JsonKey(name: 'rgb_color')  List<num> rgbColor)?  rgbColor,TResult Function(@JsonKey(name: 'rgbw_color')  List<num> rgbwColor)?  rgbwColor,TResult Function(@JsonKey(name: 'rgbww_color')  List<num> rgbwwColor)?  rgbwwColor,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LightColorTempKelvin() when colorTempKelvin != null:
return colorTempKelvin(_that.colorTempKelvin);case LightColorHsColor() when hsColor != null:
return hsColor(_that.hsColor);case LightColorRgbColor() when rgbColor != null:
return rgbColor(_that.rgbColor);case LightColorRgbwColor() when rgbwColor != null:
return rgbwColor(_that.rgbwColor);case LightColorRgbwwColor() when rgbwwColor != null:
return rgbwwColor(_that.rgbwwColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@JsonKey(name: 'color_temp_kelvin')  int colorTempKelvin)  colorTempKelvin,required TResult Function(@JsonKey(name: 'hs_color')  List<num> hsColor)  hsColor,required TResult Function(@JsonKey(name: 'rgb_color')  List<num> rgbColor)  rgbColor,required TResult Function(@JsonKey(name: 'rgbw_color')  List<num> rgbwColor)  rgbwColor,required TResult Function(@JsonKey(name: 'rgbww_color')  List<num> rgbwwColor)  rgbwwColor,}) {final _that = this;
switch (_that) {
case LightColorTempKelvin():
return colorTempKelvin(_that.colorTempKelvin);case LightColorHsColor():
return hsColor(_that.hsColor);case LightColorRgbColor():
return rgbColor(_that.rgbColor);case LightColorRgbwColor():
return rgbwColor(_that.rgbwColor);case LightColorRgbwwColor():
return rgbwwColor(_that.rgbwwColor);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@JsonKey(name: 'color_temp_kelvin')  int colorTempKelvin)?  colorTempKelvin,TResult? Function(@JsonKey(name: 'hs_color')  List<num> hsColor)?  hsColor,TResult? Function(@JsonKey(name: 'rgb_color')  List<num> rgbColor)?  rgbColor,TResult? Function(@JsonKey(name: 'rgbw_color')  List<num> rgbwColor)?  rgbwColor,TResult? Function(@JsonKey(name: 'rgbww_color')  List<num> rgbwwColor)?  rgbwwColor,}) {final _that = this;
switch (_that) {
case LightColorTempKelvin() when colorTempKelvin != null:
return colorTempKelvin(_that.colorTempKelvin);case LightColorHsColor() when hsColor != null:
return hsColor(_that.hsColor);case LightColorRgbColor() when rgbColor != null:
return rgbColor(_that.rgbColor);case LightColorRgbwColor() when rgbwColor != null:
return rgbwColor(_that.rgbwColor);case LightColorRgbwwColor() when rgbwwColor != null:
return rgbwwColor(_that.rgbwwColor);case _:
  return null;

}
}

}

/// @nodoc


class LightColorTempKelvin implements LightColor {
  const LightColorTempKelvin({@JsonKey(name: 'color_temp_kelvin') required this.colorTempKelvin});
  

@JsonKey(name: 'color_temp_kelvin') final  int colorTempKelvin;

/// Create a copy of LightColor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LightColorTempKelvinCopyWith<LightColorTempKelvin> get copyWith => _$LightColorTempKelvinCopyWithImpl<LightColorTempKelvin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightColorTempKelvin&&(identical(other.colorTempKelvin, colorTempKelvin) || other.colorTempKelvin == colorTempKelvin));
}


@override
int get hashCode => Object.hash(runtimeType,colorTempKelvin);

@override
String toString() {
  return 'LightColor.colorTempKelvin(colorTempKelvin: $colorTempKelvin)';
}


}

/// @nodoc
abstract mixin class $LightColorTempKelvinCopyWith<$Res> implements $LightColorCopyWith<$Res> {
  factory $LightColorTempKelvinCopyWith(LightColorTempKelvin value, $Res Function(LightColorTempKelvin) _then) = _$LightColorTempKelvinCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'color_temp_kelvin') int colorTempKelvin
});




}
/// @nodoc
class _$LightColorTempKelvinCopyWithImpl<$Res>
    implements $LightColorTempKelvinCopyWith<$Res> {
  _$LightColorTempKelvinCopyWithImpl(this._self, this._then);

  final LightColorTempKelvin _self;
  final $Res Function(LightColorTempKelvin) _then;

/// Create a copy of LightColor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? colorTempKelvin = null,}) {
  return _then(LightColorTempKelvin(
colorTempKelvin: null == colorTempKelvin ? _self.colorTempKelvin : colorTempKelvin // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class LightColorHsColor implements LightColor {
  const LightColorHsColor({@JsonKey(name: 'hs_color') required final  List<num> hsColor}): _hsColor = hsColor;
  

 final  List<num> _hsColor;
@JsonKey(name: 'hs_color') List<num> get hsColor {
  if (_hsColor is EqualUnmodifiableListView) return _hsColor;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hsColor);
}


/// Create a copy of LightColor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LightColorHsColorCopyWith<LightColorHsColor> get copyWith => _$LightColorHsColorCopyWithImpl<LightColorHsColor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightColorHsColor&&const DeepCollectionEquality().equals(other._hsColor, _hsColor));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_hsColor));

@override
String toString() {
  return 'LightColor.hsColor(hsColor: $hsColor)';
}


}

/// @nodoc
abstract mixin class $LightColorHsColorCopyWith<$Res> implements $LightColorCopyWith<$Res> {
  factory $LightColorHsColorCopyWith(LightColorHsColor value, $Res Function(LightColorHsColor) _then) = _$LightColorHsColorCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'hs_color') List<num> hsColor
});




}
/// @nodoc
class _$LightColorHsColorCopyWithImpl<$Res>
    implements $LightColorHsColorCopyWith<$Res> {
  _$LightColorHsColorCopyWithImpl(this._self, this._then);

  final LightColorHsColor _self;
  final $Res Function(LightColorHsColor) _then;

/// Create a copy of LightColor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hsColor = null,}) {
  return _then(LightColorHsColor(
hsColor: null == hsColor ? _self._hsColor : hsColor // ignore: cast_nullable_to_non_nullable
as List<num>,
  ));
}


}

/// @nodoc


class LightColorRgbColor implements LightColor {
  const LightColorRgbColor({@JsonKey(name: 'rgb_color') required final  List<num> rgbColor}): _rgbColor = rgbColor;
  

 final  List<num> _rgbColor;
@JsonKey(name: 'rgb_color') List<num> get rgbColor {
  if (_rgbColor is EqualUnmodifiableListView) return _rgbColor;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rgbColor);
}


/// Create a copy of LightColor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LightColorRgbColorCopyWith<LightColorRgbColor> get copyWith => _$LightColorRgbColorCopyWithImpl<LightColorRgbColor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightColorRgbColor&&const DeepCollectionEquality().equals(other._rgbColor, _rgbColor));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rgbColor));

@override
String toString() {
  return 'LightColor.rgbColor(rgbColor: $rgbColor)';
}


}

/// @nodoc
abstract mixin class $LightColorRgbColorCopyWith<$Res> implements $LightColorCopyWith<$Res> {
  factory $LightColorRgbColorCopyWith(LightColorRgbColor value, $Res Function(LightColorRgbColor) _then) = _$LightColorRgbColorCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'rgb_color') List<num> rgbColor
});




}
/// @nodoc
class _$LightColorRgbColorCopyWithImpl<$Res>
    implements $LightColorRgbColorCopyWith<$Res> {
  _$LightColorRgbColorCopyWithImpl(this._self, this._then);

  final LightColorRgbColor _self;
  final $Res Function(LightColorRgbColor) _then;

/// Create a copy of LightColor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rgbColor = null,}) {
  return _then(LightColorRgbColor(
rgbColor: null == rgbColor ? _self._rgbColor : rgbColor // ignore: cast_nullable_to_non_nullable
as List<num>,
  ));
}


}

/// @nodoc


class LightColorRgbwColor implements LightColor {
  const LightColorRgbwColor({@JsonKey(name: 'rgbw_color') required final  List<num> rgbwColor}): _rgbwColor = rgbwColor;
  

 final  List<num> _rgbwColor;
@JsonKey(name: 'rgbw_color') List<num> get rgbwColor {
  if (_rgbwColor is EqualUnmodifiableListView) return _rgbwColor;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rgbwColor);
}


/// Create a copy of LightColor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LightColorRgbwColorCopyWith<LightColorRgbwColor> get copyWith => _$LightColorRgbwColorCopyWithImpl<LightColorRgbwColor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightColorRgbwColor&&const DeepCollectionEquality().equals(other._rgbwColor, _rgbwColor));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rgbwColor));

@override
String toString() {
  return 'LightColor.rgbwColor(rgbwColor: $rgbwColor)';
}


}

/// @nodoc
abstract mixin class $LightColorRgbwColorCopyWith<$Res> implements $LightColorCopyWith<$Res> {
  factory $LightColorRgbwColorCopyWith(LightColorRgbwColor value, $Res Function(LightColorRgbwColor) _then) = _$LightColorRgbwColorCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'rgbw_color') List<num> rgbwColor
});




}
/// @nodoc
class _$LightColorRgbwColorCopyWithImpl<$Res>
    implements $LightColorRgbwColorCopyWith<$Res> {
  _$LightColorRgbwColorCopyWithImpl(this._self, this._then);

  final LightColorRgbwColor _self;
  final $Res Function(LightColorRgbwColor) _then;

/// Create a copy of LightColor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rgbwColor = null,}) {
  return _then(LightColorRgbwColor(
rgbwColor: null == rgbwColor ? _self._rgbwColor : rgbwColor // ignore: cast_nullable_to_non_nullable
as List<num>,
  ));
}


}

/// @nodoc


class LightColorRgbwwColor implements LightColor {
  const LightColorRgbwwColor({@JsonKey(name: 'rgbww_color') required final  List<num> rgbwwColor}): _rgbwwColor = rgbwwColor;
  

 final  List<num> _rgbwwColor;
@JsonKey(name: 'rgbww_color') List<num> get rgbwwColor {
  if (_rgbwwColor is EqualUnmodifiableListView) return _rgbwwColor;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rgbwwColor);
}


/// Create a copy of LightColor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LightColorRgbwwColorCopyWith<LightColorRgbwwColor> get copyWith => _$LightColorRgbwwColorCopyWithImpl<LightColorRgbwwColor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightColorRgbwwColor&&const DeepCollectionEquality().equals(other._rgbwwColor, _rgbwwColor));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rgbwwColor));

@override
String toString() {
  return 'LightColor.rgbwwColor(rgbwwColor: $rgbwwColor)';
}


}

/// @nodoc
abstract mixin class $LightColorRgbwwColorCopyWith<$Res> implements $LightColorCopyWith<$Res> {
  factory $LightColorRgbwwColorCopyWith(LightColorRgbwwColor value, $Res Function(LightColorRgbwwColor) _then) = _$LightColorRgbwwColorCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'rgbww_color') List<num> rgbwwColor
});




}
/// @nodoc
class _$LightColorRgbwwColorCopyWithImpl<$Res>
    implements $LightColorRgbwwColorCopyWith<$Res> {
  _$LightColorRgbwwColorCopyWithImpl(this._self, this._then);

  final LightColorRgbwwColor _self;
  final $Res Function(LightColorRgbwwColor) _then;

/// Create a copy of LightColor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rgbwwColor = null,}) {
  return _then(LightColorRgbwwColor(
rgbwwColor: null == rgbwwColor ? _self._rgbwwColor : rgbwwColor // ignore: cast_nullable_to_non_nullable
as List<num>,
  ));
}


}

// dart format on
