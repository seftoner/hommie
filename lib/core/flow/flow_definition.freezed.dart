// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flow_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FlowState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlowState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FlowState()';
}


}

/// @nodoc
class $FlowStateCopyWith<$Res>  {
$FlowStateCopyWith(FlowState _, $Res Function(FlowState) __);
}


/// Adds pattern-matching-related methods to [FlowState].
extension FlowStatePatterns on FlowState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FlowIdle value)?  idle,TResult Function( FlowInStep value)?  inStep,TResult Function( FlowDone value)?  done,TResult Function( FlowError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FlowIdle() when idle != null:
return idle(_that);case FlowInStep() when inStep != null:
return inStep(_that);case FlowDone() when done != null:
return done(_that);case FlowError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FlowIdle value)  idle,required TResult Function( FlowInStep value)  inStep,required TResult Function( FlowDone value)  done,required TResult Function( FlowError value)  error,}){
final _that = this;
switch (_that) {
case FlowIdle():
return idle(_that);case FlowInStep():
return inStep(_that);case FlowDone():
return done(_that);case FlowError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FlowIdle value)?  idle,TResult? Function( FlowInStep value)?  inStep,TResult? Function( FlowDone value)?  done,TResult? Function( FlowError value)?  error,}){
final _that = this;
switch (_that) {
case FlowIdle() when idle != null:
return idle(_that);case FlowInStep() when inStep != null:
return inStep(_that);case FlowDone() when done != null:
return done(_that);case FlowError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( StepId stepId,  int index)?  inStep,TResult Function()?  done,TResult Function( StepId stepId,  Object error,  StackTrace stackTrace)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FlowIdle() when idle != null:
return idle();case FlowInStep() when inStep != null:
return inStep(_that.stepId,_that.index);case FlowDone() when done != null:
return done();case FlowError() when error != null:
return error(_that.stepId,_that.error,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( StepId stepId,  int index)  inStep,required TResult Function()  done,required TResult Function( StepId stepId,  Object error,  StackTrace stackTrace)  error,}) {final _that = this;
switch (_that) {
case FlowIdle():
return idle();case FlowInStep():
return inStep(_that.stepId,_that.index);case FlowDone():
return done();case FlowError():
return error(_that.stepId,_that.error,_that.stackTrace);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( StepId stepId,  int index)?  inStep,TResult? Function()?  done,TResult? Function( StepId stepId,  Object error,  StackTrace stackTrace)?  error,}) {final _that = this;
switch (_that) {
case FlowIdle() when idle != null:
return idle();case FlowInStep() when inStep != null:
return inStep(_that.stepId,_that.index);case FlowDone() when done != null:
return done();case FlowError() when error != null:
return error(_that.stepId,_that.error,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class FlowIdle implements FlowState {
  const FlowIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlowIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FlowState.idle()';
}


}




/// @nodoc


class FlowInStep implements FlowState {
  const FlowInStep(this.stepId, this.index);
  

 final  StepId stepId;
 final  int index;

/// Create a copy of FlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlowInStepCopyWith<FlowInStep> get copyWith => _$FlowInStepCopyWithImpl<FlowInStep>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlowInStep&&(identical(other.stepId, stepId) || other.stepId == stepId)&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,stepId,index);

@override
String toString() {
  return 'FlowState.inStep(stepId: $stepId, index: $index)';
}


}

/// @nodoc
abstract mixin class $FlowInStepCopyWith<$Res> implements $FlowStateCopyWith<$Res> {
  factory $FlowInStepCopyWith(FlowInStep value, $Res Function(FlowInStep) _then) = _$FlowInStepCopyWithImpl;
@useResult
$Res call({
 StepId stepId, int index
});




}
/// @nodoc
class _$FlowInStepCopyWithImpl<$Res>
    implements $FlowInStepCopyWith<$Res> {
  _$FlowInStepCopyWithImpl(this._self, this._then);

  final FlowInStep _self;
  final $Res Function(FlowInStep) _then;

/// Create a copy of FlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stepId = null,Object? index = null,}) {
  return _then(FlowInStep(
null == stepId ? _self.stepId : stepId // ignore: cast_nullable_to_non_nullable
as StepId,null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class FlowDone implements FlowState {
  const FlowDone();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlowDone);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FlowState.done()';
}


}




/// @nodoc


class FlowError implements FlowState {
  const FlowError(this.stepId, this.error, this.stackTrace);
  

 final  StepId stepId;
 final  Object error;
 final  StackTrace stackTrace;

/// Create a copy of FlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlowErrorCopyWith<FlowError> get copyWith => _$FlowErrorCopyWithImpl<FlowError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlowError&&(identical(other.stepId, stepId) || other.stepId == stepId)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,stepId,const DeepCollectionEquality().hash(error),stackTrace);

@override
String toString() {
  return 'FlowState.error(stepId: $stepId, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $FlowErrorCopyWith<$Res> implements $FlowStateCopyWith<$Res> {
  factory $FlowErrorCopyWith(FlowError value, $Res Function(FlowError) _then) = _$FlowErrorCopyWithImpl;
@useResult
$Res call({
 StepId stepId, Object error, StackTrace stackTrace
});




}
/// @nodoc
class _$FlowErrorCopyWithImpl<$Res>
    implements $FlowErrorCopyWith<$Res> {
  _$FlowErrorCopyWithImpl(this._self, this._then);

  final FlowError _self;
  final $Res Function(FlowError) _then;

/// Create a copy of FlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stepId = null,Object? error = null,Object? stackTrace = null,}) {
  return _then(FlowError(
null == stepId ? _self.stepId : stepId // ignore: cast_nullable_to_non_nullable
as StepId,null == error ? _self.error : error ,null == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace,
  ));
}


}

// dart format on
