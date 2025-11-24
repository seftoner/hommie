// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_server_flow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddServerFlowStep {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddServerFlowStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return '_AddServerFlowStep()';
}


}

/// @nodoc
class _$AddServerFlowStepCopyWith<$Res>  {
_$AddServerFlowStepCopyWith(_AddServerFlowStep _, $Res Function(_AddServerFlowStep) __);
}


/// Adds pattern-matching-related methods to [_AddServerFlowStep].
extension _AddServerFlowStepPatterns on _AddServerFlowStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Discovery value)?  discovery,TResult Function( ManualEntry value)?  manualEntry,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Discovery() when discovery != null:
return discovery(_that);case ManualEntry() when manualEntry != null:
return manualEntry(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Discovery value)  discovery,required TResult Function( ManualEntry value)  manualEntry,}){
final _that = this;
switch (_that) {
case Discovery():
return discovery(_that);case ManualEntry():
return manualEntry(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Discovery value)?  discovery,TResult? Function( ManualEntry value)?  manualEntry,}){
final _that = this;
switch (_that) {
case Discovery() when discovery != null:
return discovery(_that);case ManualEntry() when manualEntry != null:
return manualEntry(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  discovery,TResult Function()?  manualEntry,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Discovery() when discovery != null:
return discovery();case ManualEntry() when manualEntry != null:
return manualEntry();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  discovery,required TResult Function()  manualEntry,}) {final _that = this;
switch (_that) {
case Discovery():
return discovery();case ManualEntry():
return manualEntry();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  discovery,TResult? Function()?  manualEntry,}) {final _that = this;
switch (_that) {
case Discovery() when discovery != null:
return discovery();case ManualEntry() when manualEntry != null:
return manualEntry();case _:
  return null;

}
}

}

/// @nodoc


class Discovery implements _AddServerFlowStep {
  const Discovery();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Discovery);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return '_AddServerFlowStep.discovery()';
}


}




/// @nodoc


class ManualEntry implements _AddServerFlowStep {
  const ManualEntry();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManualEntry);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return '_AddServerFlowStep.manualEntry()';
}


}




// dart format on
