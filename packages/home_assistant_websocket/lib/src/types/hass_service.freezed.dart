// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hass_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HassDomainServices {
  Map<String, HassService> get services;

  /// Create a copy of HassDomainServices
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HassDomainServicesCopyWith<HassDomainServices> get copyWith =>
      _$HassDomainServicesCopyWithImpl<HassDomainServices>(
          this as HassDomainServices, _$identity);

  /// Serializes this HassDomainServices to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HassDomainServices &&
            const DeepCollectionEquality().equals(other.services, services));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(services));

  @override
  String toString() {
    return 'HassDomainServices(services: $services)';
  }
}

/// @nodoc
abstract mixin class $HassDomainServicesCopyWith<$Res> {
  factory $HassDomainServicesCopyWith(
          HassDomainServices value, $Res Function(HassDomainServices) _then) =
      _$HassDomainServicesCopyWithImpl;
  @useResult
  $Res call({Map<String, HassService> services});
}

/// @nodoc
class _$HassDomainServicesCopyWithImpl<$Res>
    implements $HassDomainServicesCopyWith<$Res> {
  _$HassDomainServicesCopyWithImpl(this._self, this._then);

  final HassDomainServices _self;
  final $Res Function(HassDomainServices) _then;

  /// Create a copy of HassDomainServices
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? services = null,
  }) {
    return _then(_self.copyWith(
      services: null == services
          ? _self.services
          : services // ignore: cast_nullable_to_non_nullable
              as Map<String, HassService>,
    ));
  }
}

/// Adds pattern-matching-related methods to [HassDomainServices].
extension HassDomainServicesPatterns on HassDomainServices {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_HassDomainServices value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HassDomainServices() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_HassDomainServices value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HassDomainServices():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_HassDomainServices value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HassDomainServices() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Map<String, HassService> services)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HassDomainServices() when $default != null:
        return $default(_that.services);
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
  TResult when<TResult extends Object?>(
    TResult Function(Map<String, HassService> services) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HassDomainServices():
        return $default(_that.services);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(Map<String, HassService> services)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HassDomainServices() when $default != null:
        return $default(_that.services);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HassDomainServices implements HassDomainServices {
  _HassDomainServices(final Map<String, HassService> services)
      : _services = services;
  factory _HassDomainServices.fromJson(Map<String, dynamic> json) =>
      _$HassDomainServicesFromJson(json);

  final Map<String, HassService> _services;
  @override
  Map<String, HassService> get services {
    if (_services is EqualUnmodifiableMapView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_services);
  }

  /// Create a copy of HassDomainServices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HassDomainServicesCopyWith<_HassDomainServices> get copyWith =>
      __$HassDomainServicesCopyWithImpl<_HassDomainServices>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HassDomainServicesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HassDomainServices &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_services));

  @override
  String toString() {
    return 'HassDomainServices(services: $services)';
  }
}

/// @nodoc
abstract mixin class _$HassDomainServicesCopyWith<$Res>
    implements $HassDomainServicesCopyWith<$Res> {
  factory _$HassDomainServicesCopyWith(
          _HassDomainServices value, $Res Function(_HassDomainServices) _then) =
      __$HassDomainServicesCopyWithImpl;
  @override
  @useResult
  $Res call({Map<String, HassService> services});
}

/// @nodoc
class __$HassDomainServicesCopyWithImpl<$Res>
    implements _$HassDomainServicesCopyWith<$Res> {
  __$HassDomainServicesCopyWithImpl(this._self, this._then);

  final _HassDomainServices _self;
  final $Res Function(_HassDomainServices) _then;

  /// Create a copy of HassDomainServices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? services = null,
  }) {
    return _then(_HassDomainServices(
      null == services
          ? _self._services
          : services // ignore: cast_nullable_to_non_nullable
              as Map<String, HassService>,
    ));
  }
}

/// @nodoc
mixin _$HassServices {
  Map<String, HassDomainServices> get domains;

  /// Create a copy of HassServices
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HassServicesCopyWith<HassServices> get copyWith =>
      _$HassServicesCopyWithImpl<HassServices>(
          this as HassServices, _$identity);

  /// Serializes this HassServices to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HassServices &&
            const DeepCollectionEquality().equals(other.domains, domains));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(domains));

  @override
  String toString() {
    return 'HassServices(domains: $domains)';
  }
}

/// @nodoc
abstract mixin class $HassServicesCopyWith<$Res> {
  factory $HassServicesCopyWith(
          HassServices value, $Res Function(HassServices) _then) =
      _$HassServicesCopyWithImpl;
  @useResult
  $Res call({Map<String, HassDomainServices> domains});
}

/// @nodoc
class _$HassServicesCopyWithImpl<$Res> implements $HassServicesCopyWith<$Res> {
  _$HassServicesCopyWithImpl(this._self, this._then);

  final HassServices _self;
  final $Res Function(HassServices) _then;

  /// Create a copy of HassServices
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domains = null,
  }) {
    return _then(_self.copyWith(
      domains: null == domains
          ? _self.domains
          : domains // ignore: cast_nullable_to_non_nullable
              as Map<String, HassDomainServices>,
    ));
  }
}

/// Adds pattern-matching-related methods to [HassServices].
extension HassServicesPatterns on HassServices {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_HassServices value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HassServices() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_HassServices value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HassServices():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_HassServices value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HassServices() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Map<String, HassDomainServices> domains)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HassServices() when $default != null:
        return $default(_that.domains);
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
  TResult when<TResult extends Object?>(
    TResult Function(Map<String, HassDomainServices> domains) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HassServices():
        return $default(_that.domains);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(Map<String, HassDomainServices> domains)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HassServices() when $default != null:
        return $default(_that.domains);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HassServices implements HassServices {
  _HassServices(final Map<String, HassDomainServices> domains)
      : _domains = domains;
  factory _HassServices.fromJson(Map<String, dynamic> json) =>
      _$HassServicesFromJson(json);

  final Map<String, HassDomainServices> _domains;
  @override
  Map<String, HassDomainServices> get domains {
    if (_domains is EqualUnmodifiableMapView) return _domains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_domains);
  }

  /// Create a copy of HassServices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HassServicesCopyWith<_HassServices> get copyWith =>
      __$HassServicesCopyWithImpl<_HassServices>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HassServicesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HassServices &&
            const DeepCollectionEquality().equals(other._domains, _domains));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_domains));

  @override
  String toString() {
    return 'HassServices(domains: $domains)';
  }
}

/// @nodoc
abstract mixin class _$HassServicesCopyWith<$Res>
    implements $HassServicesCopyWith<$Res> {
  factory _$HassServicesCopyWith(
          _HassServices value, $Res Function(_HassServices) _then) =
      __$HassServicesCopyWithImpl;
  @override
  @useResult
  $Res call({Map<String, HassDomainServices> domains});
}

/// @nodoc
class __$HassServicesCopyWithImpl<$Res>
    implements _$HassServicesCopyWith<$Res> {
  __$HassServicesCopyWithImpl(this._self, this._then);

  final _HassServices _self;
  final $Res Function(_HassServices) _then;

  /// Create a copy of HassServices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? domains = null,
  }) {
    return _then(_HassServices(
      null == domains
          ? _self._domains
          : domains // ignore: cast_nullable_to_non_nullable
              as Map<String, HassDomainServices>,
    ));
  }
}

/// @nodoc
mixin _$HassService {
  String? get name;
  String get description;
  Map<String, dynamic>? get target;
  Map<String, Field> get fields;
  Response? get response;

  /// Create a copy of HassService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HassServiceCopyWith<HassService> get copyWith =>
      _$HassServiceCopyWithImpl<HassService>(this as HassService, _$identity);

  /// Serializes this HassService to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HassService &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.target, target) &&
            const DeepCollectionEquality().equals(other.fields, fields) &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(target),
      const DeepCollectionEquality().hash(fields),
      response);

  @override
  String toString() {
    return 'HassService(name: $name, description: $description, target: $target, fields: $fields, response: $response)';
  }
}

/// @nodoc
abstract mixin class $HassServiceCopyWith<$Res> {
  factory $HassServiceCopyWith(
          HassService value, $Res Function(HassService) _then) =
      _$HassServiceCopyWithImpl;
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
class _$HassServiceCopyWithImpl<$Res> implements $HassServiceCopyWith<$Res> {
  _$HassServiceCopyWithImpl(this._self, this._then);

  final HassService _self;
  final $Res Function(HassService) _then;

  /// Create a copy of HassService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = null,
    Object? target = freezed,
    Object? fields = null,
    Object? response = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      target: freezed == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      fields: null == fields
          ? _self.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Map<String, Field>,
      response: freezed == response
          ? _self.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response?,
    ));
  }

  /// Create a copy of HassService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResponseCopyWith<$Res>? get response {
    if (_self.response == null) {
      return null;
    }

    return $ResponseCopyWith<$Res>(_self.response!, (value) {
      return _then(_self.copyWith(response: value));
    });
  }
}

/// Adds pattern-matching-related methods to [HassService].
extension HassServicePatterns on HassService {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_HassService value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HassService() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_HassService value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HassService():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_HassService value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HassService() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String? name,
            String description,
            Map<String, dynamic>? target,
            Map<String, Field> fields,
            Response? response)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HassService() when $default != null:
        return $default(_that.name, _that.description, _that.target,
            _that.fields, _that.response);
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
  TResult when<TResult extends Object?>(
    TResult Function(
            String? name,
            String description,
            Map<String, dynamic>? target,
            Map<String, Field> fields,
            Response? response)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HassService():
        return $default(_that.name, _that.description, _that.target,
            _that.fields, _that.response);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String? name,
            String description,
            Map<String, dynamic>? target,
            Map<String, Field> fields,
            Response? response)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HassService() when $default != null:
        return $default(_that.name, _that.description, _that.target,
            _that.fields, _that.response);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HassService implements HassService {
  const _HassService(
      {this.name,
      required this.description,
      final Map<String, dynamic>? target,
      required final Map<String, Field> fields,
      this.response})
      : _target = target,
        _fields = fields;
  factory _HassService.fromJson(Map<String, dynamic> json) =>
      _$HassServiceFromJson(json);

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

  /// Create a copy of HassService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HassServiceCopyWith<_HassService> get copyWith =>
      __$HassServiceCopyWithImpl<_HassService>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HassServiceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HassService &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._target, _target) &&
            const DeepCollectionEquality().equals(other._fields, _fields) &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(_target),
      const DeepCollectionEquality().hash(_fields),
      response);

  @override
  String toString() {
    return 'HassService(name: $name, description: $description, target: $target, fields: $fields, response: $response)';
  }
}

/// @nodoc
abstract mixin class _$HassServiceCopyWith<$Res>
    implements $HassServiceCopyWith<$Res> {
  factory _$HassServiceCopyWith(
          _HassService value, $Res Function(_HassService) _then) =
      __$HassServiceCopyWithImpl;
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
class __$HassServiceCopyWithImpl<$Res> implements _$HassServiceCopyWith<$Res> {
  __$HassServiceCopyWithImpl(this._self, this._then);

  final _HassService _self;
  final $Res Function(_HassService) _then;

  /// Create a copy of HassService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? description = null,
    Object? target = freezed,
    Object? fields = null,
    Object? response = freezed,
  }) {
    return _then(_HassService(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      target: freezed == target
          ? _self._target
          : target // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      fields: null == fields
          ? _self._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Map<String, Field>,
      response: freezed == response
          ? _self.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response?,
    ));
  }

  /// Create a copy of HassService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResponseCopyWith<$Res>? get response {
    if (_self.response == null) {
      return null;
    }

    return $ResponseCopyWith<$Res>(_self.response!, (value) {
      return _then(_self.copyWith(response: value));
    });
  }
}

/// @nodoc
mixin _$Field {
  String? get name;
  String? get description;
  dynamic get example;
  Map<String, dynamic>? get selector;
  FieldFilter? get filter;

  /// Create a copy of Field
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FieldCopyWith<Field> get copyWith =>
      _$FieldCopyWithImpl<Field>(this as Field, _$identity);

  /// Serializes this Field to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Field &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.example, example) &&
            const DeepCollectionEquality().equals(other.selector, selector) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(example),
      const DeepCollectionEquality().hash(selector),
      filter);

  @override
  String toString() {
    return 'Field(name: $name, description: $description, example: $example, selector: $selector, filter: $filter)';
  }
}

/// @nodoc
abstract mixin class $FieldCopyWith<$Res> {
  factory $FieldCopyWith(Field value, $Res Function(Field) _then) =
      _$FieldCopyWithImpl;
  @useResult
  $Res call(
      {String? name,
      String? description,
      dynamic example,
      Map<String, dynamic>? selector,
      FieldFilter? filter});

  $FieldFilterCopyWith<$Res>? get filter;
}

/// @nodoc
class _$FieldCopyWithImpl<$Res> implements $FieldCopyWith<$Res> {
  _$FieldCopyWithImpl(this._self, this._then);

  final Field _self;
  final $Res Function(Field) _then;

  /// Create a copy of Field
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? example = freezed,
    Object? selector = freezed,
    Object? filter = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      example: freezed == example
          ? _self.example
          : example // ignore: cast_nullable_to_non_nullable
              as dynamic,
      selector: freezed == selector
          ? _self.selector
          : selector // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      filter: freezed == filter
          ? _self.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as FieldFilter?,
    ));
  }

  /// Create a copy of Field
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FieldFilterCopyWith<$Res>? get filter {
    if (_self.filter == null) {
      return null;
    }

    return $FieldFilterCopyWith<$Res>(_self.filter!, (value) {
      return _then(_self.copyWith(filter: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Field].
extension FieldPatterns on Field {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Field value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Field() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_Field value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Field():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Field value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Field() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String? name, String? description, dynamic example,
            Map<String, dynamic>? selector, FieldFilter? filter)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Field() when $default != null:
        return $default(_that.name, _that.description, _that.example,
            _that.selector, _that.filter);
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
  TResult when<TResult extends Object?>(
    TResult Function(String? name, String? description, dynamic example,
            Map<String, dynamic>? selector, FieldFilter? filter)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Field():
        return $default(_that.name, _that.description, _that.example,
            _that.selector, _that.filter);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String? name, String? description, dynamic example,
            Map<String, dynamic>? selector, FieldFilter? filter)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Field() when $default != null:
        return $default(_that.name, _that.description, _that.example,
            _that.selector, _that.filter);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Field implements Field {
  const _Field(
      {this.name = '',
      this.description = '',
      this.example,
      final Map<String, dynamic>? selector,
      this.filter})
      : _selector = selector;
  factory _Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  @override
  @JsonKey()
  final String? name;
  @override
  @JsonKey()
  final String? description;
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
  final FieldFilter? filter;

  /// Create a copy of Field
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FieldCopyWith<_Field> get copyWith =>
      __$FieldCopyWithImpl<_Field>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FieldToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Field &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.example, example) &&
            const DeepCollectionEquality().equals(other._selector, _selector) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(example),
      const DeepCollectionEquality().hash(_selector),
      filter);

  @override
  String toString() {
    return 'Field(name: $name, description: $description, example: $example, selector: $selector, filter: $filter)';
  }
}

/// @nodoc
abstract mixin class _$FieldCopyWith<$Res> implements $FieldCopyWith<$Res> {
  factory _$FieldCopyWith(_Field value, $Res Function(_Field) _then) =
      __$FieldCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? name,
      String? description,
      dynamic example,
      Map<String, dynamic>? selector,
      FieldFilter? filter});

  @override
  $FieldFilterCopyWith<$Res>? get filter;
}

/// @nodoc
class __$FieldCopyWithImpl<$Res> implements _$FieldCopyWith<$Res> {
  __$FieldCopyWithImpl(this._self, this._then);

  final _Field _self;
  final $Res Function(_Field) _then;

  /// Create a copy of Field
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? example = freezed,
    Object? selector = freezed,
    Object? filter = freezed,
  }) {
    return _then(_Field(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      example: freezed == example
          ? _self.example
          : example // ignore: cast_nullable_to_non_nullable
              as dynamic,
      selector: freezed == selector
          ? _self._selector
          : selector // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      filter: freezed == filter
          ? _self.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as FieldFilter?,
    ));
  }

  /// Create a copy of Field
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FieldFilterCopyWith<$Res>? get filter {
    if (_self.filter == null) {
      return null;
    }

    return $FieldFilterCopyWith<$Res>(_self.filter!, (value) {
      return _then(_self.copyWith(filter: value));
    });
  }
}

/// @nodoc
mixin _$FieldFilter {
// ignore: non_constant_identifier_names
  List<int>? get supported_features;
  Map<String, dynamic>? get attribute;

  /// Create a copy of FieldFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FieldFilterCopyWith<FieldFilter> get copyWith =>
      _$FieldFilterCopyWithImpl<FieldFilter>(this as FieldFilter, _$identity);

  /// Serializes this FieldFilter to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FieldFilter &&
            const DeepCollectionEquality()
                .equals(other.supported_features, supported_features) &&
            const DeepCollectionEquality().equals(other.attribute, attribute));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(supported_features),
      const DeepCollectionEquality().hash(attribute));

  @override
  String toString() {
    return 'FieldFilter(supported_features: $supported_features, attribute: $attribute)';
  }
}

/// @nodoc
abstract mixin class $FieldFilterCopyWith<$Res> {
  factory $FieldFilterCopyWith(
          FieldFilter value, $Res Function(FieldFilter) _then) =
      _$FieldFilterCopyWithImpl;
  @useResult
  $Res call({List<int>? supported_features, Map<String, dynamic>? attribute});
}

/// @nodoc
class _$FieldFilterCopyWithImpl<$Res> implements $FieldFilterCopyWith<$Res> {
  _$FieldFilterCopyWithImpl(this._self, this._then);

  final FieldFilter _self;
  final $Res Function(FieldFilter) _then;

  /// Create a copy of FieldFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supported_features = freezed,
    Object? attribute = freezed,
  }) {
    return _then(_self.copyWith(
      supported_features: freezed == supported_features
          ? _self.supported_features
          : supported_features // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      attribute: freezed == attribute
          ? _self.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [FieldFilter].
extension FieldFilterPatterns on FieldFilter {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FieldFilter value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FieldFilter() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_FieldFilter value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldFilter():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FieldFilter value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldFilter() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<int>? supported_features, Map<String, dynamic>? attribute)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FieldFilter() when $default != null:
        return $default(_that.supported_features, _that.attribute);
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
  TResult when<TResult extends Object?>(
    TResult Function(
            List<int>? supported_features, Map<String, dynamic>? attribute)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldFilter():
        return $default(_that.supported_features, _that.attribute);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<int>? supported_features, Map<String, dynamic>? attribute)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldFilter() when $default != null:
        return $default(_that.supported_features, _that.attribute);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FieldFilter implements FieldFilter {
  _FieldFilter(final List<int>? supported_features,
      final Map<String, dynamic>? attribute)
      : _supported_features = supported_features,
        _attribute = attribute;
  factory _FieldFilter.fromJson(Map<String, dynamic> json) =>
      _$FieldFilterFromJson(json);

// ignore: non_constant_identifier_names
  final List<int>? _supported_features;
// ignore: non_constant_identifier_names
  @override
  List<int>? get supported_features {
    final value = _supported_features;
    if (value == null) return null;
    if (_supported_features is EqualUnmodifiableListView)
      return _supported_features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _attribute;
  @override
  Map<String, dynamic>? get attribute {
    final value = _attribute;
    if (value == null) return null;
    if (_attribute is EqualUnmodifiableMapView) return _attribute;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of FieldFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FieldFilterCopyWith<_FieldFilter> get copyWith =>
      __$FieldFilterCopyWithImpl<_FieldFilter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FieldFilterToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FieldFilter &&
            const DeepCollectionEquality()
                .equals(other._supported_features, _supported_features) &&
            const DeepCollectionEquality()
                .equals(other._attribute, _attribute));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_supported_features),
      const DeepCollectionEquality().hash(_attribute));

  @override
  String toString() {
    return 'FieldFilter(supported_features: $supported_features, attribute: $attribute)';
  }
}

/// @nodoc
abstract mixin class _$FieldFilterCopyWith<$Res>
    implements $FieldFilterCopyWith<$Res> {
  factory _$FieldFilterCopyWith(
          _FieldFilter value, $Res Function(_FieldFilter) _then) =
      __$FieldFilterCopyWithImpl;
  @override
  @useResult
  $Res call({List<int>? supported_features, Map<String, dynamic>? attribute});
}

/// @nodoc
class __$FieldFilterCopyWithImpl<$Res> implements _$FieldFilterCopyWith<$Res> {
  __$FieldFilterCopyWithImpl(this._self, this._then);

  final _FieldFilter _self;
  final $Res Function(_FieldFilter) _then;

  /// Create a copy of FieldFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? supported_features = freezed,
    Object? attribute = freezed,
  }) {
    return _then(_FieldFilter(
      freezed == supported_features
          ? _self._supported_features
          : supported_features // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      freezed == attribute
          ? _self._attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$Response {
  bool get optional;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ResponseCopyWith<Response> get copyWith =>
      _$ResponseCopyWithImpl<Response>(this as Response, _$identity);

  /// Serializes this Response to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Response &&
            (identical(other.optional, optional) ||
                other.optional == optional));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, optional);

  @override
  String toString() {
    return 'Response(optional: $optional)';
  }
}

/// @nodoc
abstract mixin class $ResponseCopyWith<$Res> {
  factory $ResponseCopyWith(Response value, $Res Function(Response) _then) =
      _$ResponseCopyWithImpl;
  @useResult
  $Res call({bool optional});
}

/// @nodoc
class _$ResponseCopyWithImpl<$Res> implements $ResponseCopyWith<$Res> {
  _$ResponseCopyWithImpl(this._self, this._then);

  final Response _self;
  final $Res Function(Response) _then;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optional = null,
  }) {
    return _then(_self.copyWith(
      optional: null == optional
          ? _self.optional
          : optional // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [Response].
extension ResponsePatterns on Response {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Response value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Response() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_Response value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Response():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Response value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Response() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(bool optional)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Response() when $default != null:
        return $default(_that.optional);
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
  TResult when<TResult extends Object?>(
    TResult Function(bool optional) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Response():
        return $default(_that.optional);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(bool optional)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Response() when $default != null:
        return $default(_that.optional);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Response implements Response {
  const _Response({required this.optional});
  factory _Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  @override
  final bool optional;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ResponseCopyWith<_Response> get copyWith =>
      __$ResponseCopyWithImpl<_Response>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Response &&
            (identical(other.optional, optional) ||
                other.optional == optional));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, optional);

  @override
  String toString() {
    return 'Response(optional: $optional)';
  }
}

/// @nodoc
abstract mixin class _$ResponseCopyWith<$Res>
    implements $ResponseCopyWith<$Res> {
  factory _$ResponseCopyWith(_Response value, $Res Function(_Response) _then) =
      __$ResponseCopyWithImpl;
  @override
  @useResult
  $Res call({bool optional});
}

/// @nodoc
class __$ResponseCopyWithImpl<$Res> implements _$ResponseCopyWith<$Res> {
  __$ResponseCopyWithImpl(this._self, this._then);

  final _Response _self;
  final $Res Function(_Response) _then;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? optional = null,
  }) {
    return _then(_Response(
      optional: null == optional
          ? _self.optional
          : optional // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
