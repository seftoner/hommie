// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hass_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EntityStateRemove {

 List<String> get a;
/// Create a copy of EntityStateRemove
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntityStateRemoveCopyWith<EntityStateRemove> get copyWith => _$EntityStateRemoveCopyWithImpl<EntityStateRemove>(this as EntityStateRemove, _$identity);

  /// Serializes this EntityStateRemove to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntityStateRemove&&const DeepCollectionEquality().equals(other.a, a));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(a));

@override
String toString() {
  return 'EntityStateRemove(a: $a)';
}


}

/// @nodoc
abstract mixin class $EntityStateRemoveCopyWith<$Res>  {
  factory $EntityStateRemoveCopyWith(EntityStateRemove value, $Res Function(EntityStateRemove) _then) = _$EntityStateRemoveCopyWithImpl;
@useResult
$Res call({
 List<String> a
});




}
/// @nodoc
class _$EntityStateRemoveCopyWithImpl<$Res>
    implements $EntityStateRemoveCopyWith<$Res> {
  _$EntityStateRemoveCopyWithImpl(this._self, this._then);

  final EntityStateRemove _self;
  final $Res Function(EntityStateRemove) _then;

/// Create a copy of EntityStateRemove
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? a = null,}) {
  return _then(_self.copyWith(
a: null == a ? _self.a : a // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [EntityStateRemove].
extension EntityStateRemovePatterns on EntityStateRemove {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntityStateRemove value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntityStateRemove() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntityStateRemove value)  $default,){
final _that = this;
switch (_that) {
case _EntityStateRemove():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntityStateRemove value)?  $default,){
final _that = this;
switch (_that) {
case _EntityStateRemove() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> a)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntityStateRemove() when $default != null:
return $default(_that.a);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> a)  $default,) {final _that = this;
switch (_that) {
case _EntityStateRemove():
return $default(_that.a);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> a)?  $default,) {final _that = this;
switch (_that) {
case _EntityStateRemove() when $default != null:
return $default(_that.a);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EntityStateRemove implements EntityStateRemove {
   _EntityStateRemove(final  List<String> a): _a = a;
  factory _EntityStateRemove.fromJson(Map<String, dynamic> json) => _$EntityStateRemoveFromJson(json);

 final  List<String> _a;
@override List<String> get a {
  if (_a is EqualUnmodifiableListView) return _a;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_a);
}


/// Create a copy of EntityStateRemove
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntityStateRemoveCopyWith<_EntityStateRemove> get copyWith => __$EntityStateRemoveCopyWithImpl<_EntityStateRemove>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntityStateRemoveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntityStateRemove&&const DeepCollectionEquality().equals(other._a, _a));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_a));

@override
String toString() {
  return 'EntityStateRemove(a: $a)';
}


}

/// @nodoc
abstract mixin class _$EntityStateRemoveCopyWith<$Res> implements $EntityStateRemoveCopyWith<$Res> {
  factory _$EntityStateRemoveCopyWith(_EntityStateRemove value, $Res Function(_EntityStateRemove) _then) = __$EntityStateRemoveCopyWithImpl;
@override @useResult
$Res call({
 List<String> a
});




}
/// @nodoc
class __$EntityStateRemoveCopyWithImpl<$Res>
    implements _$EntityStateRemoveCopyWith<$Res> {
  __$EntityStateRemoveCopyWithImpl(this._self, this._then);

  final _EntityStateRemove _self;
  final $Res Function(_EntityStateRemove) _then;

/// Create a copy of EntityStateRemove
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? a = null,}) {
  return _then(_EntityStateRemove(
null == a ? _self._a : a // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$EntityState {

@JsonKey(name: 's') String? get state;@JsonKey(name: 'a') Map<String, dynamic>? get attributes;@JsonKey(name: 'c') Context? get context;@JsonKey(name: 'ls') double? get last_changed;@JsonKey(name: 'lu') double? get last_updated;
/// Create a copy of EntityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntityStateCopyWith<EntityState> get copyWith => _$EntityStateCopyWithImpl<EntityState>(this as EntityState, _$identity);

  /// Serializes this EntityState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntityState&&(identical(other.state, state) || other.state == state)&&const DeepCollectionEquality().equals(other.attributes, attributes)&&(identical(other.context, context) || other.context == context)&&(identical(other.last_changed, last_changed) || other.last_changed == last_changed)&&(identical(other.last_updated, last_updated) || other.last_updated == last_updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,state,const DeepCollectionEquality().hash(attributes),context,last_changed,last_updated);

@override
String toString() {
  return 'EntityState(state: $state, attributes: $attributes, context: $context, last_changed: $last_changed, last_updated: $last_updated)';
}


}

/// @nodoc
abstract mixin class $EntityStateCopyWith<$Res>  {
  factory $EntityStateCopyWith(EntityState value, $Res Function(EntityState) _then) = _$EntityStateCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 's') String? state,@JsonKey(name: 'a') Map<String, dynamic>? attributes,@JsonKey(name: 'c') Context? context,@JsonKey(name: 'ls') double? last_changed,@JsonKey(name: 'lu') double? last_updated
});


$ContextCopyWith<$Res>? get context;

}
/// @nodoc
class _$EntityStateCopyWithImpl<$Res>
    implements $EntityStateCopyWith<$Res> {
  _$EntityStateCopyWithImpl(this._self, this._then);

  final EntityState _self;
  final $Res Function(EntityState) _then;

/// Create a copy of EntityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = freezed,Object? attributes = freezed,Object? context = freezed,Object? last_changed = freezed,Object? last_updated = freezed,}) {
  return _then(_self.copyWith(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,context: freezed == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Context?,last_changed: freezed == last_changed ? _self.last_changed : last_changed // ignore: cast_nullable_to_non_nullable
as double?,last_updated: freezed == last_updated ? _self.last_updated : last_updated // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of EntityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCopyWith<$Res>? get context {
    if (_self.context == null) {
    return null;
  }

  return $ContextCopyWith<$Res>(_self.context!, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// Adds pattern-matching-related methods to [EntityState].
extension EntityStatePatterns on EntityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntityState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntityState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntityState value)  $default,){
final _that = this;
switch (_that) {
case _EntityState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntityState value)?  $default,){
final _that = this;
switch (_that) {
case _EntityState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 's')  String? state, @JsonKey(name: 'a')  Map<String, dynamic>? attributes, @JsonKey(name: 'c')  Context? context, @JsonKey(name: 'ls')  double? last_changed, @JsonKey(name: 'lu')  double? last_updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntityState() when $default != null:
return $default(_that.state,_that.attributes,_that.context,_that.last_changed,_that.last_updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 's')  String? state, @JsonKey(name: 'a')  Map<String, dynamic>? attributes, @JsonKey(name: 'c')  Context? context, @JsonKey(name: 'ls')  double? last_changed, @JsonKey(name: 'lu')  double? last_updated)  $default,) {final _that = this;
switch (_that) {
case _EntityState():
return $default(_that.state,_that.attributes,_that.context,_that.last_changed,_that.last_updated);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 's')  String? state, @JsonKey(name: 'a')  Map<String, dynamic>? attributes, @JsonKey(name: 'c')  Context? context, @JsonKey(name: 'ls')  double? last_changed, @JsonKey(name: 'lu')  double? last_updated)?  $default,) {final _that = this;
switch (_that) {
case _EntityState() when $default != null:
return $default(_that.state,_that.attributes,_that.context,_that.last_changed,_that.last_updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EntityState implements EntityState {
   _EntityState({@JsonKey(name: 's') this.state, @JsonKey(name: 'a') final  Map<String, dynamic>? attributes, @JsonKey(name: 'c') this.context, @JsonKey(name: 'ls') this.last_changed, @JsonKey(name: 'lu') this.last_updated}): _attributes = attributes;
  factory _EntityState.fromJson(Map<String, dynamic> json) => _$EntityStateFromJson(json);

@override@JsonKey(name: 's') final  String? state;
 final  Map<String, dynamic>? _attributes;
@override@JsonKey(name: 'a') Map<String, dynamic>? get attributes {
  final value = _attributes;
  if (value == null) return null;
  if (_attributes is EqualUnmodifiableMapView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'c') final  Context? context;
@override@JsonKey(name: 'ls') final  double? last_changed;
@override@JsonKey(name: 'lu') final  double? last_updated;

/// Create a copy of EntityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntityStateCopyWith<_EntityState> get copyWith => __$EntityStateCopyWithImpl<_EntityState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntityStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntityState&&(identical(other.state, state) || other.state == state)&&const DeepCollectionEquality().equals(other._attributes, _attributes)&&(identical(other.context, context) || other.context == context)&&(identical(other.last_changed, last_changed) || other.last_changed == last_changed)&&(identical(other.last_updated, last_updated) || other.last_updated == last_updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,state,const DeepCollectionEquality().hash(_attributes),context,last_changed,last_updated);

@override
String toString() {
  return 'EntityState(state: $state, attributes: $attributes, context: $context, last_changed: $last_changed, last_updated: $last_updated)';
}


}

/// @nodoc
abstract mixin class _$EntityStateCopyWith<$Res> implements $EntityStateCopyWith<$Res> {
  factory _$EntityStateCopyWith(_EntityState value, $Res Function(_EntityState) _then) = __$EntityStateCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 's') String? state,@JsonKey(name: 'a') Map<String, dynamic>? attributes,@JsonKey(name: 'c') Context? context,@JsonKey(name: 'ls') double? last_changed,@JsonKey(name: 'lu') double? last_updated
});


@override $ContextCopyWith<$Res>? get context;

}
/// @nodoc
class __$EntityStateCopyWithImpl<$Res>
    implements _$EntityStateCopyWith<$Res> {
  __$EntityStateCopyWithImpl(this._self, this._then);

  final _EntityState _self;
  final $Res Function(_EntityState) _then;

/// Create a copy of EntityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = freezed,Object? attributes = freezed,Object? context = freezed,Object? last_changed = freezed,Object? last_updated = freezed,}) {
  return _then(_EntityState(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,attributes: freezed == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,context: freezed == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Context?,last_changed: freezed == last_changed ? _self.last_changed : last_changed // ignore: cast_nullable_to_non_nullable
as double?,last_updated: freezed == last_updated ? _self.last_updated : last_updated // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of EntityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCopyWith<$Res>? get context {
    if (_self.context == null) {
    return null;
  }

  return $ContextCopyWith<$Res>(_self.context!, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// @nodoc
mixin _$EntityDiff {

@JsonKey(name: '+') EntityState? get add;@JsonKey(name: '-') EntityStateRemove? get remove;
/// Create a copy of EntityDiff
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntityDiffCopyWith<EntityDiff> get copyWith => _$EntityDiffCopyWithImpl<EntityDiff>(this as EntityDiff, _$identity);

  /// Serializes this EntityDiff to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntityDiff&&(identical(other.add, add) || other.add == add)&&(identical(other.remove, remove) || other.remove == remove));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,add,remove);

@override
String toString() {
  return 'EntityDiff(add: $add, remove: $remove)';
}


}

/// @nodoc
abstract mixin class $EntityDiffCopyWith<$Res>  {
  factory $EntityDiffCopyWith(EntityDiff value, $Res Function(EntityDiff) _then) = _$EntityDiffCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '+') EntityState? add,@JsonKey(name: '-') EntityStateRemove? remove
});


$EntityStateCopyWith<$Res>? get add;$EntityStateRemoveCopyWith<$Res>? get remove;

}
/// @nodoc
class _$EntityDiffCopyWithImpl<$Res>
    implements $EntityDiffCopyWith<$Res> {
  _$EntityDiffCopyWithImpl(this._self, this._then);

  final EntityDiff _self;
  final $Res Function(EntityDiff) _then;

/// Create a copy of EntityDiff
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? add = freezed,Object? remove = freezed,}) {
  return _then(_self.copyWith(
add: freezed == add ? _self.add : add // ignore: cast_nullable_to_non_nullable
as EntityState?,remove: freezed == remove ? _self.remove : remove // ignore: cast_nullable_to_non_nullable
as EntityStateRemove?,
  ));
}
/// Create a copy of EntityDiff
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntityStateCopyWith<$Res>? get add {
    if (_self.add == null) {
    return null;
  }

  return $EntityStateCopyWith<$Res>(_self.add!, (value) {
    return _then(_self.copyWith(add: value));
  });
}/// Create a copy of EntityDiff
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntityStateRemoveCopyWith<$Res>? get remove {
    if (_self.remove == null) {
    return null;
  }

  return $EntityStateRemoveCopyWith<$Res>(_self.remove!, (value) {
    return _then(_self.copyWith(remove: value));
  });
}
}


/// Adds pattern-matching-related methods to [EntityDiff].
extension EntityDiffPatterns on EntityDiff {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntityDiff value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntityDiff() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntityDiff value)  $default,){
final _that = this;
switch (_that) {
case _EntityDiff():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntityDiff value)?  $default,){
final _that = this;
switch (_that) {
case _EntityDiff() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '+')  EntityState? add, @JsonKey(name: '-')  EntityStateRemove? remove)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntityDiff() when $default != null:
return $default(_that.add,_that.remove);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '+')  EntityState? add, @JsonKey(name: '-')  EntityStateRemove? remove)  $default,) {final _that = this;
switch (_that) {
case _EntityDiff():
return $default(_that.add,_that.remove);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '+')  EntityState? add, @JsonKey(name: '-')  EntityStateRemove? remove)?  $default,) {final _that = this;
switch (_that) {
case _EntityDiff() when $default != null:
return $default(_that.add,_that.remove);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EntityDiff implements EntityDiff {
   _EntityDiff({@JsonKey(name: '+') this.add, @JsonKey(name: '-') this.remove});
  factory _EntityDiff.fromJson(Map<String, dynamic> json) => _$EntityDiffFromJson(json);

@override@JsonKey(name: '+') final  EntityState? add;
@override@JsonKey(name: '-') final  EntityStateRemove? remove;

/// Create a copy of EntityDiff
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntityDiffCopyWith<_EntityDiff> get copyWith => __$EntityDiffCopyWithImpl<_EntityDiff>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntityDiffToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntityDiff&&(identical(other.add, add) || other.add == add)&&(identical(other.remove, remove) || other.remove == remove));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,add,remove);

@override
String toString() {
  return 'EntityDiff(add: $add, remove: $remove)';
}


}

/// @nodoc
abstract mixin class _$EntityDiffCopyWith<$Res> implements $EntityDiffCopyWith<$Res> {
  factory _$EntityDiffCopyWith(_EntityDiff value, $Res Function(_EntityDiff) _then) = __$EntityDiffCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '+') EntityState? add,@JsonKey(name: '-') EntityStateRemove? remove
});


@override $EntityStateCopyWith<$Res>? get add;@override $EntityStateRemoveCopyWith<$Res>? get remove;

}
/// @nodoc
class __$EntityDiffCopyWithImpl<$Res>
    implements _$EntityDiffCopyWith<$Res> {
  __$EntityDiffCopyWithImpl(this._self, this._then);

  final _EntityDiff _self;
  final $Res Function(_EntityDiff) _then;

/// Create a copy of EntityDiff
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? add = freezed,Object? remove = freezed,}) {
  return _then(_EntityDiff(
add: freezed == add ? _self.add : add // ignore: cast_nullable_to_non_nullable
as EntityState?,remove: freezed == remove ? _self.remove : remove // ignore: cast_nullable_to_non_nullable
as EntityStateRemove?,
  ));
}

/// Create a copy of EntityDiff
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntityStateCopyWith<$Res>? get add {
    if (_self.add == null) {
    return null;
  }

  return $EntityStateCopyWith<$Res>(_self.add!, (value) {
    return _then(_self.copyWith(add: value));
  });
}/// Create a copy of EntityDiff
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntityStateRemoveCopyWith<$Res>? get remove {
    if (_self.remove == null) {
    return null;
  }

  return $EntityStateRemoveCopyWith<$Res>(_self.remove!, (value) {
    return _then(_self.copyWith(remove: value));
  });
}
}


/// @nodoc
mixin _$StatesUpdates {

@JsonKey(name: 'a') Map<String, EntityState>? get add;@JsonKey(name: 'r') List<String>? get remove;@JsonKey(name: 'c') Map<String, EntityDiff>? get change;
/// Create a copy of StatesUpdates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatesUpdatesCopyWith<StatesUpdates> get copyWith => _$StatesUpdatesCopyWithImpl<StatesUpdates>(this as StatesUpdates, _$identity);

  /// Serializes this StatesUpdates to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatesUpdates&&const DeepCollectionEquality().equals(other.add, add)&&const DeepCollectionEquality().equals(other.remove, remove)&&const DeepCollectionEquality().equals(other.change, change));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(add),const DeepCollectionEquality().hash(remove),const DeepCollectionEquality().hash(change));

@override
String toString() {
  return 'StatesUpdates(add: $add, remove: $remove, change: $change)';
}


}

/// @nodoc
abstract mixin class $StatesUpdatesCopyWith<$Res>  {
  factory $StatesUpdatesCopyWith(StatesUpdates value, $Res Function(StatesUpdates) _then) = _$StatesUpdatesCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'a') Map<String, EntityState>? add,@JsonKey(name: 'r') List<String>? remove,@JsonKey(name: 'c') Map<String, EntityDiff>? change
});




}
/// @nodoc
class _$StatesUpdatesCopyWithImpl<$Res>
    implements $StatesUpdatesCopyWith<$Res> {
  _$StatesUpdatesCopyWithImpl(this._self, this._then);

  final StatesUpdates _self;
  final $Res Function(StatesUpdates) _then;

/// Create a copy of StatesUpdates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? add = freezed,Object? remove = freezed,Object? change = freezed,}) {
  return _then(_self.copyWith(
add: freezed == add ? _self.add : add // ignore: cast_nullable_to_non_nullable
as Map<String, EntityState>?,remove: freezed == remove ? _self.remove : remove // ignore: cast_nullable_to_non_nullable
as List<String>?,change: freezed == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as Map<String, EntityDiff>?,
  ));
}

}


/// Adds pattern-matching-related methods to [StatesUpdates].
extension StatesUpdatesPatterns on StatesUpdates {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatesUpdates value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatesUpdates() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatesUpdates value)  $default,){
final _that = this;
switch (_that) {
case _StatesUpdates():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatesUpdates value)?  $default,){
final _that = this;
switch (_that) {
case _StatesUpdates() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'a')  Map<String, EntityState>? add, @JsonKey(name: 'r')  List<String>? remove, @JsonKey(name: 'c')  Map<String, EntityDiff>? change)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatesUpdates() when $default != null:
return $default(_that.add,_that.remove,_that.change);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'a')  Map<String, EntityState>? add, @JsonKey(name: 'r')  List<String>? remove, @JsonKey(name: 'c')  Map<String, EntityDiff>? change)  $default,) {final _that = this;
switch (_that) {
case _StatesUpdates():
return $default(_that.add,_that.remove,_that.change);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'a')  Map<String, EntityState>? add, @JsonKey(name: 'r')  List<String>? remove, @JsonKey(name: 'c')  Map<String, EntityDiff>? change)?  $default,) {final _that = this;
switch (_that) {
case _StatesUpdates() when $default != null:
return $default(_that.add,_that.remove,_that.change);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatesUpdates implements StatesUpdates {
  const _StatesUpdates({@JsonKey(name: 'a') final  Map<String, EntityState>? add, @JsonKey(name: 'r') final  List<String>? remove, @JsonKey(name: 'c') final  Map<String, EntityDiff>? change}): _add = add,_remove = remove,_change = change;
  factory _StatesUpdates.fromJson(Map<String, dynamic> json) => _$StatesUpdatesFromJson(json);

 final  Map<String, EntityState>? _add;
@override@JsonKey(name: 'a') Map<String, EntityState>? get add {
  final value = _add;
  if (value == null) return null;
  if (_add is EqualUnmodifiableMapView) return _add;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<String>? _remove;
@override@JsonKey(name: 'r') List<String>? get remove {
  final value = _remove;
  if (value == null) return null;
  if (_remove is EqualUnmodifiableListView) return _remove;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, EntityDiff>? _change;
@override@JsonKey(name: 'c') Map<String, EntityDiff>? get change {
  final value = _change;
  if (value == null) return null;
  if (_change is EqualUnmodifiableMapView) return _change;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of StatesUpdates
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatesUpdatesCopyWith<_StatesUpdates> get copyWith => __$StatesUpdatesCopyWithImpl<_StatesUpdates>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatesUpdatesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatesUpdates&&const DeepCollectionEquality().equals(other._add, _add)&&const DeepCollectionEquality().equals(other._remove, _remove)&&const DeepCollectionEquality().equals(other._change, _change));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_add),const DeepCollectionEquality().hash(_remove),const DeepCollectionEquality().hash(_change));

@override
String toString() {
  return 'StatesUpdates(add: $add, remove: $remove, change: $change)';
}


}

/// @nodoc
abstract mixin class _$StatesUpdatesCopyWith<$Res> implements $StatesUpdatesCopyWith<$Res> {
  factory _$StatesUpdatesCopyWith(_StatesUpdates value, $Res Function(_StatesUpdates) _then) = __$StatesUpdatesCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'a') Map<String, EntityState>? add,@JsonKey(name: 'r') List<String>? remove,@JsonKey(name: 'c') Map<String, EntityDiff>? change
});




}
/// @nodoc
class __$StatesUpdatesCopyWithImpl<$Res>
    implements _$StatesUpdatesCopyWith<$Res> {
  __$StatesUpdatesCopyWithImpl(this._self, this._then);

  final _StatesUpdates _self;
  final $Res Function(_StatesUpdates) _then;

/// Create a copy of StatesUpdates
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? add = freezed,Object? remove = freezed,Object? change = freezed,}) {
  return _then(_StatesUpdates(
add: freezed == add ? _self._add : add // ignore: cast_nullable_to_non_nullable
as Map<String, EntityState>?,remove: freezed == remove ? _self._remove : remove // ignore: cast_nullable_to_non_nullable
as List<String>?,change: freezed == change ? _self._change : change // ignore: cast_nullable_to_non_nullable
as Map<String, EntityDiff>?,
  ));
}


}


/// @nodoc
mixin _$CallServiceResponse {

 Context get context; dynamic get response;
/// Create a copy of CallServiceResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallServiceResponseCopyWith<CallServiceResponse> get copyWith => _$CallServiceResponseCopyWithImpl<CallServiceResponse>(this as CallServiceResponse, _$identity);

  /// Serializes this CallServiceResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallServiceResponse&&(identical(other.context, context) || other.context == context)&&const DeepCollectionEquality().equals(other.response, response));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,context,const DeepCollectionEquality().hash(response));

@override
String toString() {
  return 'CallServiceResponse(context: $context, response: $response)';
}


}

/// @nodoc
abstract mixin class $CallServiceResponseCopyWith<$Res>  {
  factory $CallServiceResponseCopyWith(CallServiceResponse value, $Res Function(CallServiceResponse) _then) = _$CallServiceResponseCopyWithImpl;
@useResult
$Res call({
 Context context, dynamic response
});


$ContextCopyWith<$Res> get context;

}
/// @nodoc
class _$CallServiceResponseCopyWithImpl<$Res>
    implements $CallServiceResponseCopyWith<$Res> {
  _$CallServiceResponseCopyWithImpl(this._self, this._then);

  final CallServiceResponse _self;
  final $Res Function(CallServiceResponse) _then;

/// Create a copy of CallServiceResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? context = null,Object? response = freezed,}) {
  return _then(_self.copyWith(
context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Context,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}
/// Create a copy of CallServiceResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCopyWith<$Res> get context {
  
  return $ContextCopyWith<$Res>(_self.context, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// Adds pattern-matching-related methods to [CallServiceResponse].
extension CallServiceResponsePatterns on CallServiceResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallServiceResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallServiceResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallServiceResponse value)  $default,){
final _that = this;
switch (_that) {
case _CallServiceResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallServiceResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CallServiceResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Context context,  dynamic response)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallServiceResponse() when $default != null:
return $default(_that.context,_that.response);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Context context,  dynamic response)  $default,) {final _that = this;
switch (_that) {
case _CallServiceResponse():
return $default(_that.context,_that.response);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Context context,  dynamic response)?  $default,) {final _that = this;
switch (_that) {
case _CallServiceResponse() when $default != null:
return $default(_that.context,_that.response);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallServiceResponse implements CallServiceResponse {
   _CallServiceResponse({required this.context, this.response});
  factory _CallServiceResponse.fromJson(Map<String, dynamic> json) => _$CallServiceResponseFromJson(json);

@override final  Context context;
@override final  dynamic response;

/// Create a copy of CallServiceResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallServiceResponseCopyWith<_CallServiceResponse> get copyWith => __$CallServiceResponseCopyWithImpl<_CallServiceResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallServiceResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallServiceResponse&&(identical(other.context, context) || other.context == context)&&const DeepCollectionEquality().equals(other.response, response));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,context,const DeepCollectionEquality().hash(response));

@override
String toString() {
  return 'CallServiceResponse(context: $context, response: $response)';
}


}

/// @nodoc
abstract mixin class _$CallServiceResponseCopyWith<$Res> implements $CallServiceResponseCopyWith<$Res> {
  factory _$CallServiceResponseCopyWith(_CallServiceResponse value, $Res Function(_CallServiceResponse) _then) = __$CallServiceResponseCopyWithImpl;
@override @useResult
$Res call({
 Context context, dynamic response
});


@override $ContextCopyWith<$Res> get context;

}
/// @nodoc
class __$CallServiceResponseCopyWithImpl<$Res>
    implements _$CallServiceResponseCopyWith<$Res> {
  __$CallServiceResponseCopyWithImpl(this._self, this._then);

  final _CallServiceResponse _self;
  final $Res Function(_CallServiceResponse) _then;

/// Create a copy of CallServiceResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? context = null,Object? response = freezed,}) {
  return _then(_CallServiceResponse(
context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Context,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of CallServiceResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCopyWith<$Res> get context {
  
  return $ContextCopyWith<$Res>(_self.context, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// @nodoc
mixin _$Context {

 String get id; String? get user_id; String? get parent_id;
/// Create a copy of Context
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContextCopyWith<Context> get copyWith => _$ContextCopyWithImpl<Context>(this as Context, _$identity);

  /// Serializes this Context to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Context&&(identical(other.id, id) || other.id == id)&&(identical(other.user_id, user_id) || other.user_id == user_id)&&(identical(other.parent_id, parent_id) || other.parent_id == parent_id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user_id,parent_id);

@override
String toString() {
  return 'Context(id: $id, user_id: $user_id, parent_id: $parent_id)';
}


}

/// @nodoc
abstract mixin class $ContextCopyWith<$Res>  {
  factory $ContextCopyWith(Context value, $Res Function(Context) _then) = _$ContextCopyWithImpl;
@useResult
$Res call({
 String id, String? user_id, String? parent_id
});




}
/// @nodoc
class _$ContextCopyWithImpl<$Res>
    implements $ContextCopyWith<$Res> {
  _$ContextCopyWithImpl(this._self, this._then);

  final Context _self;
  final $Res Function(Context) _then;

/// Create a copy of Context
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? user_id = freezed,Object? parent_id = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user_id: freezed == user_id ? _self.user_id : user_id // ignore: cast_nullable_to_non_nullable
as String?,parent_id: freezed == parent_id ? _self.parent_id : parent_id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Context].
extension ContextPatterns on Context {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Context value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Context() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Context value)  $default,){
final _that = this;
switch (_that) {
case _Context():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Context value)?  $default,){
final _that = this;
switch (_that) {
case _Context() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? user_id,  String? parent_id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Context() when $default != null:
return $default(_that.id,_that.user_id,_that.parent_id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? user_id,  String? parent_id)  $default,) {final _that = this;
switch (_that) {
case _Context():
return $default(_that.id,_that.user_id,_that.parent_id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? user_id,  String? parent_id)?  $default,) {final _that = this;
switch (_that) {
case _Context() when $default != null:
return $default(_that.id,_that.user_id,_that.parent_id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Context implements Context {
  const _Context({required this.id, this.user_id, this.parent_id});
  factory _Context.fromJson(Map<String, dynamic> json) => _$ContextFromJson(json);

@override final  String id;
@override final  String? user_id;
@override final  String? parent_id;

/// Create a copy of Context
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContextCopyWith<_Context> get copyWith => __$ContextCopyWithImpl<_Context>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Context&&(identical(other.id, id) || other.id == id)&&(identical(other.user_id, user_id) || other.user_id == user_id)&&(identical(other.parent_id, parent_id) || other.parent_id == parent_id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user_id,parent_id);

@override
String toString() {
  return 'Context(id: $id, user_id: $user_id, parent_id: $parent_id)';
}


}

/// @nodoc
abstract mixin class _$ContextCopyWith<$Res> implements $ContextCopyWith<$Res> {
  factory _$ContextCopyWith(_Context value, $Res Function(_Context) _then) = __$ContextCopyWithImpl;
@override @useResult
$Res call({
 String id, String? user_id, String? parent_id
});




}
/// @nodoc
class __$ContextCopyWithImpl<$Res>
    implements _$ContextCopyWith<$Res> {
  __$ContextCopyWithImpl(this._self, this._then);

  final _Context _self;
  final $Res Function(_Context) _then;

/// Create a copy of Context
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? user_id = freezed,Object? parent_id = freezed,}) {
  return _then(_Context(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user_id: freezed == user_id ? _self.user_id : user_id // ignore: cast_nullable_to_non_nullable
as String?,parent_id: freezed == parent_id ? _self.parent_id : parent_id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$HassEventBase {

 Context get context; String get origin; String get timeFired;
/// Create a copy of HassEventBase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HassEventBaseCopyWith<HassEventBase> get copyWith => _$HassEventBaseCopyWithImpl<HassEventBase>(this as HassEventBase, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HassEventBase&&(identical(other.context, context) || other.context == context)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.timeFired, timeFired) || other.timeFired == timeFired));
}


@override
int get hashCode => Object.hash(runtimeType,context,origin,timeFired);

@override
String toString() {
  return 'HassEventBase(context: $context, origin: $origin, timeFired: $timeFired)';
}


}

/// @nodoc
abstract mixin class $HassEventBaseCopyWith<$Res>  {
  factory $HassEventBaseCopyWith(HassEventBase value, $Res Function(HassEventBase) _then) = _$HassEventBaseCopyWithImpl;
@useResult
$Res call({
 Context context, String origin, String timeFired
});


$ContextCopyWith<$Res> get context;

}
/// @nodoc
class _$HassEventBaseCopyWithImpl<$Res>
    implements $HassEventBaseCopyWith<$Res> {
  _$HassEventBaseCopyWithImpl(this._self, this._then);

  final HassEventBase _self;
  final $Res Function(HassEventBase) _then;

/// Create a copy of HassEventBase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? context = null,Object? origin = null,Object? timeFired = null,}) {
  return _then(_self.copyWith(
context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Context,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,timeFired: null == timeFired ? _self.timeFired : timeFired // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of HassEventBase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCopyWith<$Res> get context {
  
  return $ContextCopyWith<$Res>(_self.context, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// Adds pattern-matching-related methods to [HassEventBase].
extension HassEventBasePatterns on HassEventBase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HassEventBase value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HassEventBase() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HassEventBase value)  $default,){
final _that = this;
switch (_that) {
case _HassEventBase():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HassEventBase value)?  $default,){
final _that = this;
switch (_that) {
case _HassEventBase() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Context context,  String origin,  String timeFired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HassEventBase() when $default != null:
return $default(_that.context,_that.origin,_that.timeFired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Context context,  String origin,  String timeFired)  $default,) {final _that = this;
switch (_that) {
case _HassEventBase():
return $default(_that.context,_that.origin,_that.timeFired);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Context context,  String origin,  String timeFired)?  $default,) {final _that = this;
switch (_that) {
case _HassEventBase() when $default != null:
return $default(_that.context,_that.origin,_that.timeFired);case _:
  return null;

}
}

}

/// @nodoc


class _HassEventBase implements HassEventBase {
  const _HassEventBase({required this.context, required this.origin, required this.timeFired});
  

@override final  Context context;
@override final  String origin;
@override final  String timeFired;

/// Create a copy of HassEventBase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HassEventBaseCopyWith<_HassEventBase> get copyWith => __$HassEventBaseCopyWithImpl<_HassEventBase>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HassEventBase&&(identical(other.context, context) || other.context == context)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.timeFired, timeFired) || other.timeFired == timeFired));
}


@override
int get hashCode => Object.hash(runtimeType,context,origin,timeFired);

@override
String toString() {
  return 'HassEventBase(context: $context, origin: $origin, timeFired: $timeFired)';
}


}

/// @nodoc
abstract mixin class _$HassEventBaseCopyWith<$Res> implements $HassEventBaseCopyWith<$Res> {
  factory _$HassEventBaseCopyWith(_HassEventBase value, $Res Function(_HassEventBase) _then) = __$HassEventBaseCopyWithImpl;
@override @useResult
$Res call({
 Context context, String origin, String timeFired
});


@override $ContextCopyWith<$Res> get context;

}
/// @nodoc
class __$HassEventBaseCopyWithImpl<$Res>
    implements _$HassEventBaseCopyWith<$Res> {
  __$HassEventBaseCopyWithImpl(this._self, this._then);

  final _HassEventBase _self;
  final $Res Function(_HassEventBase) _then;

/// Create a copy of HassEventBase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? context = null,Object? origin = null,Object? timeFired = null,}) {
  return _then(_HassEventBase(
context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Context,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,timeFired: null == timeFired ? _self.timeFired : timeFired // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of HassEventBase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCopyWith<$Res> get context {
  
  return $ContextCopyWith<$Res>(_self.context, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// @nodoc
mixin _$HassEvent {

 Context get context; String get origin; String get timeFired; String get eventType; Map<String, dynamic> get data;
/// Create a copy of HassEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HassEventCopyWith<HassEvent> get copyWith => _$HassEventCopyWithImpl<HassEvent>(this as HassEvent, _$identity);

  /// Serializes this HassEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HassEvent&&(identical(other.context, context) || other.context == context)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.timeFired, timeFired) || other.timeFired == timeFired)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,context,origin,timeFired,eventType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'HassEvent(context: $context, origin: $origin, timeFired: $timeFired, eventType: $eventType, data: $data)';
}


}

/// @nodoc
abstract mixin class $HassEventCopyWith<$Res>  {
  factory $HassEventCopyWith(HassEvent value, $Res Function(HassEvent) _then) = _$HassEventCopyWithImpl;
@useResult
$Res call({
 Context context, String origin, String timeFired, String eventType, Map<String, dynamic> data
});


$ContextCopyWith<$Res> get context;

}
/// @nodoc
class _$HassEventCopyWithImpl<$Res>
    implements $HassEventCopyWith<$Res> {
  _$HassEventCopyWithImpl(this._self, this._then);

  final HassEvent _self;
  final $Res Function(HassEvent) _then;

/// Create a copy of HassEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? context = null,Object? origin = null,Object? timeFired = null,Object? eventType = null,Object? data = null,}) {
  return _then(_self.copyWith(
context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Context,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,timeFired: null == timeFired ? _self.timeFired : timeFired // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of HassEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCopyWith<$Res> get context {
  
  return $ContextCopyWith<$Res>(_self.context, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// Adds pattern-matching-related methods to [HassEvent].
extension HassEventPatterns on HassEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HassEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HassEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HassEvent value)  $default,){
final _that = this;
switch (_that) {
case _HassEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HassEvent value)?  $default,){
final _that = this;
switch (_that) {
case _HassEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Context context,  String origin,  String timeFired,  String eventType,  Map<String, dynamic> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HassEvent() when $default != null:
return $default(_that.context,_that.origin,_that.timeFired,_that.eventType,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Context context,  String origin,  String timeFired,  String eventType,  Map<String, dynamic> data)  $default,) {final _that = this;
switch (_that) {
case _HassEvent():
return $default(_that.context,_that.origin,_that.timeFired,_that.eventType,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Context context,  String origin,  String timeFired,  String eventType,  Map<String, dynamic> data)?  $default,) {final _that = this;
switch (_that) {
case _HassEvent() when $default != null:
return $default(_that.context,_that.origin,_that.timeFired,_that.eventType,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HassEvent implements HassEvent {
   _HassEvent({required this.context, required this.origin, required this.timeFired, required this.eventType, required final  Map<String, dynamic> data}): _data = data;
  factory _HassEvent.fromJson(Map<String, dynamic> json) => _$HassEventFromJson(json);

@override final  Context context;
@override final  String origin;
@override final  String timeFired;
@override final  String eventType;
 final  Map<String, dynamic> _data;
@override Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of HassEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HassEventCopyWith<_HassEvent> get copyWith => __$HassEventCopyWithImpl<_HassEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HassEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HassEvent&&(identical(other.context, context) || other.context == context)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.timeFired, timeFired) || other.timeFired == timeFired)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,context,origin,timeFired,eventType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'HassEvent(context: $context, origin: $origin, timeFired: $timeFired, eventType: $eventType, data: $data)';
}


}

/// @nodoc
abstract mixin class _$HassEventCopyWith<$Res> implements $HassEventCopyWith<$Res> {
  factory _$HassEventCopyWith(_HassEvent value, $Res Function(_HassEvent) _then) = __$HassEventCopyWithImpl;
@override @useResult
$Res call({
 Context context, String origin, String timeFired, String eventType, Map<String, dynamic> data
});


@override $ContextCopyWith<$Res> get context;

}
/// @nodoc
class __$HassEventCopyWithImpl<$Res>
    implements _$HassEventCopyWith<$Res> {
  __$HassEventCopyWithImpl(this._self, this._then);

  final _HassEvent _self;
  final $Res Function(_HassEvent) _then;

/// Create a copy of HassEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? context = null,Object? origin = null,Object? timeFired = null,Object? eventType = null,Object? data = null,}) {
  return _then(_HassEvent(
context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Context,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,timeFired: null == timeFired ? _self.timeFired : timeFired // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of HassEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCopyWith<$Res> get context {
  
  return $ContextCopyWith<$Res>(_self.context, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// @nodoc
mixin _$HassEntity {

 String get entity_id; String get state; String get last_changed; String get last_updated; HassEntityAttributeBase get attributes; Context get context;
/// Create a copy of HassEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HassEntityCopyWith<HassEntity> get copyWith => _$HassEntityCopyWithImpl<HassEntity>(this as HassEntity, _$identity);

  /// Serializes this HassEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HassEntity&&(identical(other.entity_id, entity_id) || other.entity_id == entity_id)&&(identical(other.state, state) || other.state == state)&&(identical(other.last_changed, last_changed) || other.last_changed == last_changed)&&(identical(other.last_updated, last_updated) || other.last_updated == last_updated)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&(identical(other.context, context) || other.context == context));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entity_id,state,last_changed,last_updated,attributes,context);

@override
String toString() {
  return 'HassEntity(entity_id: $entity_id, state: $state, last_changed: $last_changed, last_updated: $last_updated, attributes: $attributes, context: $context)';
}


}

/// @nodoc
abstract mixin class $HassEntityCopyWith<$Res>  {
  factory $HassEntityCopyWith(HassEntity value, $Res Function(HassEntity) _then) = _$HassEntityCopyWithImpl;
@useResult
$Res call({
 String entity_id, String state, String last_changed, String last_updated, HassEntityAttributeBase attributes, Context context
});


$HassEntityAttributeBaseCopyWith<$Res> get attributes;$ContextCopyWith<$Res> get context;

}
/// @nodoc
class _$HassEntityCopyWithImpl<$Res>
    implements $HassEntityCopyWith<$Res> {
  _$HassEntityCopyWithImpl(this._self, this._then);

  final HassEntity _self;
  final $Res Function(HassEntity) _then;

/// Create a copy of HassEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entity_id = null,Object? state = null,Object? last_changed = null,Object? last_updated = null,Object? attributes = null,Object? context = null,}) {
  return _then(_self.copyWith(
entity_id: null == entity_id ? _self.entity_id : entity_id // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,last_changed: null == last_changed ? _self.last_changed : last_changed // ignore: cast_nullable_to_non_nullable
as String,last_updated: null == last_updated ? _self.last_updated : last_updated // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as HassEntityAttributeBase,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Context,
  ));
}
/// Create a copy of HassEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HassEntityAttributeBaseCopyWith<$Res> get attributes {
  
  return $HassEntityAttributeBaseCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}/// Create a copy of HassEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCopyWith<$Res> get context {
  
  return $ContextCopyWith<$Res>(_self.context, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// Adds pattern-matching-related methods to [HassEntity].
extension HassEntityPatterns on HassEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HassEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HassEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HassEntity value)  $default,){
final _that = this;
switch (_that) {
case _HassEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HassEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HassEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String entity_id,  String state,  String last_changed,  String last_updated,  HassEntityAttributeBase attributes,  Context context)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HassEntity() when $default != null:
return $default(_that.entity_id,_that.state,_that.last_changed,_that.last_updated,_that.attributes,_that.context);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String entity_id,  String state,  String last_changed,  String last_updated,  HassEntityAttributeBase attributes,  Context context)  $default,) {final _that = this;
switch (_that) {
case _HassEntity():
return $default(_that.entity_id,_that.state,_that.last_changed,_that.last_updated,_that.attributes,_that.context);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String entity_id,  String state,  String last_changed,  String last_updated,  HassEntityAttributeBase attributes,  Context context)?  $default,) {final _that = this;
switch (_that) {
case _HassEntity() when $default != null:
return $default(_that.entity_id,_that.state,_that.last_changed,_that.last_updated,_that.attributes,_that.context);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HassEntity implements HassEntity {
  const _HassEntity({required this.entity_id, required this.state, required this.last_changed, required this.last_updated, required this.attributes, required this.context});
  factory _HassEntity.fromJson(Map<String, dynamic> json) => _$HassEntityFromJson(json);

@override final  String entity_id;
@override final  String state;
@override final  String last_changed;
@override final  String last_updated;
@override final  HassEntityAttributeBase attributes;
@override final  Context context;

/// Create a copy of HassEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HassEntityCopyWith<_HassEntity> get copyWith => __$HassEntityCopyWithImpl<_HassEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HassEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HassEntity&&(identical(other.entity_id, entity_id) || other.entity_id == entity_id)&&(identical(other.state, state) || other.state == state)&&(identical(other.last_changed, last_changed) || other.last_changed == last_changed)&&(identical(other.last_updated, last_updated) || other.last_updated == last_updated)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&(identical(other.context, context) || other.context == context));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entity_id,state,last_changed,last_updated,attributes,context);

@override
String toString() {
  return 'HassEntity(entity_id: $entity_id, state: $state, last_changed: $last_changed, last_updated: $last_updated, attributes: $attributes, context: $context)';
}


}

/// @nodoc
abstract mixin class _$HassEntityCopyWith<$Res> implements $HassEntityCopyWith<$Res> {
  factory _$HassEntityCopyWith(_HassEntity value, $Res Function(_HassEntity) _then) = __$HassEntityCopyWithImpl;
@override @useResult
$Res call({
 String entity_id, String state, String last_changed, String last_updated, HassEntityAttributeBase attributes, Context context
});


@override $HassEntityAttributeBaseCopyWith<$Res> get attributes;@override $ContextCopyWith<$Res> get context;

}
/// @nodoc
class __$HassEntityCopyWithImpl<$Res>
    implements _$HassEntityCopyWith<$Res> {
  __$HassEntityCopyWithImpl(this._self, this._then);

  final _HassEntity _self;
  final $Res Function(_HassEntity) _then;

/// Create a copy of HassEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entity_id = null,Object? state = null,Object? last_changed = null,Object? last_updated = null,Object? attributes = null,Object? context = null,}) {
  return _then(_HassEntity(
entity_id: null == entity_id ? _self.entity_id : entity_id // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,last_changed: null == last_changed ? _self.last_changed : last_changed // ignore: cast_nullable_to_non_nullable
as String,last_updated: null == last_updated ? _self.last_updated : last_updated // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as HassEntityAttributeBase,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Context,
  ));
}

/// Create a copy of HassEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HassEntityAttributeBaseCopyWith<$Res> get attributes {
  
  return $HassEntityAttributeBaseCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}/// Create a copy of HassEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCopyWith<$Res> get context {
  
  return $ContextCopyWith<$Res>(_self.context, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// @nodoc
mixin _$HassEntityAttributeBase {

 String? get friendly_name; String? get unit_of_measurement; String? get icon; String? get entity_picture; num? get supported_features; bool? get hidden; bool? get assumed_state; String? get device_class; String? get state_class; bool? get restored;
/// Create a copy of HassEntityAttributeBase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HassEntityAttributeBaseCopyWith<HassEntityAttributeBase> get copyWith => _$HassEntityAttributeBaseCopyWithImpl<HassEntityAttributeBase>(this as HassEntityAttributeBase, _$identity);

  /// Serializes this HassEntityAttributeBase to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HassEntityAttributeBase&&(identical(other.friendly_name, friendly_name) || other.friendly_name == friendly_name)&&(identical(other.unit_of_measurement, unit_of_measurement) || other.unit_of_measurement == unit_of_measurement)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.entity_picture, entity_picture) || other.entity_picture == entity_picture)&&(identical(other.supported_features, supported_features) || other.supported_features == supported_features)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.assumed_state, assumed_state) || other.assumed_state == assumed_state)&&(identical(other.device_class, device_class) || other.device_class == device_class)&&(identical(other.state_class, state_class) || other.state_class == state_class)&&(identical(other.restored, restored) || other.restored == restored));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,friendly_name,unit_of_measurement,icon,entity_picture,supported_features,hidden,assumed_state,device_class,state_class,restored);

@override
String toString() {
  return 'HassEntityAttributeBase(friendly_name: $friendly_name, unit_of_measurement: $unit_of_measurement, icon: $icon, entity_picture: $entity_picture, supported_features: $supported_features, hidden: $hidden, assumed_state: $assumed_state, device_class: $device_class, state_class: $state_class, restored: $restored)';
}


}

/// @nodoc
abstract mixin class $HassEntityAttributeBaseCopyWith<$Res>  {
  factory $HassEntityAttributeBaseCopyWith(HassEntityAttributeBase value, $Res Function(HassEntityAttributeBase) _then) = _$HassEntityAttributeBaseCopyWithImpl;
@useResult
$Res call({
 String? friendly_name, String? unit_of_measurement, String? icon, String? entity_picture, num? supported_features, bool? hidden, bool? assumed_state, String? device_class, String? state_class, bool? restored
});




}
/// @nodoc
class _$HassEntityAttributeBaseCopyWithImpl<$Res>
    implements $HassEntityAttributeBaseCopyWith<$Res> {
  _$HassEntityAttributeBaseCopyWithImpl(this._self, this._then);

  final HassEntityAttributeBase _self;
  final $Res Function(HassEntityAttributeBase) _then;

/// Create a copy of HassEntityAttributeBase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? friendly_name = freezed,Object? unit_of_measurement = freezed,Object? icon = freezed,Object? entity_picture = freezed,Object? supported_features = freezed,Object? hidden = freezed,Object? assumed_state = freezed,Object? device_class = freezed,Object? state_class = freezed,Object? restored = freezed,}) {
  return _then(_self.copyWith(
friendly_name: freezed == friendly_name ? _self.friendly_name : friendly_name // ignore: cast_nullable_to_non_nullable
as String?,unit_of_measurement: freezed == unit_of_measurement ? _self.unit_of_measurement : unit_of_measurement // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,entity_picture: freezed == entity_picture ? _self.entity_picture : entity_picture // ignore: cast_nullable_to_non_nullable
as String?,supported_features: freezed == supported_features ? _self.supported_features : supported_features // ignore: cast_nullable_to_non_nullable
as num?,hidden: freezed == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool?,assumed_state: freezed == assumed_state ? _self.assumed_state : assumed_state // ignore: cast_nullable_to_non_nullable
as bool?,device_class: freezed == device_class ? _self.device_class : device_class // ignore: cast_nullable_to_non_nullable
as String?,state_class: freezed == state_class ? _self.state_class : state_class // ignore: cast_nullable_to_non_nullable
as String?,restored: freezed == restored ? _self.restored : restored // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [HassEntityAttributeBase].
extension HassEntityAttributeBasePatterns on HassEntityAttributeBase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HassEntityAttributeBase value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HassEntityAttributeBase() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HassEntityAttributeBase value)  $default,){
final _that = this;
switch (_that) {
case _HassEntityAttributeBase():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HassEntityAttributeBase value)?  $default,){
final _that = this;
switch (_that) {
case _HassEntityAttributeBase() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? friendly_name,  String? unit_of_measurement,  String? icon,  String? entity_picture,  num? supported_features,  bool? hidden,  bool? assumed_state,  String? device_class,  String? state_class,  bool? restored)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HassEntityAttributeBase() when $default != null:
return $default(_that.friendly_name,_that.unit_of_measurement,_that.icon,_that.entity_picture,_that.supported_features,_that.hidden,_that.assumed_state,_that.device_class,_that.state_class,_that.restored);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? friendly_name,  String? unit_of_measurement,  String? icon,  String? entity_picture,  num? supported_features,  bool? hidden,  bool? assumed_state,  String? device_class,  String? state_class,  bool? restored)  $default,) {final _that = this;
switch (_that) {
case _HassEntityAttributeBase():
return $default(_that.friendly_name,_that.unit_of_measurement,_that.icon,_that.entity_picture,_that.supported_features,_that.hidden,_that.assumed_state,_that.device_class,_that.state_class,_that.restored);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? friendly_name,  String? unit_of_measurement,  String? icon,  String? entity_picture,  num? supported_features,  bool? hidden,  bool? assumed_state,  String? device_class,  String? state_class,  bool? restored)?  $default,) {final _that = this;
switch (_that) {
case _HassEntityAttributeBase() when $default != null:
return $default(_that.friendly_name,_that.unit_of_measurement,_that.icon,_that.entity_picture,_that.supported_features,_that.hidden,_that.assumed_state,_that.device_class,_that.state_class,_that.restored);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HassEntityAttributeBase implements HassEntityAttributeBase {
  const _HassEntityAttributeBase({this.friendly_name, this.unit_of_measurement, this.icon, this.entity_picture, this.supported_features, this.hidden, this.assumed_state, this.device_class, this.state_class, this.restored});
  factory _HassEntityAttributeBase.fromJson(Map<String, dynamic> json) => _$HassEntityAttributeBaseFromJson(json);

@override final  String? friendly_name;
@override final  String? unit_of_measurement;
@override final  String? icon;
@override final  String? entity_picture;
@override final  num? supported_features;
@override final  bool? hidden;
@override final  bool? assumed_state;
@override final  String? device_class;
@override final  String? state_class;
@override final  bool? restored;

/// Create a copy of HassEntityAttributeBase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HassEntityAttributeBaseCopyWith<_HassEntityAttributeBase> get copyWith => __$HassEntityAttributeBaseCopyWithImpl<_HassEntityAttributeBase>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HassEntityAttributeBaseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HassEntityAttributeBase&&(identical(other.friendly_name, friendly_name) || other.friendly_name == friendly_name)&&(identical(other.unit_of_measurement, unit_of_measurement) || other.unit_of_measurement == unit_of_measurement)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.entity_picture, entity_picture) || other.entity_picture == entity_picture)&&(identical(other.supported_features, supported_features) || other.supported_features == supported_features)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.assumed_state, assumed_state) || other.assumed_state == assumed_state)&&(identical(other.device_class, device_class) || other.device_class == device_class)&&(identical(other.state_class, state_class) || other.state_class == state_class)&&(identical(other.restored, restored) || other.restored == restored));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,friendly_name,unit_of_measurement,icon,entity_picture,supported_features,hidden,assumed_state,device_class,state_class,restored);

@override
String toString() {
  return 'HassEntityAttributeBase(friendly_name: $friendly_name, unit_of_measurement: $unit_of_measurement, icon: $icon, entity_picture: $entity_picture, supported_features: $supported_features, hidden: $hidden, assumed_state: $assumed_state, device_class: $device_class, state_class: $state_class, restored: $restored)';
}


}

/// @nodoc
abstract mixin class _$HassEntityAttributeBaseCopyWith<$Res> implements $HassEntityAttributeBaseCopyWith<$Res> {
  factory _$HassEntityAttributeBaseCopyWith(_HassEntityAttributeBase value, $Res Function(_HassEntityAttributeBase) _then) = __$HassEntityAttributeBaseCopyWithImpl;
@override @useResult
$Res call({
 String? friendly_name, String? unit_of_measurement, String? icon, String? entity_picture, num? supported_features, bool? hidden, bool? assumed_state, String? device_class, String? state_class, bool? restored
});




}
/// @nodoc
class __$HassEntityAttributeBaseCopyWithImpl<$Res>
    implements _$HassEntityAttributeBaseCopyWith<$Res> {
  __$HassEntityAttributeBaseCopyWithImpl(this._self, this._then);

  final _HassEntityAttributeBase _self;
  final $Res Function(_HassEntityAttributeBase) _then;

/// Create a copy of HassEntityAttributeBase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? friendly_name = freezed,Object? unit_of_measurement = freezed,Object? icon = freezed,Object? entity_picture = freezed,Object? supported_features = freezed,Object? hidden = freezed,Object? assumed_state = freezed,Object? device_class = freezed,Object? state_class = freezed,Object? restored = freezed,}) {
  return _then(_HassEntityAttributeBase(
friendly_name: freezed == friendly_name ? _self.friendly_name : friendly_name // ignore: cast_nullable_to_non_nullable
as String?,unit_of_measurement: freezed == unit_of_measurement ? _self.unit_of_measurement : unit_of_measurement // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,entity_picture: freezed == entity_picture ? _self.entity_picture : entity_picture // ignore: cast_nullable_to_non_nullable
as String?,supported_features: freezed == supported_features ? _self.supported_features : supported_features // ignore: cast_nullable_to_non_nullable
as num?,hidden: freezed == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool?,assumed_state: freezed == assumed_state ? _self.assumed_state : assumed_state // ignore: cast_nullable_to_non_nullable
as bool?,device_class: freezed == device_class ? _self.device_class : device_class // ignore: cast_nullable_to_non_nullable
as String?,state_class: freezed == state_class ? _self.state_class : state_class // ignore: cast_nullable_to_non_nullable
as String?,restored: freezed == restored ? _self.restored : restored // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
