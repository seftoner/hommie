// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hass_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EntityStateRemove _$EntityStateRemoveFromJson(Map<String, dynamic> json) {
  return _EntityStateRemove.fromJson(json);
}

/// @nodoc
mixin _$EntityStateRemove {
  List<String> get a => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EntityStateRemoveCopyWith<EntityStateRemove> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntityStateRemoveCopyWith<$Res> {
  factory $EntityStateRemoveCopyWith(
          EntityStateRemove value, $Res Function(EntityStateRemove) then) =
      _$EntityStateRemoveCopyWithImpl<$Res, EntityStateRemove>;
  @useResult
  $Res call({List<String> a});
}

/// @nodoc
class _$EntityStateRemoveCopyWithImpl<$Res, $Val extends EntityStateRemove>
    implements $EntityStateRemoveCopyWith<$Res> {
  _$EntityStateRemoveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
  }) {
    return _then(_value.copyWith(
      a: null == a
          ? _value.a
          : a // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EntityStateRemoveImplCopyWith<$Res>
    implements $EntityStateRemoveCopyWith<$Res> {
  factory _$$EntityStateRemoveImplCopyWith(_$EntityStateRemoveImpl value,
          $Res Function(_$EntityStateRemoveImpl) then) =
      __$$EntityStateRemoveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> a});
}

/// @nodoc
class __$$EntityStateRemoveImplCopyWithImpl<$Res>
    extends _$EntityStateRemoveCopyWithImpl<$Res, _$EntityStateRemoveImpl>
    implements _$$EntityStateRemoveImplCopyWith<$Res> {
  __$$EntityStateRemoveImplCopyWithImpl(_$EntityStateRemoveImpl _value,
      $Res Function(_$EntityStateRemoveImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
  }) {
    return _then(_$EntityStateRemoveImpl(
      null == a
          ? _value._a
          : a // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntityStateRemoveImpl implements _EntityStateRemove {
  _$EntityStateRemoveImpl(final List<String> a) : _a = a;

  factory _$EntityStateRemoveImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntityStateRemoveImplFromJson(json);

  final List<String> _a;
  @override
  List<String> get a {
    if (_a is EqualUnmodifiableListView) return _a;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_a);
  }

  @override
  String toString() {
    return 'EntityStateRemove(a: $a)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntityStateRemoveImpl &&
            const DeepCollectionEquality().equals(other._a, _a));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_a));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EntityStateRemoveImplCopyWith<_$EntityStateRemoveImpl> get copyWith =>
      __$$EntityStateRemoveImplCopyWithImpl<_$EntityStateRemoveImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntityStateRemoveImplToJson(
      this,
    );
  }
}

abstract class _EntityStateRemove implements EntityStateRemove {
  factory _EntityStateRemove(final List<String> a) = _$EntityStateRemoveImpl;

  factory _EntityStateRemove.fromJson(Map<String, dynamic> json) =
      _$EntityStateRemoveImpl.fromJson;

  @override
  List<String> get a;
  @override
  @JsonKey(ignore: true)
  _$$EntityStateRemoveImplCopyWith<_$EntityStateRemoveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EntityState _$EntityStateFromJson(Map<String, dynamic> json) {
  return _EntityState.fromJson(json);
}

/// @nodoc
mixin _$EntityState {
  @JsonKey(name: 's')
  String? get state => throw _privateConstructorUsedError;
  @JsonKey(name: 'a')
  Map<String, dynamic>? get attributes => throw _privateConstructorUsedError;
  @JsonKey(name: 'c')
  Context? get context => throw _privateConstructorUsedError;
  @JsonKey(name: 'ls')
  double? get last_changed => throw _privateConstructorUsedError;
  @JsonKey(name: 'lu')
  double? get last_updated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EntityStateCopyWith<EntityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntityStateCopyWith<$Res> {
  factory $EntityStateCopyWith(
          EntityState value, $Res Function(EntityState) then) =
      _$EntityStateCopyWithImpl<$Res, EntityState>;
  @useResult
  $Res call(
      {@JsonKey(name: 's') String? state,
      @JsonKey(name: 'a') Map<String, dynamic>? attributes,
      @JsonKey(name: 'c') Context? context,
      @JsonKey(name: 'ls') double? last_changed,
      @JsonKey(name: 'lu') double? last_updated});

  $ContextCopyWith<$Res>? get context;
}

/// @nodoc
class _$EntityStateCopyWithImpl<$Res, $Val extends EntityState>
    implements $EntityStateCopyWith<$Res> {
  _$EntityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = freezed,
    Object? attributes = freezed,
    Object? context = freezed,
    Object? last_changed = freezed,
    Object? last_updated = freezed,
  }) {
    return _then(_value.copyWith(
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      attributes: freezed == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Context?,
      last_changed: freezed == last_changed
          ? _value.last_changed
          : last_changed // ignore: cast_nullable_to_non_nullable
              as double?,
      last_updated: freezed == last_updated
          ? _value.last_updated
          : last_updated // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ContextCopyWith<$Res>? get context {
    if (_value.context == null) {
      return null;
    }

    return $ContextCopyWith<$Res>(_value.context!, (value) {
      return _then(_value.copyWith(context: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EntityStateImplCopyWith<$Res>
    implements $EntityStateCopyWith<$Res> {
  factory _$$EntityStateImplCopyWith(
          _$EntityStateImpl value, $Res Function(_$EntityStateImpl) then) =
      __$$EntityStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 's') String? state,
      @JsonKey(name: 'a') Map<String, dynamic>? attributes,
      @JsonKey(name: 'c') Context? context,
      @JsonKey(name: 'ls') double? last_changed,
      @JsonKey(name: 'lu') double? last_updated});

  @override
  $ContextCopyWith<$Res>? get context;
}

/// @nodoc
class __$$EntityStateImplCopyWithImpl<$Res>
    extends _$EntityStateCopyWithImpl<$Res, _$EntityStateImpl>
    implements _$$EntityStateImplCopyWith<$Res> {
  __$$EntityStateImplCopyWithImpl(
      _$EntityStateImpl _value, $Res Function(_$EntityStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = freezed,
    Object? attributes = freezed,
    Object? context = freezed,
    Object? last_changed = freezed,
    Object? last_updated = freezed,
  }) {
    return _then(_$EntityStateImpl(
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      attributes: freezed == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Context?,
      last_changed: freezed == last_changed
          ? _value.last_changed
          : last_changed // ignore: cast_nullable_to_non_nullable
              as double?,
      last_updated: freezed == last_updated
          ? _value.last_updated
          : last_updated // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntityStateImpl implements _EntityState {
  _$EntityStateImpl(
      {@JsonKey(name: 's') this.state,
      @JsonKey(name: 'a') final Map<String, dynamic>? attributes,
      @JsonKey(name: 'c') this.context,
      @JsonKey(name: 'ls') this.last_changed,
      @JsonKey(name: 'lu') this.last_updated})
      : _attributes = attributes;

  factory _$EntityStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntityStateImplFromJson(json);

  @override
  @JsonKey(name: 's')
  final String? state;
  final Map<String, dynamic>? _attributes;
  @override
  @JsonKey(name: 'a')
  Map<String, dynamic>? get attributes {
    final value = _attributes;
    if (value == null) return null;
    if (_attributes is EqualUnmodifiableMapView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'c')
  final Context? context;
  @override
  @JsonKey(name: 'ls')
  final double? last_changed;
  @override
  @JsonKey(name: 'lu')
  final double? last_updated;

  @override
  String toString() {
    return 'EntityState(state: $state, attributes: $attributes, context: $context, last_changed: $last_changed, last_updated: $last_updated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntityStateImpl &&
            (identical(other.state, state) || other.state == state) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes) &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.last_changed, last_changed) ||
                other.last_changed == last_changed) &&
            (identical(other.last_updated, last_updated) ||
                other.last_updated == last_updated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      state,
      const DeepCollectionEquality().hash(_attributes),
      context,
      last_changed,
      last_updated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EntityStateImplCopyWith<_$EntityStateImpl> get copyWith =>
      __$$EntityStateImplCopyWithImpl<_$EntityStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntityStateImplToJson(
      this,
    );
  }
}

abstract class _EntityState implements EntityState {
  factory _EntityState(
      {@JsonKey(name: 's') final String? state,
      @JsonKey(name: 'a') final Map<String, dynamic>? attributes,
      @JsonKey(name: 'c') final Context? context,
      @JsonKey(name: 'ls') final double? last_changed,
      @JsonKey(name: 'lu') final double? last_updated}) = _$EntityStateImpl;

  factory _EntityState.fromJson(Map<String, dynamic> json) =
      _$EntityStateImpl.fromJson;

  @override
  @JsonKey(name: 's')
  String? get state;
  @override
  @JsonKey(name: 'a')
  Map<String, dynamic>? get attributes;
  @override
  @JsonKey(name: 'c')
  Context? get context;
  @override
  @JsonKey(name: 'ls')
  double? get last_changed;
  @override
  @JsonKey(name: 'lu')
  double? get last_updated;
  @override
  @JsonKey(ignore: true)
  _$$EntityStateImplCopyWith<_$EntityStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EntityDiff _$EntityDiffFromJson(Map<String, dynamic> json) {
  return _EntityDiff.fromJson(json);
}

/// @nodoc
mixin _$EntityDiff {
  @JsonKey(name: '+')
  EntityState? get add => throw _privateConstructorUsedError;
  @JsonKey(name: '-')
  EntityStateRemove? get remove => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EntityDiffCopyWith<EntityDiff> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntityDiffCopyWith<$Res> {
  factory $EntityDiffCopyWith(
          EntityDiff value, $Res Function(EntityDiff) then) =
      _$EntityDiffCopyWithImpl<$Res, EntityDiff>;
  @useResult
  $Res call(
      {@JsonKey(name: '+') EntityState? add,
      @JsonKey(name: '-') EntityStateRemove? remove});

  $EntityStateCopyWith<$Res>? get add;
  $EntityStateRemoveCopyWith<$Res>? get remove;
}

/// @nodoc
class _$EntityDiffCopyWithImpl<$Res, $Val extends EntityDiff>
    implements $EntityDiffCopyWith<$Res> {
  _$EntityDiffCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? add = freezed,
    Object? remove = freezed,
  }) {
    return _then(_value.copyWith(
      add: freezed == add
          ? _value.add
          : add // ignore: cast_nullable_to_non_nullable
              as EntityState?,
      remove: freezed == remove
          ? _value.remove
          : remove // ignore: cast_nullable_to_non_nullable
              as EntityStateRemove?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EntityStateCopyWith<$Res>? get add {
    if (_value.add == null) {
      return null;
    }

    return $EntityStateCopyWith<$Res>(_value.add!, (value) {
      return _then(_value.copyWith(add: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EntityStateRemoveCopyWith<$Res>? get remove {
    if (_value.remove == null) {
      return null;
    }

    return $EntityStateRemoveCopyWith<$Res>(_value.remove!, (value) {
      return _then(_value.copyWith(remove: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EntityDiffImplCopyWith<$Res>
    implements $EntityDiffCopyWith<$Res> {
  factory _$$EntityDiffImplCopyWith(
          _$EntityDiffImpl value, $Res Function(_$EntityDiffImpl) then) =
      __$$EntityDiffImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '+') EntityState? add,
      @JsonKey(name: '-') EntityStateRemove? remove});

  @override
  $EntityStateCopyWith<$Res>? get add;
  @override
  $EntityStateRemoveCopyWith<$Res>? get remove;
}

/// @nodoc
class __$$EntityDiffImplCopyWithImpl<$Res>
    extends _$EntityDiffCopyWithImpl<$Res, _$EntityDiffImpl>
    implements _$$EntityDiffImplCopyWith<$Res> {
  __$$EntityDiffImplCopyWithImpl(
      _$EntityDiffImpl _value, $Res Function(_$EntityDiffImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? add = freezed,
    Object? remove = freezed,
  }) {
    return _then(_$EntityDiffImpl(
      add: freezed == add
          ? _value.add
          : add // ignore: cast_nullable_to_non_nullable
              as EntityState?,
      remove: freezed == remove
          ? _value.remove
          : remove // ignore: cast_nullable_to_non_nullable
              as EntityStateRemove?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntityDiffImpl implements _EntityDiff {
  _$EntityDiffImpl(
      {@JsonKey(name: '+') this.add, @JsonKey(name: '-') this.remove});

  factory _$EntityDiffImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntityDiffImplFromJson(json);

  @override
  @JsonKey(name: '+')
  final EntityState? add;
  @override
  @JsonKey(name: '-')
  final EntityStateRemove? remove;

  @override
  String toString() {
    return 'EntityDiff(add: $add, remove: $remove)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntityDiffImpl &&
            (identical(other.add, add) || other.add == add) &&
            (identical(other.remove, remove) || other.remove == remove));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, add, remove);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EntityDiffImplCopyWith<_$EntityDiffImpl> get copyWith =>
      __$$EntityDiffImplCopyWithImpl<_$EntityDiffImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntityDiffImplToJson(
      this,
    );
  }
}

abstract class _EntityDiff implements EntityDiff {
  factory _EntityDiff(
      {@JsonKey(name: '+') final EntityState? add,
      @JsonKey(name: '-') final EntityStateRemove? remove}) = _$EntityDiffImpl;

  factory _EntityDiff.fromJson(Map<String, dynamic> json) =
      _$EntityDiffImpl.fromJson;

  @override
  @JsonKey(name: '+')
  EntityState? get add;
  @override
  @JsonKey(name: '-')
  EntityStateRemove? get remove;
  @override
  @JsonKey(ignore: true)
  _$$EntityDiffImplCopyWith<_$EntityDiffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatesUpdates _$StatesUpdatesFromJson(Map<String, dynamic> json) {
  return _StatesUpdates.fromJson(json);
}

/// @nodoc
mixin _$StatesUpdates {
  @JsonKey(name: 'a')
  Map<String, EntityState>? get add => throw _privateConstructorUsedError;
  @JsonKey(name: 'r')
  List<String>? get remove => throw _privateConstructorUsedError;
  @JsonKey(name: 'c')
  Map<String, EntityDiff>? get change => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatesUpdatesCopyWith<StatesUpdates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatesUpdatesCopyWith<$Res> {
  factory $StatesUpdatesCopyWith(
          StatesUpdates value, $Res Function(StatesUpdates) then) =
      _$StatesUpdatesCopyWithImpl<$Res, StatesUpdates>;
  @useResult
  $Res call(
      {@JsonKey(name: 'a') Map<String, EntityState>? add,
      @JsonKey(name: 'r') List<String>? remove,
      @JsonKey(name: 'c') Map<String, EntityDiff>? change});
}

/// @nodoc
class _$StatesUpdatesCopyWithImpl<$Res, $Val extends StatesUpdates>
    implements $StatesUpdatesCopyWith<$Res> {
  _$StatesUpdatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? add = freezed,
    Object? remove = freezed,
    Object? change = freezed,
  }) {
    return _then(_value.copyWith(
      add: freezed == add
          ? _value.add
          : add // ignore: cast_nullable_to_non_nullable
              as Map<String, EntityState>?,
      remove: freezed == remove
          ? _value.remove
          : remove // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      change: freezed == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as Map<String, EntityDiff>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatesUpdatesImplCopyWith<$Res>
    implements $StatesUpdatesCopyWith<$Res> {
  factory _$$StatesUpdatesImplCopyWith(
          _$StatesUpdatesImpl value, $Res Function(_$StatesUpdatesImpl) then) =
      __$$StatesUpdatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'a') Map<String, EntityState>? add,
      @JsonKey(name: 'r') List<String>? remove,
      @JsonKey(name: 'c') Map<String, EntityDiff>? change});
}

/// @nodoc
class __$$StatesUpdatesImplCopyWithImpl<$Res>
    extends _$StatesUpdatesCopyWithImpl<$Res, _$StatesUpdatesImpl>
    implements _$$StatesUpdatesImplCopyWith<$Res> {
  __$$StatesUpdatesImplCopyWithImpl(
      _$StatesUpdatesImpl _value, $Res Function(_$StatesUpdatesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? add = freezed,
    Object? remove = freezed,
    Object? change = freezed,
  }) {
    return _then(_$StatesUpdatesImpl(
      add: freezed == add
          ? _value._add
          : add // ignore: cast_nullable_to_non_nullable
              as Map<String, EntityState>?,
      remove: freezed == remove
          ? _value._remove
          : remove // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      change: freezed == change
          ? _value._change
          : change // ignore: cast_nullable_to_non_nullable
              as Map<String, EntityDiff>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatesUpdatesImpl implements _StatesUpdates {
  const _$StatesUpdatesImpl(
      {@JsonKey(name: 'a') final Map<String, EntityState>? add,
      @JsonKey(name: 'r') final List<String>? remove,
      @JsonKey(name: 'c') final Map<String, EntityDiff>? change})
      : _add = add,
        _remove = remove,
        _change = change;

  factory _$StatesUpdatesImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatesUpdatesImplFromJson(json);

  final Map<String, EntityState>? _add;
  @override
  @JsonKey(name: 'a')
  Map<String, EntityState>? get add {
    final value = _add;
    if (value == null) return null;
    if (_add is EqualUnmodifiableMapView) return _add;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _remove;
  @override
  @JsonKey(name: 'r')
  List<String>? get remove {
    final value = _remove;
    if (value == null) return null;
    if (_remove is EqualUnmodifiableListView) return _remove;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, EntityDiff>? _change;
  @override
  @JsonKey(name: 'c')
  Map<String, EntityDiff>? get change {
    final value = _change;
    if (value == null) return null;
    if (_change is EqualUnmodifiableMapView) return _change;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'StatesUpdates(add: $add, remove: $remove, change: $change)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatesUpdatesImpl &&
            const DeepCollectionEquality().equals(other._add, _add) &&
            const DeepCollectionEquality().equals(other._remove, _remove) &&
            const DeepCollectionEquality().equals(other._change, _change));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_add),
      const DeepCollectionEquality().hash(_remove),
      const DeepCollectionEquality().hash(_change));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatesUpdatesImplCopyWith<_$StatesUpdatesImpl> get copyWith =>
      __$$StatesUpdatesImplCopyWithImpl<_$StatesUpdatesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatesUpdatesImplToJson(
      this,
    );
  }
}

abstract class _StatesUpdates implements StatesUpdates {
  const factory _StatesUpdates(
          {@JsonKey(name: 'a') final Map<String, EntityState>? add,
          @JsonKey(name: 'r') final List<String>? remove,
          @JsonKey(name: 'c') final Map<String, EntityDiff>? change}) =
      _$StatesUpdatesImpl;

  factory _StatesUpdates.fromJson(Map<String, dynamic> json) =
      _$StatesUpdatesImpl.fromJson;

  @override
  @JsonKey(name: 'a')
  Map<String, EntityState>? get add;
  @override
  @JsonKey(name: 'r')
  List<String>? get remove;
  @override
  @JsonKey(name: 'c')
  Map<String, EntityDiff>? get change;
  @override
  @JsonKey(ignore: true)
  _$$StatesUpdatesImplCopyWith<_$StatesUpdatesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Context _$ContextFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'default':
      return ContextId.fromJson(json);
    case 'full':
      return ContextFull.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Context',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Context {
  String? get id => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String? id) $default, {
    required TResult Function(String id, String? user_id, String? parent_id)
        full,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String? id)? $default, {
    TResult? Function(String id, String? user_id, String? parent_id)? full,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String? id)? $default, {
    TResult Function(String id, String? user_id, String? parent_id)? full,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(ContextId value) $default, {
    required TResult Function(ContextFull value) full,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(ContextId value)? $default, {
    TResult? Function(ContextFull value)? full,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ContextId value)? $default, {
    TResult Function(ContextFull value)? full,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContextCopyWith<Context> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContextCopyWith<$Res> {
  factory $ContextCopyWith(Context value, $Res Function(Context) then) =
      _$ContextCopyWithImpl<$Res, Context>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$ContextCopyWithImpl<$Res, $Val extends Context>
    implements $ContextCopyWith<$Res> {
  _$ContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id!
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContextIdImplCopyWith<$Res>
    implements $ContextCopyWith<$Res> {
  factory _$$ContextIdImplCopyWith(
          _$ContextIdImpl value, $Res Function(_$ContextIdImpl) then) =
      __$$ContextIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id});
}

/// @nodoc
class __$$ContextIdImplCopyWithImpl<$Res>
    extends _$ContextCopyWithImpl<$Res, _$ContextIdImpl>
    implements _$$ContextIdImplCopyWith<$Res> {
  __$$ContextIdImplCopyWithImpl(
      _$ContextIdImpl _value, $Res Function(_$ContextIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_$ContextIdImpl(
      freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContextIdImpl implements ContextId {
  const _$ContextIdImpl(this.id, {final String? $type})
      : $type = $type ?? 'default';

  factory _$ContextIdImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContextIdImplFromJson(json);

  @override
  final String? id;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Context(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContextIdImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContextIdImplCopyWith<_$ContextIdImpl> get copyWith =>
      __$$ContextIdImplCopyWithImpl<_$ContextIdImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String? id) $default, {
    required TResult Function(String id, String? user_id, String? parent_id)
        full,
  }) {
    return $default(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String? id)? $default, {
    TResult? Function(String id, String? user_id, String? parent_id)? full,
  }) {
    return $default?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String? id)? $default, {
    TResult Function(String id, String? user_id, String? parent_id)? full,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(ContextId value) $default, {
    required TResult Function(ContextFull value) full,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(ContextId value)? $default, {
    TResult? Function(ContextFull value)? full,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ContextId value)? $default, {
    TResult Function(ContextFull value)? full,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ContextIdImplToJson(
      this,
    );
  }
}

abstract class ContextId implements Context {
  const factory ContextId(final String? id) = _$ContextIdImpl;

  factory ContextId.fromJson(Map<String, dynamic> json) =
      _$ContextIdImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$ContextIdImplCopyWith<_$ContextIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContextFullImplCopyWith<$Res>
    implements $ContextCopyWith<$Res> {
  factory _$$ContextFullImplCopyWith(
          _$ContextFullImpl value, $Res Function(_$ContextFullImpl) then) =
      __$$ContextFullImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? user_id, String? parent_id});
}

/// @nodoc
class __$$ContextFullImplCopyWithImpl<$Res>
    extends _$ContextCopyWithImpl<$Res, _$ContextFullImpl>
    implements _$$ContextFullImplCopyWith<$Res> {
  __$$ContextFullImplCopyWithImpl(
      _$ContextFullImpl _value, $Res Function(_$ContextFullImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user_id = freezed,
    Object? parent_id = freezed,
  }) {
    return _then(_$ContextFullImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      parent_id: freezed == parent_id
          ? _value.parent_id
          : parent_id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContextFullImpl implements ContextFull {
  const _$ContextFullImpl(
      {required this.id, this.user_id, this.parent_id, final String? $type})
      : $type = $type ?? 'full';

  factory _$ContextFullImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContextFullImplFromJson(json);

  @override
  final String id;
  @override
  final String? user_id;
  @override
  final String? parent_id;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Context.full(id: $id, user_id: $user_id, parent_id: $parent_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContextFullImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.parent_id, parent_id) ||
                other.parent_id == parent_id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, user_id, parent_id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContextFullImplCopyWith<_$ContextFullImpl> get copyWith =>
      __$$ContextFullImplCopyWithImpl<_$ContextFullImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String? id) $default, {
    required TResult Function(String id, String? user_id, String? parent_id)
        full,
  }) {
    return full(id, user_id, parent_id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String? id)? $default, {
    TResult? Function(String id, String? user_id, String? parent_id)? full,
  }) {
    return full?.call(id, user_id, parent_id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String? id)? $default, {
    TResult Function(String id, String? user_id, String? parent_id)? full,
    required TResult orElse(),
  }) {
    if (full != null) {
      return full(id, user_id, parent_id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(ContextId value) $default, {
    required TResult Function(ContextFull value) full,
  }) {
    return full(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(ContextId value)? $default, {
    TResult? Function(ContextFull value)? full,
  }) {
    return full?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ContextId value)? $default, {
    TResult Function(ContextFull value)? full,
    required TResult orElse(),
  }) {
    if (full != null) {
      return full(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ContextFullImplToJson(
      this,
    );
  }
}

abstract class ContextFull implements Context {
  const factory ContextFull(
      {required final String id,
      final String? user_id,
      final String? parent_id}) = _$ContextFullImpl;

  factory ContextFull.fromJson(Map<String, dynamic> json) =
      _$ContextFullImpl.fromJson;

  @override
  String get id;
  String? get user_id;
  String? get parent_id;
  @override
  @JsonKey(ignore: true)
  _$$ContextFullImplCopyWith<_$ContextFullImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HassEventBase {
  Context get context => throw _privateConstructorUsedError;
  String get origin => throw _privateConstructorUsedError;
  String get timeFired => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HassEventBaseCopyWith<HassEventBase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HassEventBaseCopyWith<$Res> {
  factory $HassEventBaseCopyWith(
          HassEventBase value, $Res Function(HassEventBase) then) =
      _$HassEventBaseCopyWithImpl<$Res, HassEventBase>;
  @useResult
  $Res call({Context context, String origin, String timeFired});

  $ContextCopyWith<$Res> get context;
}

/// @nodoc
class _$HassEventBaseCopyWithImpl<$Res, $Val extends HassEventBase>
    implements $HassEventBaseCopyWith<$Res> {
  _$HassEventBaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? origin = null,
    Object? timeFired = null,
  }) {
    return _then(_value.copyWith(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Context,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      timeFired: null == timeFired
          ? _value.timeFired
          : timeFired // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ContextCopyWith<$Res> get context {
    return $ContextCopyWith<$Res>(_value.context, (value) {
      return _then(_value.copyWith(context: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HassEventBaseImplCopyWith<$Res>
    implements $HassEventBaseCopyWith<$Res> {
  factory _$$HassEventBaseImplCopyWith(
          _$HassEventBaseImpl value, $Res Function(_$HassEventBaseImpl) then) =
      __$$HassEventBaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Context context, String origin, String timeFired});

  @override
  $ContextCopyWith<$Res> get context;
}

/// @nodoc
class __$$HassEventBaseImplCopyWithImpl<$Res>
    extends _$HassEventBaseCopyWithImpl<$Res, _$HassEventBaseImpl>
    implements _$$HassEventBaseImplCopyWith<$Res> {
  __$$HassEventBaseImplCopyWithImpl(
      _$HassEventBaseImpl _value, $Res Function(_$HassEventBaseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? origin = null,
    Object? timeFired = null,
  }) {
    return _then(_$HassEventBaseImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Context,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      timeFired: null == timeFired
          ? _value.timeFired
          : timeFired // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HassEventBaseImpl implements _HassEventBase {
  const _$HassEventBaseImpl(
      {required this.context, required this.origin, required this.timeFired});

  @override
  final Context context;
  @override
  final String origin;
  @override
  final String timeFired;

  @override
  String toString() {
    return 'HassEventBase(context: $context, origin: $origin, timeFired: $timeFired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HassEventBaseImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.timeFired, timeFired) ||
                other.timeFired == timeFired));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, origin, timeFired);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HassEventBaseImplCopyWith<_$HassEventBaseImpl> get copyWith =>
      __$$HassEventBaseImplCopyWithImpl<_$HassEventBaseImpl>(this, _$identity);
}

abstract class _HassEventBase implements HassEventBase {
  const factory _HassEventBase(
      {required final Context context,
      required final String origin,
      required final String timeFired}) = _$HassEventBaseImpl;

  @override
  Context get context;
  @override
  String get origin;
  @override
  String get timeFired;
  @override
  @JsonKey(ignore: true)
  _$$HassEventBaseImplCopyWith<_$HassEventBaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HassEvent _$HassEventFromJson(Map<String, dynamic> json) {
  return _HassEvent.fromJson(json);
}

/// @nodoc
mixin _$HassEvent {
  Context get context => throw _privateConstructorUsedError;
  String get origin => throw _privateConstructorUsedError;
  String get timeFired => throw _privateConstructorUsedError;
  String get eventType => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HassEventCopyWith<HassEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HassEventCopyWith<$Res> {
  factory $HassEventCopyWith(HassEvent value, $Res Function(HassEvent) then) =
      _$HassEventCopyWithImpl<$Res, HassEvent>;
  @useResult
  $Res call(
      {Context context,
      String origin,
      String timeFired,
      String eventType,
      Map<String, dynamic> data});

  $ContextCopyWith<$Res> get context;
}

/// @nodoc
class _$HassEventCopyWithImpl<$Res, $Val extends HassEvent>
    implements $HassEventCopyWith<$Res> {
  _$HassEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? origin = null,
    Object? timeFired = null,
    Object? eventType = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Context,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      timeFired: null == timeFired
          ? _value.timeFired
          : timeFired // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ContextCopyWith<$Res> get context {
    return $ContextCopyWith<$Res>(_value.context, (value) {
      return _then(_value.copyWith(context: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HassEventImplCopyWith<$Res>
    implements $HassEventCopyWith<$Res> {
  factory _$$HassEventImplCopyWith(
          _$HassEventImpl value, $Res Function(_$HassEventImpl) then) =
      __$$HassEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Context context,
      String origin,
      String timeFired,
      String eventType,
      Map<String, dynamic> data});

  @override
  $ContextCopyWith<$Res> get context;
}

/// @nodoc
class __$$HassEventImplCopyWithImpl<$Res>
    extends _$HassEventCopyWithImpl<$Res, _$HassEventImpl>
    implements _$$HassEventImplCopyWith<$Res> {
  __$$HassEventImplCopyWithImpl(
      _$HassEventImpl _value, $Res Function(_$HassEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? origin = null,
    Object? timeFired = null,
    Object? eventType = null,
    Object? data = null,
  }) {
    return _then(_$HassEventImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Context,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      timeFired: null == timeFired
          ? _value.timeFired
          : timeFired // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HassEventImpl implements _HassEvent {
  _$HassEventImpl(
      {required this.context,
      required this.origin,
      required this.timeFired,
      required this.eventType,
      required final Map<String, dynamic> data})
      : _data = data;

  factory _$HassEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$HassEventImplFromJson(json);

  @override
  final Context context;
  @override
  final String origin;
  @override
  final String timeFired;
  @override
  final String eventType;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'HassEvent(context: $context, origin: $origin, timeFired: $timeFired, eventType: $eventType, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HassEventImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.timeFired, timeFired) ||
                other.timeFired == timeFired) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, context, origin, timeFired,
      eventType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HassEventImplCopyWith<_$HassEventImpl> get copyWith =>
      __$$HassEventImplCopyWithImpl<_$HassEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HassEventImplToJson(
      this,
    );
  }
}

abstract class _HassEvent implements HassEvent {
  factory _HassEvent(
      {required final Context context,
      required final String origin,
      required final String timeFired,
      required final String eventType,
      required final Map<String, dynamic> data}) = _$HassEventImpl;

  factory _HassEvent.fromJson(Map<String, dynamic> json) =
      _$HassEventImpl.fromJson;

  @override
  Context get context;
  @override
  String get origin;
  @override
  String get timeFired;
  @override
  String get eventType;
  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$HassEventImplCopyWith<_$HassEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HassEntity _$HassEntityFromJson(Map<String, dynamic> json) {
  return _HassEntity.fromJson(json);
}

/// @nodoc
mixin _$HassEntity {
  String get entity_id => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get last_changed => throw _privateConstructorUsedError;
  String get last_updated => throw _privateConstructorUsedError;
  HassEntityAttributeBase get attributes => throw _privateConstructorUsedError;
  Context get context => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HassEntityCopyWith<HassEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HassEntityCopyWith<$Res> {
  factory $HassEntityCopyWith(
          HassEntity value, $Res Function(HassEntity) then) =
      _$HassEntityCopyWithImpl<$Res, HassEntity>;
  @useResult
  $Res call(
      {String entity_id,
      String state,
      String last_changed,
      String last_updated,
      HassEntityAttributeBase attributes,
      Context context});

  $HassEntityAttributeBaseCopyWith<$Res> get attributes;
  $ContextCopyWith<$Res> get context;
}

/// @nodoc
class _$HassEntityCopyWithImpl<$Res, $Val extends HassEntity>
    implements $HassEntityCopyWith<$Res> {
  _$HassEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entity_id = null,
    Object? state = null,
    Object? last_changed = null,
    Object? last_updated = null,
    Object? attributes = null,
    Object? context = null,
  }) {
    return _then(_value.copyWith(
      entity_id: null == entity_id
          ? _value.entity_id
          : entity_id // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      last_changed: null == last_changed
          ? _value.last_changed
          : last_changed // ignore: cast_nullable_to_non_nullable
              as String,
      last_updated: null == last_updated
          ? _value.last_updated
          : last_updated // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as HassEntityAttributeBase,
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Context,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HassEntityAttributeBaseCopyWith<$Res> get attributes {
    return $HassEntityAttributeBaseCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ContextCopyWith<$Res> get context {
    return $ContextCopyWith<$Res>(_value.context, (value) {
      return _then(_value.copyWith(context: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HassEntityImplCopyWith<$Res>
    implements $HassEntityCopyWith<$Res> {
  factory _$$HassEntityImplCopyWith(
          _$HassEntityImpl value, $Res Function(_$HassEntityImpl) then) =
      __$$HassEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String entity_id,
      String state,
      String last_changed,
      String last_updated,
      HassEntityAttributeBase attributes,
      Context context});

  @override
  $HassEntityAttributeBaseCopyWith<$Res> get attributes;
  @override
  $ContextCopyWith<$Res> get context;
}

/// @nodoc
class __$$HassEntityImplCopyWithImpl<$Res>
    extends _$HassEntityCopyWithImpl<$Res, _$HassEntityImpl>
    implements _$$HassEntityImplCopyWith<$Res> {
  __$$HassEntityImplCopyWithImpl(
      _$HassEntityImpl _value, $Res Function(_$HassEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entity_id = null,
    Object? state = null,
    Object? last_changed = null,
    Object? last_updated = null,
    Object? attributes = null,
    Object? context = null,
  }) {
    return _then(_$HassEntityImpl(
      entity_id: null == entity_id
          ? _value.entity_id
          : entity_id // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      last_changed: null == last_changed
          ? _value.last_changed
          : last_changed // ignore: cast_nullable_to_non_nullable
              as String,
      last_updated: null == last_updated
          ? _value.last_updated
          : last_updated // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as HassEntityAttributeBase,
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Context,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HassEntityImpl implements _HassEntity {
  const _$HassEntityImpl(
      {required this.entity_id,
      required this.state,
      required this.last_changed,
      required this.last_updated,
      required this.attributes,
      required this.context});

  factory _$HassEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$HassEntityImplFromJson(json);

  @override
  final String entity_id;
  @override
  final String state;
  @override
  final String last_changed;
  @override
  final String last_updated;
  @override
  final HassEntityAttributeBase attributes;
  @override
  final Context context;

  @override
  String toString() {
    return 'HassEntity(entity_id: $entity_id, state: $state, last_changed: $last_changed, last_updated: $last_updated, attributes: $attributes, context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HassEntityImpl &&
            (identical(other.entity_id, entity_id) ||
                other.entity_id == entity_id) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.last_changed, last_changed) ||
                other.last_changed == last_changed) &&
            (identical(other.last_updated, last_updated) ||
                other.last_updated == last_updated) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes) &&
            (identical(other.context, context) || other.context == context));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, entity_id, state, last_changed,
      last_updated, attributes, context);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HassEntityImplCopyWith<_$HassEntityImpl> get copyWith =>
      __$$HassEntityImplCopyWithImpl<_$HassEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HassEntityImplToJson(
      this,
    );
  }
}

abstract class _HassEntity implements HassEntity {
  const factory _HassEntity(
      {required final String entity_id,
      required final String state,
      required final String last_changed,
      required final String last_updated,
      required final HassEntityAttributeBase attributes,
      required final Context context}) = _$HassEntityImpl;

  factory _HassEntity.fromJson(Map<String, dynamic> json) =
      _$HassEntityImpl.fromJson;

  @override
  String get entity_id;
  @override
  String get state;
  @override
  String get last_changed;
  @override
  String get last_updated;
  @override
  HassEntityAttributeBase get attributes;
  @override
  Context get context;
  @override
  @JsonKey(ignore: true)
  _$$HassEntityImplCopyWith<_$HassEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HassEntityAttributeBase _$HassEntityAttributeBaseFromJson(
    Map<String, dynamic> json) {
  return _HassEntityAttributeBase.fromJson(json);
}

/// @nodoc
mixin _$HassEntityAttributeBase {
  String? get friendly_name => throw _privateConstructorUsedError;
  String? get unit_of_measurement => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get entity_picture => throw _privateConstructorUsedError;
  num? get supported_features => throw _privateConstructorUsedError;
  bool? get hidden => throw _privateConstructorUsedError;
  bool? get assumed_state => throw _privateConstructorUsedError;
  String? get device_class => throw _privateConstructorUsedError;
  String? get state_class => throw _privateConstructorUsedError;
  bool? get restored => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HassEntityAttributeBaseCopyWith<HassEntityAttributeBase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HassEntityAttributeBaseCopyWith<$Res> {
  factory $HassEntityAttributeBaseCopyWith(HassEntityAttributeBase value,
          $Res Function(HassEntityAttributeBase) then) =
      _$HassEntityAttributeBaseCopyWithImpl<$Res, HassEntityAttributeBase>;
  @useResult
  $Res call(
      {String? friendly_name,
      String? unit_of_measurement,
      String? icon,
      String? entity_picture,
      num? supported_features,
      bool? hidden,
      bool? assumed_state,
      String? device_class,
      String? state_class,
      bool? restored});
}

/// @nodoc
class _$HassEntityAttributeBaseCopyWithImpl<$Res,
        $Val extends HassEntityAttributeBase>
    implements $HassEntityAttributeBaseCopyWith<$Res> {
  _$HassEntityAttributeBaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friendly_name = freezed,
    Object? unit_of_measurement = freezed,
    Object? icon = freezed,
    Object? entity_picture = freezed,
    Object? supported_features = freezed,
    Object? hidden = freezed,
    Object? assumed_state = freezed,
    Object? device_class = freezed,
    Object? state_class = freezed,
    Object? restored = freezed,
  }) {
    return _then(_value.copyWith(
      friendly_name: freezed == friendly_name
          ? _value.friendly_name
          : friendly_name // ignore: cast_nullable_to_non_nullable
              as String?,
      unit_of_measurement: freezed == unit_of_measurement
          ? _value.unit_of_measurement
          : unit_of_measurement // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      entity_picture: freezed == entity_picture
          ? _value.entity_picture
          : entity_picture // ignore: cast_nullable_to_non_nullable
              as String?,
      supported_features: freezed == supported_features
          ? _value.supported_features
          : supported_features // ignore: cast_nullable_to_non_nullable
              as num?,
      hidden: freezed == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool?,
      assumed_state: freezed == assumed_state
          ? _value.assumed_state
          : assumed_state // ignore: cast_nullable_to_non_nullable
              as bool?,
      device_class: freezed == device_class
          ? _value.device_class
          : device_class // ignore: cast_nullable_to_non_nullable
              as String?,
      state_class: freezed == state_class
          ? _value.state_class
          : state_class // ignore: cast_nullable_to_non_nullable
              as String?,
      restored: freezed == restored
          ? _value.restored
          : restored // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HassEntityAttributeBaseImplCopyWith<$Res>
    implements $HassEntityAttributeBaseCopyWith<$Res> {
  factory _$$HassEntityAttributeBaseImplCopyWith(
          _$HassEntityAttributeBaseImpl value,
          $Res Function(_$HassEntityAttributeBaseImpl) then) =
      __$$HassEntityAttributeBaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? friendly_name,
      String? unit_of_measurement,
      String? icon,
      String? entity_picture,
      num? supported_features,
      bool? hidden,
      bool? assumed_state,
      String? device_class,
      String? state_class,
      bool? restored});
}

/// @nodoc
class __$$HassEntityAttributeBaseImplCopyWithImpl<$Res>
    extends _$HassEntityAttributeBaseCopyWithImpl<$Res,
        _$HassEntityAttributeBaseImpl>
    implements _$$HassEntityAttributeBaseImplCopyWith<$Res> {
  __$$HassEntityAttributeBaseImplCopyWithImpl(
      _$HassEntityAttributeBaseImpl _value,
      $Res Function(_$HassEntityAttributeBaseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friendly_name = freezed,
    Object? unit_of_measurement = freezed,
    Object? icon = freezed,
    Object? entity_picture = freezed,
    Object? supported_features = freezed,
    Object? hidden = freezed,
    Object? assumed_state = freezed,
    Object? device_class = freezed,
    Object? state_class = freezed,
    Object? restored = freezed,
  }) {
    return _then(_$HassEntityAttributeBaseImpl(
      friendly_name: freezed == friendly_name
          ? _value.friendly_name
          : friendly_name // ignore: cast_nullable_to_non_nullable
              as String?,
      unit_of_measurement: freezed == unit_of_measurement
          ? _value.unit_of_measurement
          : unit_of_measurement // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      entity_picture: freezed == entity_picture
          ? _value.entity_picture
          : entity_picture // ignore: cast_nullable_to_non_nullable
              as String?,
      supported_features: freezed == supported_features
          ? _value.supported_features
          : supported_features // ignore: cast_nullable_to_non_nullable
              as num?,
      hidden: freezed == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool?,
      assumed_state: freezed == assumed_state
          ? _value.assumed_state
          : assumed_state // ignore: cast_nullable_to_non_nullable
              as bool?,
      device_class: freezed == device_class
          ? _value.device_class
          : device_class // ignore: cast_nullable_to_non_nullable
              as String?,
      state_class: freezed == state_class
          ? _value.state_class
          : state_class // ignore: cast_nullable_to_non_nullable
              as String?,
      restored: freezed == restored
          ? _value.restored
          : restored // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HassEntityAttributeBaseImpl implements _HassEntityAttributeBase {
  const _$HassEntityAttributeBaseImpl(
      {this.friendly_name,
      this.unit_of_measurement,
      this.icon,
      this.entity_picture,
      this.supported_features,
      this.hidden,
      this.assumed_state,
      this.device_class,
      this.state_class,
      this.restored});

  factory _$HassEntityAttributeBaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HassEntityAttributeBaseImplFromJson(json);

  @override
  final String? friendly_name;
  @override
  final String? unit_of_measurement;
  @override
  final String? icon;
  @override
  final String? entity_picture;
  @override
  final num? supported_features;
  @override
  final bool? hidden;
  @override
  final bool? assumed_state;
  @override
  final String? device_class;
  @override
  final String? state_class;
  @override
  final bool? restored;

  @override
  String toString() {
    return 'HassEntityAttributeBase(friendly_name: $friendly_name, unit_of_measurement: $unit_of_measurement, icon: $icon, entity_picture: $entity_picture, supported_features: $supported_features, hidden: $hidden, assumed_state: $assumed_state, device_class: $device_class, state_class: $state_class, restored: $restored)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HassEntityAttributeBaseImpl &&
            (identical(other.friendly_name, friendly_name) ||
                other.friendly_name == friendly_name) &&
            (identical(other.unit_of_measurement, unit_of_measurement) ||
                other.unit_of_measurement == unit_of_measurement) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.entity_picture, entity_picture) ||
                other.entity_picture == entity_picture) &&
            (identical(other.supported_features, supported_features) ||
                other.supported_features == supported_features) &&
            (identical(other.hidden, hidden) || other.hidden == hidden) &&
            (identical(other.assumed_state, assumed_state) ||
                other.assumed_state == assumed_state) &&
            (identical(other.device_class, device_class) ||
                other.device_class == device_class) &&
            (identical(other.state_class, state_class) ||
                other.state_class == state_class) &&
            (identical(other.restored, restored) ||
                other.restored == restored));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      friendly_name,
      unit_of_measurement,
      icon,
      entity_picture,
      supported_features,
      hidden,
      assumed_state,
      device_class,
      state_class,
      restored);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HassEntityAttributeBaseImplCopyWith<_$HassEntityAttributeBaseImpl>
      get copyWith => __$$HassEntityAttributeBaseImplCopyWithImpl<
          _$HassEntityAttributeBaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HassEntityAttributeBaseImplToJson(
      this,
    );
  }
}

abstract class _HassEntityAttributeBase implements HassEntityAttributeBase {
  const factory _HassEntityAttributeBase(
      {final String? friendly_name,
      final String? unit_of_measurement,
      final String? icon,
      final String? entity_picture,
      final num? supported_features,
      final bool? hidden,
      final bool? assumed_state,
      final String? device_class,
      final String? state_class,
      final bool? restored}) = _$HassEntityAttributeBaseImpl;

  factory _HassEntityAttributeBase.fromJson(Map<String, dynamic> json) =
      _$HassEntityAttributeBaseImpl.fromJson;

  @override
  String? get friendly_name;
  @override
  String? get unit_of_measurement;
  @override
  String? get icon;
  @override
  String? get entity_picture;
  @override
  num? get supported_features;
  @override
  bool? get hidden;
  @override
  bool? get assumed_state;
  @override
  String? get device_class;
  @override
  String? get state_class;
  @override
  bool? get restored;
  @override
  @JsonKey(ignore: true)
  _$$HassEntityAttributeBaseImplCopyWith<_$HassEntityAttributeBaseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
