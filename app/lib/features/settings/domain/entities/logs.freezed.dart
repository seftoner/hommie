// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Log {

 DateTime get time; String get msg; LogLevel get level; String? get details;
/// Create a copy of Log
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogCopyWith<Log> get copyWith => _$LogCopyWithImpl<Log>(this as Log, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Log&&(identical(other.time, time) || other.time == time)&&(identical(other.msg, msg) || other.msg == msg)&&(identical(other.level, level) || other.level == level)&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode => Object.hash(runtimeType,time,msg,level,details);

@override
String toString() {
  return 'Log(time: $time, msg: $msg, level: $level, details: $details)';
}


}

/// @nodoc
abstract mixin class $LogCopyWith<$Res>  {
  factory $LogCopyWith(Log value, $Res Function(Log) _then) = _$LogCopyWithImpl;
@useResult
$Res call({
 DateTime time, String msg, LogLevel level, String? details
});




}
/// @nodoc
class _$LogCopyWithImpl<$Res>
    implements $LogCopyWith<$Res> {
  _$LogCopyWithImpl(this._self, this._then);

  final Log _self;
  final $Res Function(Log) _then;

/// Create a copy of Log
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? msg = null,Object? level = null,Object? details = freezed,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,msg: null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as LogLevel,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Log].
extension LogPatterns on Log {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Log value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Log() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Log value)  $default,){
final _that = this;
switch (_that) {
case _Log():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Log value)?  $default,){
final _that = this;
switch (_that) {
case _Log() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime time,  String msg,  LogLevel level,  String? details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Log() when $default != null:
return $default(_that.time,_that.msg,_that.level,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime time,  String msg,  LogLevel level,  String? details)  $default,) {final _that = this;
switch (_that) {
case _Log():
return $default(_that.time,_that.msg,_that.level,_that.details);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime time,  String msg,  LogLevel level,  String? details)?  $default,) {final _that = this;
switch (_that) {
case _Log() when $default != null:
return $default(_that.time,_that.msg,_that.level,_that.details);case _:
  return null;

}
}

}

/// @nodoc


class _Log implements Log {
   _Log({required this.time, required this.msg, required this.level, this.details});
  

@override final  DateTime time;
@override final  String msg;
@override final  LogLevel level;
@override final  String? details;

/// Create a copy of Log
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogCopyWith<_Log> get copyWith => __$LogCopyWithImpl<_Log>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Log&&(identical(other.time, time) || other.time == time)&&(identical(other.msg, msg) || other.msg == msg)&&(identical(other.level, level) || other.level == level)&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode => Object.hash(runtimeType,time,msg,level,details);

@override
String toString() {
  return 'Log(time: $time, msg: $msg, level: $level, details: $details)';
}


}

/// @nodoc
abstract mixin class _$LogCopyWith<$Res> implements $LogCopyWith<$Res> {
  factory _$LogCopyWith(_Log value, $Res Function(_Log) _then) = __$LogCopyWithImpl;
@override @useResult
$Res call({
 DateTime time, String msg, LogLevel level, String? details
});




}
/// @nodoc
class __$LogCopyWithImpl<$Res>
    implements _$LogCopyWith<$Res> {
  __$LogCopyWithImpl(this._self, this._then);

  final _Log _self;
  final $Res Function(_Log) _then;

/// Create a copy of Log
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? msg = null,Object? level = null,Object? details = freezed,}) {
  return _then(_Log(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,msg: null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as LogLevel,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
