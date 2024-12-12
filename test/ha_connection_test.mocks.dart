// Mocks generated by Mockito 5.4.4 from annotations
// in hommie/test/ha_connection_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:hommie/services/networking/home_assitant_websocket/ha_messages.dart'
    as _i5;
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeHASocket_0 extends _i1.SmartFake implements _i2.HASocket {
  _FakeHASocket_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamSink_1<S> extends _i1.SmartFake implements _i3.StreamSink<S> {
  _FakeStreamSink_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFuture_2<T1> extends _i1.SmartFake implements _i3.Future<T1> {
  _FakeFuture_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HASocket].
///
/// See the documentation for Mockito's code generation for more information.
class MockHASocket extends _i1.Mock implements _i2.HASocket {
  MockHASocket() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get haVersion => (super.noSuchMethod(
        Invocation.getter(#haVersion),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#haVersion),
        ),
      ) as String);

  @override
  set haVersion(String? _haVersion) => super.noSuchMethod(
        Invocation.setter(
          #haVersion,
          _haVersion,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Stream<_i2.HASocketState> get stateStream => (super.noSuchMethod(
        Invocation.getter(#stateStream),
        returnValue: _i3.Stream<_i2.HASocketState>.empty(),
      ) as _i3.Stream<_i2.HASocketState>);

  @override
  _i2.HASocketState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i2.HASocketState.connecting,
      ) as _i2.HASocketState);

  @override
  _i3.Stream<dynamic> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<dynamic>.empty(),
      ) as _i3.Stream<dynamic>);

  @override
  void sendMessage(_i5.HABaseMessgae? message) => super.noSuchMethod(
        Invocation.method(
          #sendMessage,
          [message],
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool isClosed() => (super.noSuchMethod(
        Invocation.method(
          #isClosed,
          [],
        ),
        returnValue: false,
      ) as bool);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [HAConnectionOption].
///
/// See the documentation for Mockito's code generation for more information.
class MockHAConnectionOption extends _i1.Mock
    implements _i2.HAConnectionOption {
  MockHAConnectionOption() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> refreshTokenIfNeeded() => (super.noSuchMethod(
        Invocation.method(
          #refreshTokenIfNeeded,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<_i2.HASocket> createSocket() => (super.noSuchMethod(
        Invocation.method(
          #createSocket,
          [],
        ),
        returnValue: _i3.Future<_i2.HASocket>.value(_FakeHASocket_0(
          this,
          Invocation.method(
            #createSocket,
            [],
          ),
        )),
      ) as _i3.Future<_i2.HASocket>);
}

/// A class which mocks [StreamController].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamController<T> extends _i1.Mock
    implements _i3.StreamController<T> {
  MockStreamController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set onListen(void Function()? _onListen) => super.noSuchMethod(
        Invocation.setter(
          #onListen,
          _onListen,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onPause(void Function()? _onPause) => super.noSuchMethod(
        Invocation.setter(
          #onPause,
          _onPause,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onResume(void Function()? _onResume) => super.noSuchMethod(
        Invocation.setter(
          #onResume,
          _onResume,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onCancel(_i3.FutureOr<void> Function()? _onCancel) => super.noSuchMethod(
        Invocation.setter(
          #onCancel,
          _onCancel,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Stream<T> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<T>.empty(),
      ) as _i3.Stream<T>);

  @override
  _i3.StreamSink<T> get sink => (super.noSuchMethod(
        Invocation.getter(#sink),
        returnValue: _FakeStreamSink_1<T>(
          this,
          Invocation.getter(#sink),
        ),
      ) as _i3.StreamSink<T>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  bool get isPaused => (super.noSuchMethod(
        Invocation.getter(#isPaused),
        returnValue: false,
      ) as bool);

  @override
  bool get hasListener => (super.noSuchMethod(
        Invocation.getter(#hasListener),
        returnValue: false,
      ) as bool);

  @override
  _i3.Future<dynamic> get done => (super.noSuchMethod(
        Invocation.getter(#done),
        returnValue: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);

  @override
  void add(T? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<dynamic> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);

  @override
  _i3.Future<dynamic> addStream(
    _i3.Stream<T>? source, {
    bool? cancelOnError,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addStream,
          [source],
          {#cancelOnError: cancelOnError},
        ),
        returnValue: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
}

/// A class which mocks [StreamSubscription].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamSubscription<T> extends _i1.Mock
    implements _i3.StreamSubscription<T> {
  MockStreamSubscription() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isPaused => (super.noSuchMethod(
        Invocation.getter(#isPaused),
        returnValue: false,
      ) as bool);

  @override
  _i3.Future<void> cancel() => (super.noSuchMethod(
        Invocation.method(
          #cancel,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  void onData(void Function(T)? handleData) => super.noSuchMethod(
        Invocation.method(
          #onData,
          [handleData],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(Function? handleError) => super.noSuchMethod(
        Invocation.method(
          #onError,
          [handleError],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onDone(void Function()? handleDone) => super.noSuchMethod(
        Invocation.method(
          #onDone,
          [handleDone],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void pause([_i3.Future<void>? resumeSignal]) => super.noSuchMethod(
        Invocation.method(
          #pause,
          [resumeSignal],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void resume() => super.noSuchMethod(
        Invocation.method(
          #resume,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<E> asFuture<E>([E? futureValue]) => (super.noSuchMethod(
        Invocation.method(
          #asFuture,
          [futureValue],
        ),
        returnValue: _i4.ifNotNull(
              _i4.dummyValueOrNull<E>(
                this,
                Invocation.method(
                  #asFuture,
                  [futureValue],
                ),
              ),
              (E v) => _i3.Future<E>.value(v),
            ) ??
            _FakeFuture_2<E>(
              this,
              Invocation.method(
                #asFuture,
                [futureValue],
              ),
            ),
      ) as _i3.Future<E>);
}
