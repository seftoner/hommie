// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ha_version.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HaVersion {
  int get major => throw _privateConstructorUsedError;
  int get minor => throw _privateConstructorUsedError;
  int? get patch => throw _privateConstructorUsedError;

  /// Create a copy of HaVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HaVersionCopyWith<HaVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HaVersionCopyWith<$Res> {
  factory $HaVersionCopyWith(HaVersion value, $Res Function(HaVersion) then) =
      _$HaVersionCopyWithImpl<$Res, HaVersion>;
  @useResult
  $Res call({int major, int minor, int? patch});
}

/// @nodoc
class _$HaVersionCopyWithImpl<$Res, $Val extends HaVersion>
    implements $HaVersionCopyWith<$Res> {
  _$HaVersionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HaVersion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? major = null,
    Object? minor = null,
    Object? patch = freezed,
  }) {
    return _then(_value.copyWith(
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as int,
      minor: null == minor
          ? _value.minor
          : minor // ignore: cast_nullable_to_non_nullable
              as int,
      patch: freezed == patch
          ? _value.patch
          : patch // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HaVersionImplCopyWith<$Res>
    implements $HaVersionCopyWith<$Res> {
  factory _$$HaVersionImplCopyWith(
          _$HaVersionImpl value, $Res Function(_$HaVersionImpl) then) =
      __$$HaVersionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int major, int minor, int? patch});
}

/// @nodoc
class __$$HaVersionImplCopyWithImpl<$Res>
    extends _$HaVersionCopyWithImpl<$Res, _$HaVersionImpl>
    implements _$$HaVersionImplCopyWith<$Res> {
  __$$HaVersionImplCopyWithImpl(
      _$HaVersionImpl _value, $Res Function(_$HaVersionImpl) _then)
      : super(_value, _then);

  /// Create a copy of HaVersion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? major = null,
    Object? minor = null,
    Object? patch = freezed,
  }) {
    return _then(_$HaVersionImpl(
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as int,
      minor: null == minor
          ? _value.minor
          : minor // ignore: cast_nullable_to_non_nullable
              as int,
      patch: freezed == patch
          ? _value.patch
          : patch // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$HaVersionImpl implements _HaVersion {
  _$HaVersionImpl({required this.major, required this.minor, this.patch});

  @override
  final int major;
  @override
  final int minor;
  @override
  final int? patch;

  @override
  String toString() {
    return 'HaVersion(major: $major, minor: $minor, patch: $patch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HaVersionImpl &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.minor, minor) || other.minor == minor) &&
            (identical(other.patch, patch) || other.patch == patch));
  }

  @override
  int get hashCode => Object.hash(runtimeType, major, minor, patch);

  /// Create a copy of HaVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HaVersionImplCopyWith<_$HaVersionImpl> get copyWith =>
      __$$HaVersionImplCopyWithImpl<_$HaVersionImpl>(this, _$identity);
}

abstract class _HaVersion implements HaVersion {
  factory _HaVersion(
      {required final int major,
      required final int minor,
      final int? patch}) = _$HaVersionImpl;

  @override
  int get major;
  @override
  int get minor;
  @override
  int? get patch;

  /// Create a copy of HaVersion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HaVersionImplCopyWith<_$HaVersionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
