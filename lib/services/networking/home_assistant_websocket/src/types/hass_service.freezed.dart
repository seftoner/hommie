// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hass_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HassDomainServices _$HassDomainServicesFromJson(Map<String, dynamic> json) {
  return _HassDomainServices.fromJson(json);
}

/// @nodoc
mixin _$HassDomainServices {
  Map<String, HassService> get services => throw _privateConstructorUsedError;

  /// Serializes this HassDomainServices to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HassDomainServices
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HassDomainServicesCopyWith<HassDomainServices> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HassDomainServicesCopyWith<$Res> {
  factory $HassDomainServicesCopyWith(
          HassDomainServices value, $Res Function(HassDomainServices) then) =
      _$HassDomainServicesCopyWithImpl<$Res, HassDomainServices>;
  @useResult
  $Res call({Map<String, HassService> services});
}

/// @nodoc
class _$HassDomainServicesCopyWithImpl<$Res, $Val extends HassDomainServices>
    implements $HassDomainServicesCopyWith<$Res> {
  _$HassDomainServicesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HassDomainServices
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? services = null,
  }) {
    return _then(_value.copyWith(
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as Map<String, HassService>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HassDomainServicesImplCopyWith<$Res>
    implements $HassDomainServicesCopyWith<$Res> {
  factory _$$HassDomainServicesImplCopyWith(_$HassDomainServicesImpl value,
          $Res Function(_$HassDomainServicesImpl) then) =
      __$$HassDomainServicesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, HassService> services});
}

/// @nodoc
class __$$HassDomainServicesImplCopyWithImpl<$Res>
    extends _$HassDomainServicesCopyWithImpl<$Res, _$HassDomainServicesImpl>
    implements _$$HassDomainServicesImplCopyWith<$Res> {
  __$$HassDomainServicesImplCopyWithImpl(_$HassDomainServicesImpl _value,
      $Res Function(_$HassDomainServicesImpl) _then)
      : super(_value, _then);

  /// Create a copy of HassDomainServices
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? services = null,
  }) {
    return _then(_$HassDomainServicesImpl(
      null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as Map<String, HassService>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HassDomainServicesImpl implements _HassDomainServices {
  _$HassDomainServicesImpl(final Map<String, HassService> services)
      : _services = services;

  factory _$HassDomainServicesImpl.fromJson(Map<String, dynamic> json) =>
      _$$HassDomainServicesImplFromJson(json);

  final Map<String, HassService> _services;
  @override
  Map<String, HassService> get services {
    if (_services is EqualUnmodifiableMapView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_services);
  }

  @override
  String toString() {
    return 'HassDomainServices(services: $services)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HassDomainServicesImpl &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_services));

  /// Create a copy of HassDomainServices
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HassDomainServicesImplCopyWith<_$HassDomainServicesImpl> get copyWith =>
      __$$HassDomainServicesImplCopyWithImpl<_$HassDomainServicesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HassDomainServicesImplToJson(
      this,
    );
  }
}

abstract class _HassDomainServices implements HassDomainServices {
  factory _HassDomainServices(final Map<String, HassService> services) =
      _$HassDomainServicesImpl;

  factory _HassDomainServices.fromJson(Map<String, dynamic> json) =
      _$HassDomainServicesImpl.fromJson;

  @override
  Map<String, HassService> get services;

  /// Create a copy of HassDomainServices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HassDomainServicesImplCopyWith<_$HassDomainServicesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HassServices _$HassServicesFromJson(Map<String, dynamic> json) {
  return _HassServices.fromJson(json);
}

/// @nodoc
mixin _$HassServices {
  Map<String, HassDomainServices> get domains =>
      throw _privateConstructorUsedError;

  /// Serializes this HassServices to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HassServices
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HassServicesCopyWith<HassServices> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HassServicesCopyWith<$Res> {
  factory $HassServicesCopyWith(
          HassServices value, $Res Function(HassServices) then) =
      _$HassServicesCopyWithImpl<$Res, HassServices>;
  @useResult
  $Res call({Map<String, HassDomainServices> domains});
}

/// @nodoc
class _$HassServicesCopyWithImpl<$Res, $Val extends HassServices>
    implements $HassServicesCopyWith<$Res> {
  _$HassServicesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HassServices
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domains = null,
  }) {
    return _then(_value.copyWith(
      domains: null == domains
          ? _value.domains
          : domains // ignore: cast_nullable_to_non_nullable
              as Map<String, HassDomainServices>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HassServicesImplCopyWith<$Res>
    implements $HassServicesCopyWith<$Res> {
  factory _$$HassServicesImplCopyWith(
          _$HassServicesImpl value, $Res Function(_$HassServicesImpl) then) =
      __$$HassServicesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, HassDomainServices> domains});
}

/// @nodoc
class __$$HassServicesImplCopyWithImpl<$Res>
    extends _$HassServicesCopyWithImpl<$Res, _$HassServicesImpl>
    implements _$$HassServicesImplCopyWith<$Res> {
  __$$HassServicesImplCopyWithImpl(
      _$HassServicesImpl _value, $Res Function(_$HassServicesImpl) _then)
      : super(_value, _then);

  /// Create a copy of HassServices
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domains = null,
  }) {
    return _then(_$HassServicesImpl(
      null == domains
          ? _value._domains
          : domains // ignore: cast_nullable_to_non_nullable
              as Map<String, HassDomainServices>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HassServicesImpl implements _HassServices {
  _$HassServicesImpl(final Map<String, HassDomainServices> domains)
      : _domains = domains;

  factory _$HassServicesImpl.fromJson(Map<String, dynamic> json) =>
      _$$HassServicesImplFromJson(json);

  final Map<String, HassDomainServices> _domains;
  @override
  Map<String, HassDomainServices> get domains {
    if (_domains is EqualUnmodifiableMapView) return _domains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_domains);
  }

  @override
  String toString() {
    return 'HassServices(domains: $domains)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HassServicesImpl &&
            const DeepCollectionEquality().equals(other._domains, _domains));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_domains));

  /// Create a copy of HassServices
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HassServicesImplCopyWith<_$HassServicesImpl> get copyWith =>
      __$$HassServicesImplCopyWithImpl<_$HassServicesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HassServicesImplToJson(
      this,
    );
  }
}

abstract class _HassServices implements HassServices {
  factory _HassServices(final Map<String, HassDomainServices> domains) =
      _$HassServicesImpl;

  factory _HassServices.fromJson(Map<String, dynamic> json) =
      _$HassServicesImpl.fromJson;

  @override
  Map<String, HassDomainServices> get domains;

  /// Create a copy of HassServices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HassServicesImplCopyWith<_$HassServicesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HassService _$HassServiceFromJson(Map<String, dynamic> json) {
  return _HassService.fromJson(json);
}

/// @nodoc
mixin _$HassService {
  String? get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get target => throw _privateConstructorUsedError;
  Map<String, Field> get fields => throw _privateConstructorUsedError;
  Response? get response => throw _privateConstructorUsedError;

  /// Serializes this HassService to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HassService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of HassService
  /// with the given fields replaced by the non-null parameter values.
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
@JsonSerializable()
class _$HassServiceImpl implements _HassService {
  const _$HassServiceImpl(
      {this.name,
      required this.description,
      final Map<String, dynamic>? target,
      required final Map<String, Field> fields,
      this.response})
      : _target = target,
        _fields = fields;

  factory _$HassServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$HassServiceImplFromJson(json);

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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(_target),
      const DeepCollectionEquality().hash(_fields),
      response);

  /// Create a copy of HassService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HassServiceImplCopyWith<_$HassServiceImpl> get copyWith =>
      __$$HassServiceImplCopyWithImpl<_$HassServiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HassServiceImplToJson(
      this,
    );
  }
}

abstract class _HassService implements HassService {
  const factory _HassService(
      {final String? name,
      required final String description,
      final Map<String, dynamic>? target,
      required final Map<String, Field> fields,
      final Response? response}) = _$HassServiceImpl;

  factory _HassService.fromJson(Map<String, dynamic> json) =
      _$HassServiceImpl.fromJson;

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

  /// Create a copy of HassService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HassServiceImplCopyWith<_$HassServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Field _$FieldFromJson(Map<String, dynamic> json) {
  return _Field.fromJson(json);
}

/// @nodoc
mixin _$Field {
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  dynamic get example => throw _privateConstructorUsedError;
  Map<String, dynamic>? get selector => throw _privateConstructorUsedError;
  FieldFilter? get filter => throw _privateConstructorUsedError;

  /// Serializes this Field to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Field
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FieldCopyWith<Field> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldCopyWith<$Res> {
  factory $FieldCopyWith(Field value, $Res Function(Field) then) =
      _$FieldCopyWithImpl<$Res, Field>;
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
class _$FieldCopyWithImpl<$Res, $Val extends Field>
    implements $FieldCopyWith<$Res> {
  _$FieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      example: freezed == example
          ? _value.example
          : example // ignore: cast_nullable_to_non_nullable
              as dynamic,
      selector: freezed == selector
          ? _value.selector
          : selector // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as FieldFilter?,
    ) as $Val);
  }

  /// Create a copy of Field
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FieldFilterCopyWith<$Res>? get filter {
    if (_value.filter == null) {
      return null;
    }

    return $FieldFilterCopyWith<$Res>(_value.filter!, (value) {
      return _then(_value.copyWith(filter: value) as $Val);
    });
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
      String? description,
      dynamic example,
      Map<String, dynamic>? selector,
      FieldFilter? filter});

  @override
  $FieldFilterCopyWith<$Res>? get filter;
}

/// @nodoc
class __$$FieldImplCopyWithImpl<$Res>
    extends _$FieldCopyWithImpl<$Res, _$FieldImpl>
    implements _$$FieldImplCopyWith<$Res> {
  __$$FieldImplCopyWithImpl(
      _$FieldImpl _value, $Res Function(_$FieldImpl) _then)
      : super(_value, _then);

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
    return _then(_$FieldImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      example: freezed == example
          ? _value.example
          : example // ignore: cast_nullable_to_non_nullable
              as dynamic,
      selector: freezed == selector
          ? _value._selector
          : selector // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as FieldFilter?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldImpl implements _Field {
  const _$FieldImpl(
      {this.name = '',
      this.description = '',
      this.example,
      final Map<String, dynamic>? selector,
      this.filter})
      : _selector = selector;

  factory _$FieldImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldImplFromJson(json);

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

  @override
  String toString() {
    return 'Field(name: $name, description: $description, example: $example, selector: $selector, filter: $filter)';
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

  /// Create a copy of Field
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldImplCopyWith<_$FieldImpl> get copyWith =>
      __$$FieldImplCopyWithImpl<_$FieldImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldImplToJson(
      this,
    );
  }
}

abstract class _Field implements Field {
  const factory _Field(
      {final String? name,
      final String? description,
      final dynamic example,
      final Map<String, dynamic>? selector,
      final FieldFilter? filter}) = _$FieldImpl;

  factory _Field.fromJson(Map<String, dynamic> json) = _$FieldImpl.fromJson;

  @override
  String? get name;
  @override
  String? get description;
  @override
  dynamic get example;
  @override
  Map<String, dynamic>? get selector;
  @override
  FieldFilter? get filter;

  /// Create a copy of Field
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FieldImplCopyWith<_$FieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FieldFilter _$FieldFilterFromJson(Map<String, dynamic> json) {
  return _FieldFilter.fromJson(json);
}

/// @nodoc
mixin _$FieldFilter {
// ignore: non_constant_identifier_names
  List<int>? get supported_features => throw _privateConstructorUsedError;
  Map<String, dynamic>? get attribute => throw _privateConstructorUsedError;

  /// Serializes this FieldFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FieldFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FieldFilterCopyWith<FieldFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldFilterCopyWith<$Res> {
  factory $FieldFilterCopyWith(
          FieldFilter value, $Res Function(FieldFilter) then) =
      _$FieldFilterCopyWithImpl<$Res, FieldFilter>;
  @useResult
  $Res call({List<int>? supported_features, Map<String, dynamic>? attribute});
}

/// @nodoc
class _$FieldFilterCopyWithImpl<$Res, $Val extends FieldFilter>
    implements $FieldFilterCopyWith<$Res> {
  _$FieldFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FieldFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supported_features = freezed,
    Object? attribute = freezed,
  }) {
    return _then(_value.copyWith(
      supported_features: freezed == supported_features
          ? _value.supported_features
          : supported_features // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      attribute: freezed == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FieldFilterImplCopyWith<$Res>
    implements $FieldFilterCopyWith<$Res> {
  factory _$$FieldFilterImplCopyWith(
          _$FieldFilterImpl value, $Res Function(_$FieldFilterImpl) then) =
      __$$FieldFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int>? supported_features, Map<String, dynamic>? attribute});
}

/// @nodoc
class __$$FieldFilterImplCopyWithImpl<$Res>
    extends _$FieldFilterCopyWithImpl<$Res, _$FieldFilterImpl>
    implements _$$FieldFilterImplCopyWith<$Res> {
  __$$FieldFilterImplCopyWithImpl(
      _$FieldFilterImpl _value, $Res Function(_$FieldFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of FieldFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supported_features = freezed,
    Object? attribute = freezed,
  }) {
    return _then(_$FieldFilterImpl(
      freezed == supported_features
          ? _value._supported_features
          : supported_features // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      freezed == attribute
          ? _value._attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldFilterImpl implements _FieldFilter {
  _$FieldFilterImpl(final List<int>? supported_features,
      final Map<String, dynamic>? attribute)
      : _supported_features = supported_features,
        _attribute = attribute;

  factory _$FieldFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldFilterImplFromJson(json);

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

  @override
  String toString() {
    return 'FieldFilter(supported_features: $supported_features, attribute: $attribute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldFilterImpl &&
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

  /// Create a copy of FieldFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldFilterImplCopyWith<_$FieldFilterImpl> get copyWith =>
      __$$FieldFilterImplCopyWithImpl<_$FieldFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldFilterImplToJson(
      this,
    );
  }
}

abstract class _FieldFilter implements FieldFilter {
  factory _FieldFilter(final List<int>? supported_features,
      final Map<String, dynamic>? attribute) = _$FieldFilterImpl;

  factory _FieldFilter.fromJson(Map<String, dynamic> json) =
      _$FieldFilterImpl.fromJson;

// ignore: non_constant_identifier_names
  @override
  List<int>? get supported_features;
  @override
  Map<String, dynamic>? get attribute;

  /// Create a copy of FieldFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FieldFilterImplCopyWith<_$FieldFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return _Response.fromJson(json);
}

/// @nodoc
mixin _$Response {
  bool get optional => throw _privateConstructorUsedError;

  /// Serializes this Response to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
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
@JsonSerializable()
class _$ResponseImpl implements _Response {
  const _$ResponseImpl({required this.optional});

  factory _$ResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResponseImplFromJson(json);

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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, optional);

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseImplCopyWith<_$ResponseImpl> get copyWith =>
      __$$ResponseImplCopyWithImpl<_$ResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResponseImplToJson(
      this,
    );
  }
}

abstract class _Response implements Response {
  const factory _Response({required final bool optional}) = _$ResponseImpl;

  factory _Response.fromJson(Map<String, dynamic> json) =
      _$ResponseImpl.fromJson;

  @override
  bool get optional;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResponseImplCopyWith<_$ResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
