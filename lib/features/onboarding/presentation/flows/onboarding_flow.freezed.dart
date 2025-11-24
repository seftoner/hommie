// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_flow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingStep {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingStep()';
}


}

/// @nodoc
class $OnboardingStepCopyWith<$Res>  {
$OnboardingStepCopyWith(OnboardingStep _, $Res Function(OnboardingStep) __);
}


/// Adds pattern-matching-related methods to [OnboardingStep].
extension OnboardingStepPatterns on OnboardingStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WelcomeOne value)?  welcomeOne,TResult Function( Permissions value)?  permissions,TResult Function( AddServer value)?  addServer,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WelcomeOne() when welcomeOne != null:
return welcomeOne(_that);case Permissions() when permissions != null:
return permissions(_that);case AddServer() when addServer != null:
return addServer(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WelcomeOne value)  welcomeOne,required TResult Function( Permissions value)  permissions,required TResult Function( AddServer value)  addServer,}){
final _that = this;
switch (_that) {
case WelcomeOne():
return welcomeOne(_that);case Permissions():
return permissions(_that);case AddServer():
return addServer(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WelcomeOne value)?  welcomeOne,TResult? Function( Permissions value)?  permissions,TResult? Function( AddServer value)?  addServer,}){
final _that = this;
switch (_that) {
case WelcomeOne() when welcomeOne != null:
return welcomeOne(_that);case Permissions() when permissions != null:
return permissions(_that);case AddServer() when addServer != null:
return addServer(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  welcomeOne,TResult Function()?  permissions,TResult Function()?  addServer,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WelcomeOne() when welcomeOne != null:
return welcomeOne();case Permissions() when permissions != null:
return permissions();case AddServer() when addServer != null:
return addServer();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  welcomeOne,required TResult Function()  permissions,required TResult Function()  addServer,}) {final _that = this;
switch (_that) {
case WelcomeOne():
return welcomeOne();case Permissions():
return permissions();case AddServer():
return addServer();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  welcomeOne,TResult? Function()?  permissions,TResult? Function()?  addServer,}) {final _that = this;
switch (_that) {
case WelcomeOne() when welcomeOne != null:
return welcomeOne();case Permissions() when permissions != null:
return permissions();case AddServer() when addServer != null:
return addServer();case _:
  return null;

}
}

}

/// @nodoc


class WelcomeOne implements OnboardingStep {
  const WelcomeOne();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WelcomeOne);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingStep.welcomeOne()';
}


}




/// @nodoc


class Permissions implements OnboardingStep {
  const Permissions();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Permissions);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingStep.permissions()';
}


}




/// @nodoc


class AddServer implements OnboardingStep {
  const AddServer();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddServer);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingStep.addServer()';
}


}




// dart format on
