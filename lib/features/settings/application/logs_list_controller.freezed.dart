// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logs_list_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LogsListState {
  bool get isLoadingMore => throw _privateConstructorUsedError;
  List<Log> get logs => throw _privateConstructorUsedError;

  /// Create a copy of LogsListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LogsListStateCopyWith<LogsListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogsListStateCopyWith<$Res> {
  factory $LogsListStateCopyWith(
          LogsListState value, $Res Function(LogsListState) then) =
      _$LogsListStateCopyWithImpl<$Res, LogsListState>;
  @useResult
  $Res call({bool isLoadingMore, List<Log> logs});
}

/// @nodoc
class _$LogsListStateCopyWithImpl<$Res, $Val extends LogsListState>
    implements $LogsListStateCopyWith<$Res> {
  _$LogsListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LogsListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoadingMore = null,
    Object? logs = null,
  }) {
    return _then(_value.copyWith(
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      logs: null == logs
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<Log>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LogsListStateImplCopyWith<$Res>
    implements $LogsListStateCopyWith<$Res> {
  factory _$$LogsListStateImplCopyWith(
          _$LogsListStateImpl value, $Res Function(_$LogsListStateImpl) then) =
      __$$LogsListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoadingMore, List<Log> logs});
}

/// @nodoc
class __$$LogsListStateImplCopyWithImpl<$Res>
    extends _$LogsListStateCopyWithImpl<$Res, _$LogsListStateImpl>
    implements _$$LogsListStateImplCopyWith<$Res> {
  __$$LogsListStateImplCopyWithImpl(
      _$LogsListStateImpl _value, $Res Function(_$LogsListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LogsListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoadingMore = null,
    Object? logs = null,
  }) {
    return _then(_$LogsListStateImpl(
      null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      null == logs
          ? _value._logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<Log>,
    ));
  }
}

/// @nodoc

class _$LogsListStateImpl implements _LogsListState {
  _$LogsListStateImpl(this.isLoadingMore, final List<Log> logs) : _logs = logs;

  @override
  final bool isLoadingMore;
  final List<Log> _logs;
  @override
  List<Log> get logs {
    if (_logs is EqualUnmodifiableListView) return _logs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_logs);
  }

  @override
  String toString() {
    return 'LogsListState(isLoadingMore: $isLoadingMore, logs: $logs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogsListStateImpl &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            const DeepCollectionEquality().equals(other._logs, _logs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoadingMore, const DeepCollectionEquality().hash(_logs));

  /// Create a copy of LogsListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LogsListStateImplCopyWith<_$LogsListStateImpl> get copyWith =>
      __$$LogsListStateImplCopyWithImpl<_$LogsListStateImpl>(this, _$identity);
}

abstract class _LogsListState implements LogsListState {
  factory _LogsListState(final bool isLoadingMore, final List<Log> logs) =
      _$LogsListStateImpl;

  @override
  bool get isLoadingMore;
  @override
  List<Log> get logs;

  /// Create a copy of LogsListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LogsListStateImplCopyWith<_$LogsListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
