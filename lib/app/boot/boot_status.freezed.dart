// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'boot_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BootStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BootStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BootStatus()';
}


}

/// @nodoc
class $BootStatusCopyWith<$Res>  {
$BootStatusCopyWith(BootStatus _, $Res Function(BootStatus) __);
}


/// Adds pattern-matching-related methods to [BootStatus].
extension BootStatusPatterns on BootStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BootReady value)?  ready,TResult Function( BootInProgress value)?  inProgress,TResult Function( BootFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BootReady() when ready != null:
return ready(_that);case BootInProgress() when inProgress != null:
return inProgress(_that);case BootFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BootReady value)  ready,required TResult Function( BootInProgress value)  inProgress,required TResult Function( BootFailure value)  failure,}){
final _that = this;
switch (_that) {
case BootReady():
return ready(_that);case BootInProgress():
return inProgress(_that);case BootFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BootReady value)?  ready,TResult? Function( BootInProgress value)?  inProgress,TResult? Function( BootFailure value)?  failure,}){
final _that = this;
switch (_that) {
case BootReady() when ready != null:
return ready(_that);case BootInProgress() when inProgress != null:
return inProgress(_that);case BootFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  ready,TResult Function()?  inProgress,TResult Function( Object error,  StackTrace stackTrace)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BootReady() when ready != null:
return ready();case BootInProgress() when inProgress != null:
return inProgress();case BootFailure() when failure != null:
return failure(_that.error,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  ready,required TResult Function()  inProgress,required TResult Function( Object error,  StackTrace stackTrace)  failure,}) {final _that = this;
switch (_that) {
case BootReady():
return ready();case BootInProgress():
return inProgress();case BootFailure():
return failure(_that.error,_that.stackTrace);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  ready,TResult? Function()?  inProgress,TResult? Function( Object error,  StackTrace stackTrace)?  failure,}) {final _that = this;
switch (_that) {
case BootReady() when ready != null:
return ready();case BootInProgress() when inProgress != null:
return inProgress();case BootFailure() when failure != null:
return failure(_that.error,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class BootReady implements BootStatus {
  const BootReady();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BootReady);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BootStatus.ready()';
}


}




/// @nodoc


class BootInProgress implements BootStatus {
  const BootInProgress();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BootInProgress);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BootStatus.inProgress()';
}


}




/// @nodoc


class BootFailure implements BootStatus {
  const BootFailure(this.error, this.stackTrace);
  

 final  Object error;
 final  StackTrace stackTrace;

/// Create a copy of BootStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BootFailureCopyWith<BootFailure> get copyWith => _$BootFailureCopyWithImpl<BootFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BootFailure&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error),stackTrace);

@override
String toString() {
  return 'BootStatus.failure(error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $BootFailureCopyWith<$Res> implements $BootStatusCopyWith<$Res> {
  factory $BootFailureCopyWith(BootFailure value, $Res Function(BootFailure) _then) = _$BootFailureCopyWithImpl;
@useResult
$Res call({
 Object error, StackTrace stackTrace
});




}
/// @nodoc
class _$BootFailureCopyWithImpl<$Res>
    implements $BootFailureCopyWith<$Res> {
  _$BootFailureCopyWithImpl(this._self, this._then);

  final BootFailure _self;
  final $Res Function(BootFailure) _then;

/// Create a copy of BootStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,Object? stackTrace = null,}) {
  return _then(BootFailure(
null == error ? _self.error : error ,null == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace,
  ));
}


}

// dart format on
