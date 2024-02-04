// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_socket_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WebSocketResponse _$WebSocketResponseFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'pong':
      return WebSocketPongResponse.fromJson(json);
    case 'event':
      return WebSocketEventResponse.fromJson(json);
    case 'result':
      return WebSocketResultResponseSuccess.fromJson(json);
    case 'result':
      return WebSocketResultResponseError.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'WebSocketResponse',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$WebSocketResponse {
  int get id => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) pong,
    required TResult Function(int id, HassEvent event) event,
    required TResult Function(int id, dynamic result) resultSuccess,
    required TResult Function(int id, String code, String message) resultError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id)? pong,
    TResult? Function(int id, HassEvent event)? event,
    TResult? Function(int id, dynamic result)? resultSuccess,
    TResult? Function(int id, String code, String message)? resultError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? pong,
    TResult Function(int id, HassEvent event)? event,
    TResult Function(int id, dynamic result)? resultSuccess,
    TResult Function(int id, String code, String message)? resultError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WebSocketPongResponse value) pong,
    required TResult Function(WebSocketEventResponse value) event,
    required TResult Function(WebSocketResultResponseSuccess value)
        resultSuccess,
    required TResult Function(WebSocketResultResponseError value) resultError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WebSocketPongResponse value)? pong,
    TResult? Function(WebSocketEventResponse value)? event,
    TResult? Function(WebSocketResultResponseSuccess value)? resultSuccess,
    TResult? Function(WebSocketResultResponseError value)? resultError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WebSocketPongResponse value)? pong,
    TResult Function(WebSocketEventResponse value)? event,
    TResult Function(WebSocketResultResponseSuccess value)? resultSuccess,
    TResult Function(WebSocketResultResponseError value)? resultError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebSocketResponseCopyWith<WebSocketResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSocketResponseCopyWith<$Res> {
  factory $WebSocketResponseCopyWith(
          WebSocketResponse value, $Res Function(WebSocketResponse) then) =
      _$WebSocketResponseCopyWithImpl<$Res, WebSocketResponse>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class _$WebSocketResponseCopyWithImpl<$Res, $Val extends WebSocketResponse>
    implements $WebSocketResponseCopyWith<$Res> {
  _$WebSocketResponseCopyWithImpl(this._value, this._then);

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
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebSocketPongResponseImplCopyWith<$Res>
    implements $WebSocketResponseCopyWith<$Res> {
  factory _$$WebSocketPongResponseImplCopyWith(
          _$WebSocketPongResponseImpl value,
          $Res Function(_$WebSocketPongResponseImpl) then) =
      __$$WebSocketPongResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$WebSocketPongResponseImplCopyWithImpl<$Res>
    extends _$WebSocketResponseCopyWithImpl<$Res, _$WebSocketPongResponseImpl>
    implements _$$WebSocketPongResponseImplCopyWith<$Res> {
  __$$WebSocketPongResponseImplCopyWithImpl(_$WebSocketPongResponseImpl _value,
      $Res Function(_$WebSocketPongResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$WebSocketPongResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSocketPongResponseImpl implements WebSocketPongResponse {
  const _$WebSocketPongResponseImpl({required this.id, final String? $type})
      : $type = $type ?? 'pong';

  factory _$WebSocketPongResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSocketPongResponseImplFromJson(json);

  @override
  final int id;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'WebSocketResponse.pong(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketPongResponseImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketPongResponseImplCopyWith<_$WebSocketPongResponseImpl>
      get copyWith => __$$WebSocketPongResponseImplCopyWithImpl<
          _$WebSocketPongResponseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) pong,
    required TResult Function(int id, HassEvent event) event,
    required TResult Function(int id, dynamic result) resultSuccess,
    required TResult Function(int id, String code, String message) resultError,
  }) {
    return pong(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id)? pong,
    TResult? Function(int id, HassEvent event)? event,
    TResult? Function(int id, dynamic result)? resultSuccess,
    TResult? Function(int id, String code, String message)? resultError,
  }) {
    return pong?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? pong,
    TResult Function(int id, HassEvent event)? event,
    TResult Function(int id, dynamic result)? resultSuccess,
    TResult Function(int id, String code, String message)? resultError,
    required TResult orElse(),
  }) {
    if (pong != null) {
      return pong(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WebSocketPongResponse value) pong,
    required TResult Function(WebSocketEventResponse value) event,
    required TResult Function(WebSocketResultResponseSuccess value)
        resultSuccess,
    required TResult Function(WebSocketResultResponseError value) resultError,
  }) {
    return pong(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WebSocketPongResponse value)? pong,
    TResult? Function(WebSocketEventResponse value)? event,
    TResult? Function(WebSocketResultResponseSuccess value)? resultSuccess,
    TResult? Function(WebSocketResultResponseError value)? resultError,
  }) {
    return pong?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WebSocketPongResponse value)? pong,
    TResult Function(WebSocketEventResponse value)? event,
    TResult Function(WebSocketResultResponseSuccess value)? resultSuccess,
    TResult Function(WebSocketResultResponseError value)? resultError,
    required TResult orElse(),
  }) {
    if (pong != null) {
      return pong(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSocketPongResponseImplToJson(
      this,
    );
  }
}

abstract class WebSocketPongResponse implements WebSocketResponse {
  const factory WebSocketPongResponse({required final int id}) =
      _$WebSocketPongResponseImpl;

  factory WebSocketPongResponse.fromJson(Map<String, dynamic> json) =
      _$WebSocketPongResponseImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$WebSocketPongResponseImplCopyWith<_$WebSocketPongResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WebSocketEventResponseImplCopyWith<$Res>
    implements $WebSocketResponseCopyWith<$Res> {
  factory _$$WebSocketEventResponseImplCopyWith(
          _$WebSocketEventResponseImpl value,
          $Res Function(_$WebSocketEventResponseImpl) then) =
      __$$WebSocketEventResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, HassEvent event});

  $HassEventCopyWith<$Res> get event;
}

/// @nodoc
class __$$WebSocketEventResponseImplCopyWithImpl<$Res>
    extends _$WebSocketResponseCopyWithImpl<$Res, _$WebSocketEventResponseImpl>
    implements _$$WebSocketEventResponseImplCopyWith<$Res> {
  __$$WebSocketEventResponseImplCopyWithImpl(
      _$WebSocketEventResponseImpl _value,
      $Res Function(_$WebSocketEventResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? event = null,
  }) {
    return _then(_$WebSocketEventResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as HassEvent,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $HassEventCopyWith<$Res> get event {
    return $HassEventCopyWith<$Res>(_value.event, (value) {
      return _then(_value.copyWith(event: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSocketEventResponseImpl implements WebSocketEventResponse {
  const _$WebSocketEventResponseImpl(
      {required this.id, required this.event, final String? $type})
      : $type = $type ?? 'event';

  factory _$WebSocketEventResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSocketEventResponseImplFromJson(json);

  @override
  final int id;
  @override
  final HassEvent event;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'WebSocketResponse.event(id: $id, event: $event)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketEventResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.event, event) || other.event == event));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, event);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketEventResponseImplCopyWith<_$WebSocketEventResponseImpl>
      get copyWith => __$$WebSocketEventResponseImplCopyWithImpl<
          _$WebSocketEventResponseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) pong,
    required TResult Function(int id, HassEvent event) event,
    required TResult Function(int id, dynamic result) resultSuccess,
    required TResult Function(int id, String code, String message) resultError,
  }) {
    return event(id, this.event);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id)? pong,
    TResult? Function(int id, HassEvent event)? event,
    TResult? Function(int id, dynamic result)? resultSuccess,
    TResult? Function(int id, String code, String message)? resultError,
  }) {
    return event?.call(id, this.event);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? pong,
    TResult Function(int id, HassEvent event)? event,
    TResult Function(int id, dynamic result)? resultSuccess,
    TResult Function(int id, String code, String message)? resultError,
    required TResult orElse(),
  }) {
    if (event != null) {
      return event(id, this.event);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WebSocketPongResponse value) pong,
    required TResult Function(WebSocketEventResponse value) event,
    required TResult Function(WebSocketResultResponseSuccess value)
        resultSuccess,
    required TResult Function(WebSocketResultResponseError value) resultError,
  }) {
    return event(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WebSocketPongResponse value)? pong,
    TResult? Function(WebSocketEventResponse value)? event,
    TResult? Function(WebSocketResultResponseSuccess value)? resultSuccess,
    TResult? Function(WebSocketResultResponseError value)? resultError,
  }) {
    return event?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WebSocketPongResponse value)? pong,
    TResult Function(WebSocketEventResponse value)? event,
    TResult Function(WebSocketResultResponseSuccess value)? resultSuccess,
    TResult Function(WebSocketResultResponseError value)? resultError,
    required TResult orElse(),
  }) {
    if (event != null) {
      return event(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSocketEventResponseImplToJson(
      this,
    );
  }
}

abstract class WebSocketEventResponse implements WebSocketResponse {
  const factory WebSocketEventResponse(
      {required final int id,
      required final HassEvent event}) = _$WebSocketEventResponseImpl;

  factory WebSocketEventResponse.fromJson(Map<String, dynamic> json) =
      _$WebSocketEventResponseImpl.fromJson;

  @override
  int get id;
  HassEvent get event;
  @override
  @JsonKey(ignore: true)
  _$$WebSocketEventResponseImplCopyWith<_$WebSocketEventResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WebSocketResultResponseSuccessImplCopyWith<$Res>
    implements $WebSocketResponseCopyWith<$Res> {
  factory _$$WebSocketResultResponseSuccessImplCopyWith(
          _$WebSocketResultResponseSuccessImpl value,
          $Res Function(_$WebSocketResultResponseSuccessImpl) then) =
      __$$WebSocketResultResponseSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, dynamic result});
}

/// @nodoc
class __$$WebSocketResultResponseSuccessImplCopyWithImpl<$Res>
    extends _$WebSocketResponseCopyWithImpl<$Res,
        _$WebSocketResultResponseSuccessImpl>
    implements _$$WebSocketResultResponseSuccessImplCopyWith<$Res> {
  __$$WebSocketResultResponseSuccessImplCopyWithImpl(
      _$WebSocketResultResponseSuccessImpl _value,
      $Res Function(_$WebSocketResultResponseSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? result = freezed,
  }) {
    return _then(_$WebSocketResultResponseSuccessImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSocketResultResponseSuccessImpl
    implements WebSocketResultResponseSuccess {
  const _$WebSocketResultResponseSuccessImpl(
      {required this.id, required this.result, final String? $type})
      : $type = $type ?? 'result';

  factory _$WebSocketResultResponseSuccessImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WebSocketResultResponseSuccessImplFromJson(json);

  @override
  final int id;
  @override
  final dynamic result;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'WebSocketResponse.resultSuccess(id: $id, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketResultResponseSuccessImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketResultResponseSuccessImplCopyWith<
          _$WebSocketResultResponseSuccessImpl>
      get copyWith => __$$WebSocketResultResponseSuccessImplCopyWithImpl<
          _$WebSocketResultResponseSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) pong,
    required TResult Function(int id, HassEvent event) event,
    required TResult Function(int id, dynamic result) resultSuccess,
    required TResult Function(int id, String code, String message) resultError,
  }) {
    return resultSuccess(id, result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id)? pong,
    TResult? Function(int id, HassEvent event)? event,
    TResult? Function(int id, dynamic result)? resultSuccess,
    TResult? Function(int id, String code, String message)? resultError,
  }) {
    return resultSuccess?.call(id, result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? pong,
    TResult Function(int id, HassEvent event)? event,
    TResult Function(int id, dynamic result)? resultSuccess,
    TResult Function(int id, String code, String message)? resultError,
    required TResult orElse(),
  }) {
    if (resultSuccess != null) {
      return resultSuccess(id, result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WebSocketPongResponse value) pong,
    required TResult Function(WebSocketEventResponse value) event,
    required TResult Function(WebSocketResultResponseSuccess value)
        resultSuccess,
    required TResult Function(WebSocketResultResponseError value) resultError,
  }) {
    return resultSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WebSocketPongResponse value)? pong,
    TResult? Function(WebSocketEventResponse value)? event,
    TResult? Function(WebSocketResultResponseSuccess value)? resultSuccess,
    TResult? Function(WebSocketResultResponseError value)? resultError,
  }) {
    return resultSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WebSocketPongResponse value)? pong,
    TResult Function(WebSocketEventResponse value)? event,
    TResult Function(WebSocketResultResponseSuccess value)? resultSuccess,
    TResult Function(WebSocketResultResponseError value)? resultError,
    required TResult orElse(),
  }) {
    if (resultSuccess != null) {
      return resultSuccess(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSocketResultResponseSuccessImplToJson(
      this,
    );
  }
}

abstract class WebSocketResultResponseSuccess implements WebSocketResponse {
  const factory WebSocketResultResponseSuccess(
      {required final int id,
      required final dynamic result}) = _$WebSocketResultResponseSuccessImpl;

  factory WebSocketResultResponseSuccess.fromJson(Map<String, dynamic> json) =
      _$WebSocketResultResponseSuccessImpl.fromJson;

  @override
  int get id;
  dynamic get result;
  @override
  @JsonKey(ignore: true)
  _$$WebSocketResultResponseSuccessImplCopyWith<
          _$WebSocketResultResponseSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WebSocketResultResponseErrorImplCopyWith<$Res>
    implements $WebSocketResponseCopyWith<$Res> {
  factory _$$WebSocketResultResponseErrorImplCopyWith(
          _$WebSocketResultResponseErrorImpl value,
          $Res Function(_$WebSocketResultResponseErrorImpl) then) =
      __$$WebSocketResultResponseErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String code, String message});
}

/// @nodoc
class __$$WebSocketResultResponseErrorImplCopyWithImpl<$Res>
    extends _$WebSocketResponseCopyWithImpl<$Res,
        _$WebSocketResultResponseErrorImpl>
    implements _$$WebSocketResultResponseErrorImplCopyWith<$Res> {
  __$$WebSocketResultResponseErrorImplCopyWithImpl(
      _$WebSocketResultResponseErrorImpl _value,
      $Res Function(_$WebSocketResultResponseErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_$WebSocketResultResponseErrorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSocketResultResponseErrorImpl
    implements WebSocketResultResponseError {
  const _$WebSocketResultResponseErrorImpl(
      {required this.id,
      required this.code,
      required this.message,
      final String? $type})
      : $type = $type ?? 'result';

  factory _$WebSocketResultResponseErrorImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WebSocketResultResponseErrorImplFromJson(json);

  @override
  final int id;
  @override
  final String code;
  @override
  final String message;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'WebSocketResponse.resultError(id: $id, code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketResultResponseErrorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketResultResponseErrorImplCopyWith<
          _$WebSocketResultResponseErrorImpl>
      get copyWith => __$$WebSocketResultResponseErrorImplCopyWithImpl<
          _$WebSocketResultResponseErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) pong,
    required TResult Function(int id, HassEvent event) event,
    required TResult Function(int id, dynamic result) resultSuccess,
    required TResult Function(int id, String code, String message) resultError,
  }) {
    return resultError(id, code, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id)? pong,
    TResult? Function(int id, HassEvent event)? event,
    TResult? Function(int id, dynamic result)? resultSuccess,
    TResult? Function(int id, String code, String message)? resultError,
  }) {
    return resultError?.call(id, code, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? pong,
    TResult Function(int id, HassEvent event)? event,
    TResult Function(int id, dynamic result)? resultSuccess,
    TResult Function(int id, String code, String message)? resultError,
    required TResult orElse(),
  }) {
    if (resultError != null) {
      return resultError(id, code, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WebSocketPongResponse value) pong,
    required TResult Function(WebSocketEventResponse value) event,
    required TResult Function(WebSocketResultResponseSuccess value)
        resultSuccess,
    required TResult Function(WebSocketResultResponseError value) resultError,
  }) {
    return resultError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WebSocketPongResponse value)? pong,
    TResult? Function(WebSocketEventResponse value)? event,
    TResult? Function(WebSocketResultResponseSuccess value)? resultSuccess,
    TResult? Function(WebSocketResultResponseError value)? resultError,
  }) {
    return resultError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WebSocketPongResponse value)? pong,
    TResult Function(WebSocketEventResponse value)? event,
    TResult Function(WebSocketResultResponseSuccess value)? resultSuccess,
    TResult Function(WebSocketResultResponseError value)? resultError,
    required TResult orElse(),
  }) {
    if (resultError != null) {
      return resultError(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSocketResultResponseErrorImplToJson(
      this,
    );
  }
}

abstract class WebSocketResultResponseError implements WebSocketResponse {
  const factory WebSocketResultResponseError(
      {required final int id,
      required final String code,
      required final String message}) = _$WebSocketResultResponseErrorImpl;

  factory WebSocketResultResponseError.fromJson(Map<String, dynamic> json) =
      _$WebSocketResultResponseErrorImpl.fromJson;

  @override
  int get id;
  String get code;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$WebSocketResultResponseErrorImplCopyWith<
          _$WebSocketResultResponseErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
