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

Context _$ContextFromJson(Map<String, dynamic> json) {
  return _Context.fromJson(json);
}

/// @nodoc
mixin _$Context {
  String get id => throw _privateConstructorUsedError;
  String? get user_id => throw _privateConstructorUsedError;
  String? get parent_id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContextCopyWith<Context> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContextCopyWith<$Res> {
  factory $ContextCopyWith(Context value, $Res Function(Context) then) =
      _$ContextCopyWithImpl<$Res, Context>;
  @useResult
  $Res call({String id, String? user_id, String? parent_id});
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
    Object? user_id = freezed,
    Object? parent_id = freezed,
  }) {
    return _then(_value.copyWith(
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContextImplCopyWith<$Res> implements $ContextCopyWith<$Res> {
  factory _$$ContextImplCopyWith(
          _$ContextImpl value, $Res Function(_$ContextImpl) then) =
      __$$ContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? user_id, String? parent_id});
}

/// @nodoc
class __$$ContextImplCopyWithImpl<$Res>
    extends _$ContextCopyWithImpl<$Res, _$ContextImpl>
    implements _$$ContextImplCopyWith<$Res> {
  __$$ContextImplCopyWithImpl(
      _$ContextImpl _value, $Res Function(_$ContextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user_id = freezed,
    Object? parent_id = freezed,
  }) {
    return _then(_$ContextImpl(
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
class _$ContextImpl implements _Context {
  const _$ContextImpl({required this.id, this.user_id, this.parent_id});

  factory _$ContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContextImplFromJson(json);

  @override
  final String id;
  @override
  final String? user_id;
  @override
  final String? parent_id;

  @override
  String toString() {
    return 'Context(id: $id, user_id: $user_id, parent_id: $parent_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContextImpl &&
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
  _$$ContextImplCopyWith<_$ContextImpl> get copyWith =>
      __$$ContextImplCopyWithImpl<_$ContextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContextImplToJson(
      this,
    );
  }
}

abstract class _Context implements Context {
  const factory _Context(
      {required final String id,
      final String? user_id,
      final String? parent_id}) = _$ContextImpl;

  factory _Context.fromJson(Map<String, dynamic> json) = _$ContextImpl.fromJson;

  @override
  String get id;
  @override
  String? get user_id;
  @override
  String? get parent_id;
  @override
  @JsonKey(ignore: true)
  _$$ContextImplCopyWith<_$ContextImpl> get copyWith =>
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
