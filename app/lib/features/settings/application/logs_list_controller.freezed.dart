// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logs_list_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LogsListState {

 bool get isLoadingMore; List<Log> get logs; bool get hasReachedEnd;
/// Create a copy of LogsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogsListStateCopyWith<LogsListState> get copyWith => _$LogsListStateCopyWithImpl<LogsListState>(this as LogsListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogsListState&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.logs, logs)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingMore,const DeepCollectionEquality().hash(logs),hasReachedEnd);

@override
String toString() {
  return 'LogsListState(isLoadingMore: $isLoadingMore, logs: $logs, hasReachedEnd: $hasReachedEnd)';
}


}

/// @nodoc
abstract mixin class $LogsListStateCopyWith<$Res>  {
  factory $LogsListStateCopyWith(LogsListState value, $Res Function(LogsListState) _then) = _$LogsListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoadingMore, List<Log> logs, bool hasReachedEnd
});




}
/// @nodoc
class _$LogsListStateCopyWithImpl<$Res>
    implements $LogsListStateCopyWith<$Res> {
  _$LogsListStateCopyWithImpl(this._self, this._then);

  final LogsListState _self;
  final $Res Function(LogsListState) _then;

/// Create a copy of LogsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoadingMore = null,Object? logs = null,Object? hasReachedEnd = null,}) {
  return _then(_self.copyWith(
isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,logs: null == logs ? _self.logs : logs // ignore: cast_nullable_to_non_nullable
as List<Log>,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LogsListState].
extension LogsListStatePatterns on LogsListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LogsListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LogsListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LogsListState value)  $default,){
final _that = this;
switch (_that) {
case _LogsListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LogsListState value)?  $default,){
final _that = this;
switch (_that) {
case _LogsListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoadingMore,  List<Log> logs,  bool hasReachedEnd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LogsListState() when $default != null:
return $default(_that.isLoadingMore,_that.logs,_that.hasReachedEnd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoadingMore,  List<Log> logs,  bool hasReachedEnd)  $default,) {final _that = this;
switch (_that) {
case _LogsListState():
return $default(_that.isLoadingMore,_that.logs,_that.hasReachedEnd);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoadingMore,  List<Log> logs,  bool hasReachedEnd)?  $default,) {final _that = this;
switch (_that) {
case _LogsListState() when $default != null:
return $default(_that.isLoadingMore,_that.logs,_that.hasReachedEnd);case _:
  return null;

}
}

}

/// @nodoc


class _LogsListState implements LogsListState {
   _LogsListState({required this.isLoadingMore, required final  List<Log> logs, this.hasReachedEnd = false}): _logs = logs;
  

@override final  bool isLoadingMore;
 final  List<Log> _logs;
@override List<Log> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

@override@JsonKey() final  bool hasReachedEnd;

/// Create a copy of LogsListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogsListStateCopyWith<_LogsListState> get copyWith => __$LogsListStateCopyWithImpl<_LogsListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogsListState&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other._logs, _logs)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingMore,const DeepCollectionEquality().hash(_logs),hasReachedEnd);

@override
String toString() {
  return 'LogsListState(isLoadingMore: $isLoadingMore, logs: $logs, hasReachedEnd: $hasReachedEnd)';
}


}

/// @nodoc
abstract mixin class _$LogsListStateCopyWith<$Res> implements $LogsListStateCopyWith<$Res> {
  factory _$LogsListStateCopyWith(_LogsListState value, $Res Function(_LogsListState) _then) = __$LogsListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoadingMore, List<Log> logs, bool hasReachedEnd
});




}
/// @nodoc
class __$LogsListStateCopyWithImpl<$Res>
    implements _$LogsListStateCopyWith<$Res> {
  __$LogsListStateCopyWithImpl(this._self, this._then);

  final _LogsListState _self;
  final $Res Function(_LogsListState) _then;

/// Create a copy of LogsListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoadingMore = null,Object? logs = null,Object? hasReachedEnd = null,}) {
  return _then(_LogsListState(
isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<Log>,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
