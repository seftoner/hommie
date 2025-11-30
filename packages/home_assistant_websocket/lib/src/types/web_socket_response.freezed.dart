// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_socket_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
WebSocketResponse _$WebSocketResponseFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'pong':
      return WebSocketPongResponse.fromJson(json);
    case 'event':
      return WebSocketEventResponse.fromJson(json);
    case 'resultSuccess':
      return WebSocketResultResponseSuccess.fromJson(json);
    case 'resultError':
      return WebSocketResultResponseError.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'WebSocketResponse',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$WebSocketResponse {
  int get id;

  /// Create a copy of WebSocketResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebSocketResponseCopyWith<WebSocketResponse> get copyWith =>
      _$WebSocketResponseCopyWithImpl<WebSocketResponse>(
          this as WebSocketResponse, _$identity);

  /// Serializes this WebSocketResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebSocketResponse &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'WebSocketResponse(id: $id)';
  }
}

/// @nodoc
abstract mixin class $WebSocketResponseCopyWith<$Res> {
  factory $WebSocketResponseCopyWith(
          WebSocketResponse value, $Res Function(WebSocketResponse) _then) =
      _$WebSocketResponseCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class _$WebSocketResponseCopyWithImpl<$Res>
    implements $WebSocketResponseCopyWith<$Res> {
  _$WebSocketResponseCopyWithImpl(this._self, this._then);

  final WebSocketResponse _self;
  final $Res Function(WebSocketResponse) _then;

  /// Create a copy of WebSocketResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [WebSocketResponse].
extension WebSocketResponsePatterns on WebSocketResponse {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WebSocketPongResponse value)? pong,
    TResult Function(WebSocketEventResponse value)? event,
    TResult Function(WebSocketResultResponseSuccess value)? resultSuccess,
    TResult Function(WebSocketResultResponseError value)? resultError,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WebSocketPongResponse() when pong != null:
        return pong(_that);
      case WebSocketEventResponse() when event != null:
        return event(_that);
      case WebSocketResultResponseSuccess() when resultSuccess != null:
        return resultSuccess(_that);
      case WebSocketResultResponseError() when resultError != null:
        return resultError(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WebSocketPongResponse value) pong,
    required TResult Function(WebSocketEventResponse value) event,
    required TResult Function(WebSocketResultResponseSuccess value)
        resultSuccess,
    required TResult Function(WebSocketResultResponseError value) resultError,
  }) {
    final _that = this;
    switch (_that) {
      case WebSocketPongResponse():
        return pong(_that);
      case WebSocketEventResponse():
        return event(_that);
      case WebSocketResultResponseSuccess():
        return resultSuccess(_that);
      case WebSocketResultResponseError():
        return resultError(_that);
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WebSocketPongResponse value)? pong,
    TResult? Function(WebSocketEventResponse value)? event,
    TResult? Function(WebSocketResultResponseSuccess value)? resultSuccess,
    TResult? Function(WebSocketResultResponseError value)? resultError,
  }) {
    final _that = this;
    switch (_that) {
      case WebSocketPongResponse() when pong != null:
        return pong(_that);
      case WebSocketEventResponse() when event != null:
        return event(_that);
      case WebSocketResultResponseSuccess() when resultSuccess != null:
        return resultSuccess(_that);
      case WebSocketResultResponseError() when resultError != null:
        return resultError(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? pong,
    TResult Function(int id, StatesUpdates event)? event,
    TResult Function(int id, dynamic result, bool success)? resultSuccess,
    TResult Function(int id, bool success, HassError error)? resultError,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WebSocketPongResponse() when pong != null:
        return pong(_that.id);
      case WebSocketEventResponse() when event != null:
        return event(_that.id, _that.event);
      case WebSocketResultResponseSuccess() when resultSuccess != null:
        return resultSuccess(_that.id, _that.result, _that.success);
      case WebSocketResultResponseError() when resultError != null:
        return resultError(_that.id, _that.success, _that.error);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) pong,
    required TResult Function(int id, StatesUpdates event) event,
    required TResult Function(int id, dynamic result, bool success)
        resultSuccess,
    required TResult Function(int id, bool success, HassError error)
        resultError,
  }) {
    final _that = this;
    switch (_that) {
      case WebSocketPongResponse():
        return pong(_that.id);
      case WebSocketEventResponse():
        return event(_that.id, _that.event);
      case WebSocketResultResponseSuccess():
        return resultSuccess(_that.id, _that.result, _that.success);
      case WebSocketResultResponseError():
        return resultError(_that.id, _that.success, _that.error);
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id)? pong,
    TResult? Function(int id, StatesUpdates event)? event,
    TResult? Function(int id, dynamic result, bool success)? resultSuccess,
    TResult? Function(int id, bool success, HassError error)? resultError,
  }) {
    final _that = this;
    switch (_that) {
      case WebSocketPongResponse() when pong != null:
        return pong(_that.id);
      case WebSocketEventResponse() when event != null:
        return event(_that.id, _that.event);
      case WebSocketResultResponseSuccess() when resultSuccess != null:
        return resultSuccess(_that.id, _that.result, _that.success);
      case WebSocketResultResponseError() when resultError != null:
        return resultError(_that.id, _that.success, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class WebSocketPongResponse implements WebSocketResponse {
  const WebSocketPongResponse({required this.id, final String? $type})
      : $type = $type ?? 'pong';
  factory WebSocketPongResponse.fromJson(Map<String, dynamic> json) =>
      _$WebSocketPongResponseFromJson(json);

  @override
  final int id;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of WebSocketResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebSocketPongResponseCopyWith<WebSocketPongResponse> get copyWith =>
      _$WebSocketPongResponseCopyWithImpl<WebSocketPongResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WebSocketPongResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebSocketPongResponse &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'WebSocketResponse.pong(id: $id)';
  }
}

/// @nodoc
abstract mixin class $WebSocketPongResponseCopyWith<$Res>
    implements $WebSocketResponseCopyWith<$Res> {
  factory $WebSocketPongResponseCopyWith(WebSocketPongResponse value,
          $Res Function(WebSocketPongResponse) _then) =
      _$WebSocketPongResponseCopyWithImpl;
  @override
  @useResult
  $Res call({int id});
}

/// @nodoc
class _$WebSocketPongResponseCopyWithImpl<$Res>
    implements $WebSocketPongResponseCopyWith<$Res> {
  _$WebSocketPongResponseCopyWithImpl(this._self, this._then);

  final WebSocketPongResponse _self;
  final $Res Function(WebSocketPongResponse) _then;

  /// Create a copy of WebSocketResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(WebSocketPongResponse(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class WebSocketEventResponse implements WebSocketResponse {
  const WebSocketEventResponse(
      {required this.id, required this.event, final String? $type})
      : $type = $type ?? 'event';
  factory WebSocketEventResponse.fromJson(Map<String, dynamic> json) =>
      _$WebSocketEventResponseFromJson(json);

  @override
  final int id;
  final StatesUpdates event;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of WebSocketResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebSocketEventResponseCopyWith<WebSocketEventResponse> get copyWith =>
      _$WebSocketEventResponseCopyWithImpl<WebSocketEventResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WebSocketEventResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebSocketEventResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.event, event) || other.event == event));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, event);

  @override
  String toString() {
    return 'WebSocketResponse.event(id: $id, event: $event)';
  }
}

/// @nodoc
abstract mixin class $WebSocketEventResponseCopyWith<$Res>
    implements $WebSocketResponseCopyWith<$Res> {
  factory $WebSocketEventResponseCopyWith(WebSocketEventResponse value,
          $Res Function(WebSocketEventResponse) _then) =
      _$WebSocketEventResponseCopyWithImpl;
  @override
  @useResult
  $Res call({int id, StatesUpdates event});

  $StatesUpdatesCopyWith<$Res> get event;
}

/// @nodoc
class _$WebSocketEventResponseCopyWithImpl<$Res>
    implements $WebSocketEventResponseCopyWith<$Res> {
  _$WebSocketEventResponseCopyWithImpl(this._self, this._then);

  final WebSocketEventResponse _self;
  final $Res Function(WebSocketEventResponse) _then;

  /// Create a copy of WebSocketResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? event = null,
  }) {
    return _then(WebSocketEventResponse(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      event: null == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as StatesUpdates,
    ));
  }

  /// Create a copy of WebSocketResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatesUpdatesCopyWith<$Res> get event {
    return $StatesUpdatesCopyWith<$Res>(_self.event, (value) {
      return _then(_self.copyWith(event: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class WebSocketResultResponseSuccess implements WebSocketResponse {
  const WebSocketResultResponseSuccess(
      {required this.id,
      required this.result,
      this.success = true,
      final String? $type})
      : $type = $type ?? 'resultSuccess';
  factory WebSocketResultResponseSuccess.fromJson(Map<String, dynamic> json) =>
      _$WebSocketResultResponseSuccessFromJson(json);

  @override
  final int id;
  final dynamic result;
  @JsonKey()
  final bool success;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of WebSocketResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebSocketResultResponseSuccessCopyWith<WebSocketResultResponseSuccess>
      get copyWith => _$WebSocketResultResponseSuccessCopyWithImpl<
          WebSocketResultResponseSuccess>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WebSocketResultResponseSuccessToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebSocketResultResponseSuccess &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.result, result) &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(result), success);

  @override
  String toString() {
    return 'WebSocketResponse.resultSuccess(id: $id, result: $result, success: $success)';
  }
}

/// @nodoc
abstract mixin class $WebSocketResultResponseSuccessCopyWith<$Res>
    implements $WebSocketResponseCopyWith<$Res> {
  factory $WebSocketResultResponseSuccessCopyWith(
          WebSocketResultResponseSuccess value,
          $Res Function(WebSocketResultResponseSuccess) _then) =
      _$WebSocketResultResponseSuccessCopyWithImpl;
  @override
  @useResult
  $Res call({int id, dynamic result, bool success});
}

/// @nodoc
class _$WebSocketResultResponseSuccessCopyWithImpl<$Res>
    implements $WebSocketResultResponseSuccessCopyWith<$Res> {
  _$WebSocketResultResponseSuccessCopyWithImpl(this._self, this._then);

  final WebSocketResultResponseSuccess _self;
  final $Res Function(WebSocketResultResponseSuccess) _then;

  /// Create a copy of WebSocketResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? result = freezed,
    Object? success = null,
  }) {
    return _then(WebSocketResultResponseSuccess(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      result: freezed == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as dynamic,
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class WebSocketResultResponseError implements WebSocketResponse {
  const WebSocketResultResponseError(
      {required this.id,
      this.success = false,
      required this.error,
      final String? $type})
      : $type = $type ?? 'resultError';
  factory WebSocketResultResponseError.fromJson(Map<String, dynamic> json) =>
      _$WebSocketResultResponseErrorFromJson(json);

  @override
  final int id;
  @JsonKey()
  final bool success;
  final HassError error;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of WebSocketResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebSocketResultResponseErrorCopyWith<WebSocketResultResponseError>
      get copyWith => _$WebSocketResultResponseErrorCopyWithImpl<
          WebSocketResultResponseError>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WebSocketResultResponseErrorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebSocketResultResponseError &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, success, error);

  @override
  String toString() {
    return 'WebSocketResponse.resultError(id: $id, success: $success, error: $error)';
  }
}

/// @nodoc
abstract mixin class $WebSocketResultResponseErrorCopyWith<$Res>
    implements $WebSocketResponseCopyWith<$Res> {
  factory $WebSocketResultResponseErrorCopyWith(
          WebSocketResultResponseError value,
          $Res Function(WebSocketResultResponseError) _then) =
      _$WebSocketResultResponseErrorCopyWithImpl;
  @override
  @useResult
  $Res call({int id, bool success, HassError error});

  $HassErrorCopyWith<$Res> get error;
}

/// @nodoc
class _$WebSocketResultResponseErrorCopyWithImpl<$Res>
    implements $WebSocketResultResponseErrorCopyWith<$Res> {
  _$WebSocketResultResponseErrorCopyWithImpl(this._self, this._then);

  final WebSocketResultResponseError _self;
  final $Res Function(WebSocketResultResponseError) _then;

  /// Create a copy of WebSocketResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? success = null,
    Object? error = null,
  }) {
    return _then(WebSocketResultResponseError(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as HassError,
    ));
  }

  /// Create a copy of WebSocketResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HassErrorCopyWith<$Res> get error {
    return $HassErrorCopyWith<$Res>(_self.error, (value) {
      return _then(_self.copyWith(error: value));
    });
  }
}

// dart format on
