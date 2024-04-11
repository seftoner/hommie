// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'types.dart';

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

AreaEntity _$AreaEntityFromJson(Map<String, dynamic> json) {
  return _AreaEntity.fromJson(json);
}

/// @nodoc
mixin _$AreaEntity {
  String get area_id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get picture => throw _privateConstructorUsedError;
  List<String>? get aliases => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AreaEntityCopyWith<AreaEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreaEntityCopyWith<$Res> {
  factory $AreaEntityCopyWith(
          AreaEntity value, $Res Function(AreaEntity) then) =
      _$AreaEntityCopyWithImpl<$Res, AreaEntity>;
  @useResult
  $Res call(
      {String area_id, String name, String? picture, List<String>? aliases});
}

/// @nodoc
class _$AreaEntityCopyWithImpl<$Res, $Val extends AreaEntity>
    implements $AreaEntityCopyWith<$Res> {
  _$AreaEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area_id = null,
    Object? name = null,
    Object? picture = freezed,
    Object? aliases = freezed,
  }) {
    return _then(_value.copyWith(
      area_id: null == area_id
          ? _value.area_id
          : area_id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      aliases: freezed == aliases
          ? _value.aliases
          : aliases // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AreaEntityImplCopyWith<$Res>
    implements $AreaEntityCopyWith<$Res> {
  factory _$$AreaEntityImplCopyWith(
          _$AreaEntityImpl value, $Res Function(_$AreaEntityImpl) then) =
      __$$AreaEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String area_id, String name, String? picture, List<String>? aliases});
}

/// @nodoc
class __$$AreaEntityImplCopyWithImpl<$Res>
    extends _$AreaEntityCopyWithImpl<$Res, _$AreaEntityImpl>
    implements _$$AreaEntityImplCopyWith<$Res> {
  __$$AreaEntityImplCopyWithImpl(
      _$AreaEntityImpl _value, $Res Function(_$AreaEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area_id = null,
    Object? name = null,
    Object? picture = freezed,
    Object? aliases = freezed,
  }) {
    return _then(_$AreaEntityImpl(
      area_id: null == area_id
          ? _value.area_id
          : area_id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      aliases: freezed == aliases
          ? _value._aliases
          : aliases // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaEntityImpl implements _AreaEntity {
  const _$AreaEntityImpl(
      {required this.area_id,
      required this.name,
      this.picture,
      final List<String>? aliases})
      : _aliases = aliases;

  factory _$AreaEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AreaEntityImplFromJson(json);

  @override
  final String area_id;
  @override
  final String name;
  @override
  final String? picture;
  final List<String>? _aliases;
  @override
  List<String>? get aliases {
    final value = _aliases;
    if (value == null) return null;
    if (_aliases is EqualUnmodifiableListView) return _aliases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AreaEntity(area_id: $area_id, name: $name, picture: $picture, aliases: $aliases)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaEntityImpl &&
            (identical(other.area_id, area_id) || other.area_id == area_id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.picture, picture) || other.picture == picture) &&
            const DeepCollectionEquality().equals(other._aliases, _aliases));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, area_id, name, picture,
      const DeepCollectionEquality().hash(_aliases));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaEntityImplCopyWith<_$AreaEntityImpl> get copyWith =>
      __$$AreaEntityImplCopyWithImpl<_$AreaEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaEntityImplToJson(
      this,
    );
  }
}

abstract class _AreaEntity implements AreaEntity {
  const factory _AreaEntity(
      {required final String area_id,
      required final String name,
      final String? picture,
      final List<String>? aliases}) = _$AreaEntityImpl;

  factory _AreaEntity.fromJson(Map<String, dynamic> json) =
      _$AreaEntityImpl.fromJson;

  @override
  String get area_id;
  @override
  String get name;
  @override
  String? get picture;
  @override
  List<String>? get aliases;
  @override
  @JsonKey(ignore: true)
  _$$AreaEntityImplCopyWith<_$AreaEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AreaEntityList _$AreaEntityListFromJson(Map<String, dynamic> json) {
  return _AreaEntityList.fromJson(json);
}

/// @nodoc
mixin _$AreaEntityList {
  List<AreaEntity> get areasList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AreaEntityListCopyWith<AreaEntityList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreaEntityListCopyWith<$Res> {
  factory $AreaEntityListCopyWith(
          AreaEntityList value, $Res Function(AreaEntityList) then) =
      _$AreaEntityListCopyWithImpl<$Res, AreaEntityList>;
  @useResult
  $Res call({List<AreaEntity> areasList});
}

/// @nodoc
class _$AreaEntityListCopyWithImpl<$Res, $Val extends AreaEntityList>
    implements $AreaEntityListCopyWith<$Res> {
  _$AreaEntityListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areasList = null,
  }) {
    return _then(_value.copyWith(
      areasList: null == areasList
          ? _value.areasList
          : areasList // ignore: cast_nullable_to_non_nullable
              as List<AreaEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AreaEntityListImplCopyWith<$Res>
    implements $AreaEntityListCopyWith<$Res> {
  factory _$$AreaEntityListImplCopyWith(_$AreaEntityListImpl value,
          $Res Function(_$AreaEntityListImpl) then) =
      __$$AreaEntityListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AreaEntity> areasList});
}

/// @nodoc
class __$$AreaEntityListImplCopyWithImpl<$Res>
    extends _$AreaEntityListCopyWithImpl<$Res, _$AreaEntityListImpl>
    implements _$$AreaEntityListImplCopyWith<$Res> {
  __$$AreaEntityListImplCopyWithImpl(
      _$AreaEntityListImpl _value, $Res Function(_$AreaEntityListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areasList = null,
  }) {
    return _then(_$AreaEntityListImpl(
      null == areasList
          ? _value._areasList
          : areasList // ignore: cast_nullable_to_non_nullable
              as List<AreaEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaEntityListImpl implements _AreaEntityList {
  const _$AreaEntityListImpl(final List<AreaEntity> areasList)
      : _areasList = areasList;

  factory _$AreaEntityListImpl.fromJson(Map<String, dynamic> json) =>
      _$$AreaEntityListImplFromJson(json);

  final List<AreaEntity> _areasList;
  @override
  List<AreaEntity> get areasList {
    if (_areasList is EqualUnmodifiableListView) return _areasList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areasList);
  }

  @override
  String toString() {
    return 'AreaEntityList(areasList: $areasList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaEntityListImpl &&
            const DeepCollectionEquality()
                .equals(other._areasList, _areasList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_areasList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaEntityListImplCopyWith<_$AreaEntityListImpl> get copyWith =>
      __$$AreaEntityListImplCopyWithImpl<_$AreaEntityListImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaEntityListImplToJson(
      this,
    );
  }
}

abstract class _AreaEntityList implements AreaEntityList {
  const factory _AreaEntityList(final List<AreaEntity> areasList) =
      _$AreaEntityListImpl;

  factory _AreaEntityList.fromJson(Map<String, dynamic> json) =
      _$AreaEntityListImpl.fromJson;

  @override
  List<AreaEntity> get areasList;
  @override
  @JsonKey(ignore: true)
  _$$AreaEntityListImplCopyWith<_$AreaEntityListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HassUser _$HassUserFromJson(Map<String, dynamic> json) {
  return _HassUser.fromJson(json);
}

/// @nodoc
mixin _$HassUser {
  String get id => throw _privateConstructorUsedError;
  bool get is_admin => throw _privateConstructorUsedError;
  bool get is_owner => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HassUserCopyWith<HassUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HassUserCopyWith<$Res> {
  factory $HassUserCopyWith(HassUser value, $Res Function(HassUser) then) =
      _$HassUserCopyWithImpl<$Res, HassUser>;
  @useResult
  $Res call({String id, bool is_admin, bool is_owner, String name});
}

/// @nodoc
class _$HassUserCopyWithImpl<$Res, $Val extends HassUser>
    implements $HassUserCopyWith<$Res> {
  _$HassUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? is_admin = null,
    Object? is_owner = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      is_admin: null == is_admin
          ? _value.is_admin
          : is_admin // ignore: cast_nullable_to_non_nullable
              as bool,
      is_owner: null == is_owner
          ? _value.is_owner
          : is_owner // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HassUserImplCopyWith<$Res>
    implements $HassUserCopyWith<$Res> {
  factory _$$HassUserImplCopyWith(
          _$HassUserImpl value, $Res Function(_$HassUserImpl) then) =
      __$$HassUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, bool is_admin, bool is_owner, String name});
}

/// @nodoc
class __$$HassUserImplCopyWithImpl<$Res>
    extends _$HassUserCopyWithImpl<$Res, _$HassUserImpl>
    implements _$$HassUserImplCopyWith<$Res> {
  __$$HassUserImplCopyWithImpl(
      _$HassUserImpl _value, $Res Function(_$HassUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? is_admin = null,
    Object? is_owner = null,
    Object? name = null,
  }) {
    return _then(_$HassUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      is_admin: null == is_admin
          ? _value.is_admin
          : is_admin // ignore: cast_nullable_to_non_nullable
              as bool,
      is_owner: null == is_owner
          ? _value.is_owner
          : is_owner // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HassUserImpl implements _HassUser {
  const _$HassUserImpl(
      {required this.id,
      required this.is_admin,
      required this.is_owner,
      required this.name});

  factory _$HassUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$HassUserImplFromJson(json);

  @override
  final String id;
  @override
  final bool is_admin;
  @override
  final bool is_owner;
  @override
  final String name;

  @override
  String toString() {
    return 'HassUser(id: $id, is_admin: $is_admin, is_owner: $is_owner, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HassUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.is_admin, is_admin) ||
                other.is_admin == is_admin) &&
            (identical(other.is_owner, is_owner) ||
                other.is_owner == is_owner) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, is_admin, is_owner, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HassUserImplCopyWith<_$HassUserImpl> get copyWith =>
      __$$HassUserImplCopyWithImpl<_$HassUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HassUserImplToJson(
      this,
    );
  }
}

abstract class _HassUser implements HassUser {
  const factory _HassUser(
      {required final String id,
      required final bool is_admin,
      required final bool is_owner,
      required final String name}) = _$HassUserImpl;

  factory _HassUser.fromJson(Map<String, dynamic> json) =
      _$HassUserImpl.fromJson;

  @override
  String get id;
  @override
  bool get is_admin;
  @override
  bool get is_owner;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$HassUserImplCopyWith<_$HassUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HassConfig _$HassConfigFromJson(Map<String, dynamic> json) {
  return _HassConfig.fromJson(json);
}

/// @nodoc
mixin _$HassConfig {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get elevation => throw _privateConstructorUsedError;
  UnitSystem get unitSystem => throw _privateConstructorUsedError;
  String get locationName => throw _privateConstructorUsedError;
  String get timeZone => throw _privateConstructorUsedError;
  List<String> get components => throw _privateConstructorUsedError;
  String get configDir => throw _privateConstructorUsedError;
  List<String> get allowlistExternalDirs => throw _privateConstructorUsedError;
  List<String> get allowlistExternalUrls => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get configSource => throw _privateConstructorUsedError;
  bool get recoveryMode => throw _privateConstructorUsedError;
  bool get safeMode =>
      throw _privateConstructorUsedError; // @StringEnum('NOT_RUNNING', 'STARTING', 'RUNNING', 'STOPPING', 'FINAL_WRITE')
  State get state => throw _privateConstructorUsedError;
  String? get externalUrl => throw _privateConstructorUsedError;
  String? get internalUrl => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HassConfigCopyWith<HassConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HassConfigCopyWith<$Res> {
  factory $HassConfigCopyWith(
          HassConfig value, $Res Function(HassConfig) then) =
      _$HassConfigCopyWithImpl<$Res, HassConfig>;
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      double elevation,
      UnitSystem unitSystem,
      String locationName,
      String timeZone,
      List<String> components,
      String configDir,
      List<String> allowlistExternalDirs,
      List<String> allowlistExternalUrls,
      String version,
      String configSource,
      bool recoveryMode,
      bool safeMode,
      State state,
      String? externalUrl,
      String? internalUrl,
      String currency,
      String? country,
      String language});

  $UnitSystemCopyWith<$Res> get unitSystem;
}

/// @nodoc
class _$HassConfigCopyWithImpl<$Res, $Val extends HassConfig>
    implements $HassConfigCopyWith<$Res> {
  _$HassConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? elevation = null,
    Object? unitSystem = null,
    Object? locationName = null,
    Object? timeZone = null,
    Object? components = null,
    Object? configDir = null,
    Object? allowlistExternalDirs = null,
    Object? allowlistExternalUrls = null,
    Object? version = null,
    Object? configSource = null,
    Object? recoveryMode = null,
    Object? safeMode = null,
    Object? state = null,
    Object? externalUrl = freezed,
    Object? internalUrl = freezed,
    Object? currency = null,
    Object? country = freezed,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      elevation: null == elevation
          ? _value.elevation
          : elevation // ignore: cast_nullable_to_non_nullable
              as double,
      unitSystem: null == unitSystem
          ? _value.unitSystem
          : unitSystem // ignore: cast_nullable_to_non_nullable
              as UnitSystem,
      locationName: null == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String,
      timeZone: null == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String,
      components: null == components
          ? _value.components
          : components // ignore: cast_nullable_to_non_nullable
              as List<String>,
      configDir: null == configDir
          ? _value.configDir
          : configDir // ignore: cast_nullable_to_non_nullable
              as String,
      allowlistExternalDirs: null == allowlistExternalDirs
          ? _value.allowlistExternalDirs
          : allowlistExternalDirs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowlistExternalUrls: null == allowlistExternalUrls
          ? _value.allowlistExternalUrls
          : allowlistExternalUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      configSource: null == configSource
          ? _value.configSource
          : configSource // ignore: cast_nullable_to_non_nullable
              as String,
      recoveryMode: null == recoveryMode
          ? _value.recoveryMode
          : recoveryMode // ignore: cast_nullable_to_non_nullable
              as bool,
      safeMode: null == safeMode
          ? _value.safeMode
          : safeMode // ignore: cast_nullable_to_non_nullable
              as bool,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as State,
      externalUrl: freezed == externalUrl
          ? _value.externalUrl
          : externalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      internalUrl: freezed == internalUrl
          ? _value.internalUrl
          : internalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnitSystemCopyWith<$Res> get unitSystem {
    return $UnitSystemCopyWith<$Res>(_value.unitSystem, (value) {
      return _then(_value.copyWith(unitSystem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HassConfigImplCopyWith<$Res>
    implements $HassConfigCopyWith<$Res> {
  factory _$$HassConfigImplCopyWith(
          _$HassConfigImpl value, $Res Function(_$HassConfigImpl) then) =
      __$$HassConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      double elevation,
      UnitSystem unitSystem,
      String locationName,
      String timeZone,
      List<String> components,
      String configDir,
      List<String> allowlistExternalDirs,
      List<String> allowlistExternalUrls,
      String version,
      String configSource,
      bool recoveryMode,
      bool safeMode,
      State state,
      String? externalUrl,
      String? internalUrl,
      String currency,
      String? country,
      String language});

  @override
  $UnitSystemCopyWith<$Res> get unitSystem;
}

/// @nodoc
class __$$HassConfigImplCopyWithImpl<$Res>
    extends _$HassConfigCopyWithImpl<$Res, _$HassConfigImpl>
    implements _$$HassConfigImplCopyWith<$Res> {
  __$$HassConfigImplCopyWithImpl(
      _$HassConfigImpl _value, $Res Function(_$HassConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? elevation = null,
    Object? unitSystem = null,
    Object? locationName = null,
    Object? timeZone = null,
    Object? components = null,
    Object? configDir = null,
    Object? allowlistExternalDirs = null,
    Object? allowlistExternalUrls = null,
    Object? version = null,
    Object? configSource = null,
    Object? recoveryMode = null,
    Object? safeMode = null,
    Object? state = null,
    Object? externalUrl = freezed,
    Object? internalUrl = freezed,
    Object? currency = null,
    Object? country = freezed,
    Object? language = null,
  }) {
    return _then(_$HassConfigImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      elevation: null == elevation
          ? _value.elevation
          : elevation // ignore: cast_nullable_to_non_nullable
              as double,
      unitSystem: null == unitSystem
          ? _value.unitSystem
          : unitSystem // ignore: cast_nullable_to_non_nullable
              as UnitSystem,
      locationName: null == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String,
      timeZone: null == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String,
      components: null == components
          ? _value._components
          : components // ignore: cast_nullable_to_non_nullable
              as List<String>,
      configDir: null == configDir
          ? _value.configDir
          : configDir // ignore: cast_nullable_to_non_nullable
              as String,
      allowlistExternalDirs: null == allowlistExternalDirs
          ? _value._allowlistExternalDirs
          : allowlistExternalDirs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowlistExternalUrls: null == allowlistExternalUrls
          ? _value._allowlistExternalUrls
          : allowlistExternalUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      configSource: null == configSource
          ? _value.configSource
          : configSource // ignore: cast_nullable_to_non_nullable
              as String,
      recoveryMode: null == recoveryMode
          ? _value.recoveryMode
          : recoveryMode // ignore: cast_nullable_to_non_nullable
              as bool,
      safeMode: null == safeMode
          ? _value.safeMode
          : safeMode // ignore: cast_nullable_to_non_nullable
              as bool,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as State,
      externalUrl: freezed == externalUrl
          ? _value.externalUrl
          : externalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      internalUrl: freezed == internalUrl
          ? _value.internalUrl
          : internalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HassConfigImpl implements _HassConfig {
  const _$HassConfigImpl(
      {required this.latitude,
      required this.longitude,
      required this.elevation,
      required this.unitSystem,
      required this.locationName,
      required this.timeZone,
      required final List<String> components,
      required this.configDir,
      required final List<String> allowlistExternalDirs,
      required final List<String> allowlistExternalUrls,
      required this.version,
      required this.configSource,
      required this.recoveryMode,
      required this.safeMode,
      required this.state,
      this.externalUrl,
      this.internalUrl,
      required this.currency,
      this.country,
      required this.language})
      : _components = components,
        _allowlistExternalDirs = allowlistExternalDirs,
        _allowlistExternalUrls = allowlistExternalUrls;

  factory _$HassConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$HassConfigImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double elevation;
  @override
  final UnitSystem unitSystem;
  @override
  final String locationName;
  @override
  final String timeZone;
  final List<String> _components;
  @override
  List<String> get components {
    if (_components is EqualUnmodifiableListView) return _components;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_components);
  }

  @override
  final String configDir;
  final List<String> _allowlistExternalDirs;
  @override
  List<String> get allowlistExternalDirs {
    if (_allowlistExternalDirs is EqualUnmodifiableListView)
      return _allowlistExternalDirs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowlistExternalDirs);
  }

  final List<String> _allowlistExternalUrls;
  @override
  List<String> get allowlistExternalUrls {
    if (_allowlistExternalUrls is EqualUnmodifiableListView)
      return _allowlistExternalUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowlistExternalUrls);
  }

  @override
  final String version;
  @override
  final String configSource;
  @override
  final bool recoveryMode;
  @override
  final bool safeMode;
// @StringEnum('NOT_RUNNING', 'STARTING', 'RUNNING', 'STOPPING', 'FINAL_WRITE')
  @override
  final State state;
  @override
  final String? externalUrl;
  @override
  final String? internalUrl;
  @override
  final String currency;
  @override
  final String? country;
  @override
  final String language;

  @override
  String toString() {
    return 'HassConfig(latitude: $latitude, longitude: $longitude, elevation: $elevation, unitSystem: $unitSystem, locationName: $locationName, timeZone: $timeZone, components: $components, configDir: $configDir, allowlistExternalDirs: $allowlistExternalDirs, allowlistExternalUrls: $allowlistExternalUrls, version: $version, configSource: $configSource, recoveryMode: $recoveryMode, safeMode: $safeMode, state: $state, externalUrl: $externalUrl, internalUrl: $internalUrl, currency: $currency, country: $country, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HassConfigImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.elevation, elevation) ||
                other.elevation == elevation) &&
            (identical(other.unitSystem, unitSystem) ||
                other.unitSystem == unitSystem) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.timeZone, timeZone) ||
                other.timeZone == timeZone) &&
            const DeepCollectionEquality()
                .equals(other._components, _components) &&
            (identical(other.configDir, configDir) ||
                other.configDir == configDir) &&
            const DeepCollectionEquality()
                .equals(other._allowlistExternalDirs, _allowlistExternalDirs) &&
            const DeepCollectionEquality()
                .equals(other._allowlistExternalUrls, _allowlistExternalUrls) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.configSource, configSource) ||
                other.configSource == configSource) &&
            (identical(other.recoveryMode, recoveryMode) ||
                other.recoveryMode == recoveryMode) &&
            (identical(other.safeMode, safeMode) ||
                other.safeMode == safeMode) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.externalUrl, externalUrl) ||
                other.externalUrl == externalUrl) &&
            (identical(other.internalUrl, internalUrl) ||
                other.internalUrl == internalUrl) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        latitude,
        longitude,
        elevation,
        unitSystem,
        locationName,
        timeZone,
        const DeepCollectionEquality().hash(_components),
        configDir,
        const DeepCollectionEquality().hash(_allowlistExternalDirs),
        const DeepCollectionEquality().hash(_allowlistExternalUrls),
        version,
        configSource,
        recoveryMode,
        safeMode,
        state,
        externalUrl,
        internalUrl,
        currency,
        country,
        language
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HassConfigImplCopyWith<_$HassConfigImpl> get copyWith =>
      __$$HassConfigImplCopyWithImpl<_$HassConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HassConfigImplToJson(
      this,
    );
  }
}

abstract class _HassConfig implements HassConfig {
  const factory _HassConfig(
      {required final double latitude,
      required final double longitude,
      required final double elevation,
      required final UnitSystem unitSystem,
      required final String locationName,
      required final String timeZone,
      required final List<String> components,
      required final String configDir,
      required final List<String> allowlistExternalDirs,
      required final List<String> allowlistExternalUrls,
      required final String version,
      required final String configSource,
      required final bool recoveryMode,
      required final bool safeMode,
      required final State state,
      final String? externalUrl,
      final String? internalUrl,
      required final String currency,
      final String? country,
      required final String language}) = _$HassConfigImpl;

  factory _HassConfig.fromJson(Map<String, dynamic> json) =
      _$HassConfigImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get elevation;
  @override
  UnitSystem get unitSystem;
  @override
  String get locationName;
  @override
  String get timeZone;
  @override
  List<String> get components;
  @override
  String get configDir;
  @override
  List<String> get allowlistExternalDirs;
  @override
  List<String> get allowlistExternalUrls;
  @override
  String get version;
  @override
  String get configSource;
  @override
  bool get recoveryMode;
  @override
  bool get safeMode;
  @override // @StringEnum('NOT_RUNNING', 'STARTING', 'RUNNING', 'STOPPING', 'FINAL_WRITE')
  State get state;
  @override
  String? get externalUrl;
  @override
  String? get internalUrl;
  @override
  String get currency;
  @override
  String? get country;
  @override
  String get language;
  @override
  @JsonKey(ignore: true)
  _$$HassConfigImplCopyWith<_$HassConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UnitSystem _$UnitSystemFromJson(Map<String, dynamic> json) {
  return _UnitSystem.fromJson(json);
}

/// @nodoc
mixin _$UnitSystem {
  String get length => throw _privateConstructorUsedError;
  String get mass => throw _privateConstructorUsedError;
  String get volume => throw _privateConstructorUsedError;
  String get temperature => throw _privateConstructorUsedError;
  String get pressure => throw _privateConstructorUsedError;
  String get windSpeed => throw _privateConstructorUsedError;
  String get accumulatedPrecipitation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnitSystemCopyWith<UnitSystem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitSystemCopyWith<$Res> {
  factory $UnitSystemCopyWith(
          UnitSystem value, $Res Function(UnitSystem) then) =
      _$UnitSystemCopyWithImpl<$Res, UnitSystem>;
  @useResult
  $Res call(
      {String length,
      String mass,
      String volume,
      String temperature,
      String pressure,
      String windSpeed,
      String accumulatedPrecipitation});
}

/// @nodoc
class _$UnitSystemCopyWithImpl<$Res, $Val extends UnitSystem>
    implements $UnitSystemCopyWith<$Res> {
  _$UnitSystemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? length = null,
    Object? mass = null,
    Object? volume = null,
    Object? temperature = null,
    Object? pressure = null,
    Object? windSpeed = null,
    Object? accumulatedPrecipitation = null,
  }) {
    return _then(_value.copyWith(
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as String,
      mass: null == mass
          ? _value.mass
          : mass // ignore: cast_nullable_to_non_nullable
              as String,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as String,
      pressure: null == pressure
          ? _value.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as String,
      windSpeed: null == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as String,
      accumulatedPrecipitation: null == accumulatedPrecipitation
          ? _value.accumulatedPrecipitation
          : accumulatedPrecipitation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnitSystemImplCopyWith<$Res>
    implements $UnitSystemCopyWith<$Res> {
  factory _$$UnitSystemImplCopyWith(
          _$UnitSystemImpl value, $Res Function(_$UnitSystemImpl) then) =
      __$$UnitSystemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String length,
      String mass,
      String volume,
      String temperature,
      String pressure,
      String windSpeed,
      String accumulatedPrecipitation});
}

/// @nodoc
class __$$UnitSystemImplCopyWithImpl<$Res>
    extends _$UnitSystemCopyWithImpl<$Res, _$UnitSystemImpl>
    implements _$$UnitSystemImplCopyWith<$Res> {
  __$$UnitSystemImplCopyWithImpl(
      _$UnitSystemImpl _value, $Res Function(_$UnitSystemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? length = null,
    Object? mass = null,
    Object? volume = null,
    Object? temperature = null,
    Object? pressure = null,
    Object? windSpeed = null,
    Object? accumulatedPrecipitation = null,
  }) {
    return _then(_$UnitSystemImpl(
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as String,
      mass: null == mass
          ? _value.mass
          : mass // ignore: cast_nullable_to_non_nullable
              as String,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as String,
      pressure: null == pressure
          ? _value.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as String,
      windSpeed: null == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as String,
      accumulatedPrecipitation: null == accumulatedPrecipitation
          ? _value.accumulatedPrecipitation
          : accumulatedPrecipitation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnitSystemImpl implements _UnitSystem {
  const _$UnitSystemImpl(
      {required this.length,
      required this.mass,
      required this.volume,
      required this.temperature,
      required this.pressure,
      required this.windSpeed,
      required this.accumulatedPrecipitation});

  factory _$UnitSystemImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnitSystemImplFromJson(json);

  @override
  final String length;
  @override
  final String mass;
  @override
  final String volume;
  @override
  final String temperature;
  @override
  final String pressure;
  @override
  final String windSpeed;
  @override
  final String accumulatedPrecipitation;

  @override
  String toString() {
    return 'UnitSystem(length: $length, mass: $mass, volume: $volume, temperature: $temperature, pressure: $pressure, windSpeed: $windSpeed, accumulatedPrecipitation: $accumulatedPrecipitation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnitSystemImpl &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.mass, mass) || other.mass == mass) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.pressure, pressure) ||
                other.pressure == pressure) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(
                    other.accumulatedPrecipitation, accumulatedPrecipitation) ||
                other.accumulatedPrecipitation == accumulatedPrecipitation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, length, mass, volume,
      temperature, pressure, windSpeed, accumulatedPrecipitation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnitSystemImplCopyWith<_$UnitSystemImpl> get copyWith =>
      __$$UnitSystemImplCopyWithImpl<_$UnitSystemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnitSystemImplToJson(
      this,
    );
  }
}

abstract class _UnitSystem implements UnitSystem {
  const factory _UnitSystem(
      {required final String length,
      required final String mass,
      required final String volume,
      required final String temperature,
      required final String pressure,
      required final String windSpeed,
      required final String accumulatedPrecipitation}) = _$UnitSystemImpl;

  factory _UnitSystem.fromJson(Map<String, dynamic> json) =
      _$UnitSystemImpl.fromJson;

  @override
  String get length;
  @override
  String get mass;
  @override
  String get volume;
  @override
  String get temperature;
  @override
  String get pressure;
  @override
  String get windSpeed;
  @override
  String get accumulatedPrecipitation;
  @override
  @JsonKey(ignore: true)
  _$$UnitSystemImplCopyWith<_$UnitSystemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HassService {
  String? get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get target => throw _privateConstructorUsedError;
  Map<String, Field> get fields => throw _privateConstructorUsedError;
  Response? get response => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HassServiceCopyWith<HassService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HassServiceCopyWith<$Res> {
  factory $HassServiceCopyWith(
          HassService value, $Res Function(HassService) then) =
      _$HassServiceCopyWithImpl<$Res, HassService>;
  @useResult
  $Res call(
      {String? name,
      String description,
      Map<String, dynamic>? target,
      Map<String, Field> fields,
      Response? response});

  $ResponseCopyWith<$Res>? get response;
}

/// @nodoc
class _$HassServiceCopyWithImpl<$Res, $Val extends HassService>
    implements $HassServiceCopyWith<$Res> {
  _$HassServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = null,
    Object? target = freezed,
    Object? fields = null,
    Object? response = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Map<String, Field>,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ResponseCopyWith<$Res>? get response {
    if (_value.response == null) {
      return null;
    }

    return $ResponseCopyWith<$Res>(_value.response!, (value) {
      return _then(_value.copyWith(response: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HassServiceImplCopyWith<$Res>
    implements $HassServiceCopyWith<$Res> {
  factory _$$HassServiceImplCopyWith(
          _$HassServiceImpl value, $Res Function(_$HassServiceImpl) then) =
      __$$HassServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String description,
      Map<String, dynamic>? target,
      Map<String, Field> fields,
      Response? response});

  @override
  $ResponseCopyWith<$Res>? get response;
}

/// @nodoc
class __$$HassServiceImplCopyWithImpl<$Res>
    extends _$HassServiceCopyWithImpl<$Res, _$HassServiceImpl>
    implements _$$HassServiceImplCopyWith<$Res> {
  __$$HassServiceImplCopyWithImpl(
      _$HassServiceImpl _value, $Res Function(_$HassServiceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = null,
    Object? target = freezed,
    Object? fields = null,
    Object? response = freezed,
  }) {
    return _then(_$HassServiceImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      target: freezed == target
          ? _value._target
          : target // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Map<String, Field>,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response?,
    ));
  }
}

/// @nodoc

class _$HassServiceImpl implements _HassService {
  const _$HassServiceImpl(
      {this.name,
      required this.description,
      final Map<String, dynamic>? target,
      required final Map<String, Field> fields,
      this.response})
      : _target = target,
        _fields = fields;

  @override
  final String? name;
  @override
  final String description;
  final Map<String, dynamic>? _target;
  @override
  Map<String, dynamic>? get target {
    final value = _target;
    if (value == null) return null;
    if (_target is EqualUnmodifiableMapView) return _target;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, Field> _fields;
  @override
  Map<String, Field> get fields {
    if (_fields is EqualUnmodifiableMapView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fields);
  }

  @override
  final Response? response;

  @override
  String toString() {
    return 'HassService(name: $name, description: $description, target: $target, fields: $fields, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HassServiceImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._target, _target) &&
            const DeepCollectionEquality().equals(other._fields, _fields) &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(_target),
      const DeepCollectionEquality().hash(_fields),
      response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HassServiceImplCopyWith<_$HassServiceImpl> get copyWith =>
      __$$HassServiceImplCopyWithImpl<_$HassServiceImpl>(this, _$identity);
}

abstract class _HassService implements HassService {
  const factory _HassService(
      {final String? name,
      required final String description,
      final Map<String, dynamic>? target,
      required final Map<String, Field> fields,
      final Response? response}) = _$HassServiceImpl;

  @override
  String? get name;
  @override
  String get description;
  @override
  Map<String, dynamic>? get target;
  @override
  Map<String, Field> get fields;
  @override
  Response? get response;
  @override
  @JsonKey(ignore: true)
  _$$HassServiceImplCopyWith<_$HassServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Field {
  String? get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  dynamic get example => throw _privateConstructorUsedError;
  Map<String, dynamic>? get selector => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FieldCopyWith<Field> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldCopyWith<$Res> {
  factory $FieldCopyWith(Field value, $Res Function(Field) then) =
      _$FieldCopyWithImpl<$Res, Field>;
  @useResult
  $Res call(
      {String? name,
      String description,
      dynamic example,
      Map<String, dynamic>? selector});
}

/// @nodoc
class _$FieldCopyWithImpl<$Res, $Val extends Field>
    implements $FieldCopyWith<$Res> {
  _$FieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = null,
    Object? example = freezed,
    Object? selector = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      example: freezed == example
          ? _value.example
          : example // ignore: cast_nullable_to_non_nullable
              as dynamic,
      selector: freezed == selector
          ? _value.selector
          : selector // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FieldImplCopyWith<$Res> implements $FieldCopyWith<$Res> {
  factory _$$FieldImplCopyWith(
          _$FieldImpl value, $Res Function(_$FieldImpl) then) =
      __$$FieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String description,
      dynamic example,
      Map<String, dynamic>? selector});
}

/// @nodoc
class __$$FieldImplCopyWithImpl<$Res>
    extends _$FieldCopyWithImpl<$Res, _$FieldImpl>
    implements _$$FieldImplCopyWith<$Res> {
  __$$FieldImplCopyWithImpl(
      _$FieldImpl _value, $Res Function(_$FieldImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = null,
    Object? example = freezed,
    Object? selector = freezed,
  }) {
    return _then(_$FieldImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      example: freezed == example
          ? _value.example
          : example // ignore: cast_nullable_to_non_nullable
              as dynamic,
      selector: freezed == selector
          ? _value._selector
          : selector // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$FieldImpl implements _Field {
  const _$FieldImpl(
      {this.name,
      required this.description,
      required this.example,
      final Map<String, dynamic>? selector})
      : _selector = selector;

  @override
  final String? name;
  @override
  final String description;
  @override
  final dynamic example;
  final Map<String, dynamic>? _selector;
  @override
  Map<String, dynamic>? get selector {
    final value = _selector;
    if (value == null) return null;
    if (_selector is EqualUnmodifiableMapView) return _selector;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Field(name: $name, description: $description, example: $example, selector: $selector)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.example, example) &&
            const DeepCollectionEquality().equals(other._selector, _selector));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(example),
      const DeepCollectionEquality().hash(_selector));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldImplCopyWith<_$FieldImpl> get copyWith =>
      __$$FieldImplCopyWithImpl<_$FieldImpl>(this, _$identity);
}

abstract class _Field implements Field {
  const factory _Field(
      {final String? name,
      required final String description,
      required final dynamic example,
      final Map<String, dynamic>? selector}) = _$FieldImpl;

  @override
  String? get name;
  @override
  String get description;
  @override
  dynamic get example;
  @override
  Map<String, dynamic>? get selector;
  @override
  @JsonKey(ignore: true)
  _$$FieldImplCopyWith<_$FieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Response {
  bool get optional => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ResponseCopyWith<Response> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseCopyWith<$Res> {
  factory $ResponseCopyWith(Response value, $Res Function(Response) then) =
      _$ResponseCopyWithImpl<$Res, Response>;
  @useResult
  $Res call({bool optional});
}

/// @nodoc
class _$ResponseCopyWithImpl<$Res, $Val extends Response>
    implements $ResponseCopyWith<$Res> {
  _$ResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optional = null,
  }) {
    return _then(_value.copyWith(
      optional: null == optional
          ? _value.optional
          : optional // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResponseImplCopyWith<$Res>
    implements $ResponseCopyWith<$Res> {
  factory _$$ResponseImplCopyWith(
          _$ResponseImpl value, $Res Function(_$ResponseImpl) then) =
      __$$ResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool optional});
}

/// @nodoc
class __$$ResponseImplCopyWithImpl<$Res>
    extends _$ResponseCopyWithImpl<$Res, _$ResponseImpl>
    implements _$$ResponseImplCopyWith<$Res> {
  __$$ResponseImplCopyWithImpl(
      _$ResponseImpl _value, $Res Function(_$ResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optional = null,
  }) {
    return _then(_$ResponseImpl(
      optional: null == optional
          ? _value.optional
          : optional // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ResponseImpl implements _Response {
  const _$ResponseImpl({required this.optional});

  @override
  final bool optional;

  @override
  String toString() {
    return 'Response(optional: $optional)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseImpl &&
            (identical(other.optional, optional) ||
                other.optional == optional));
  }

  @override
  int get hashCode => Object.hash(runtimeType, optional);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseImplCopyWith<_$ResponseImpl> get copyWith =>
      __$$ResponseImplCopyWithImpl<_$ResponseImpl>(this, _$identity);
}

abstract class _Response implements Response {
  const factory _Response({required final bool optional}) = _$ResponseImpl;

  @override
  bool get optional;
  @override
  @JsonKey(ignore: true)
  _$$ResponseImplCopyWith<_$ResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
