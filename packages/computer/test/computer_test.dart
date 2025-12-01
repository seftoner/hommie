import 'dart:async';

import 'package:computer/computer.dart';
import 'package:computer/src/errors.dart';
import 'package:test/test.dart';

void main() {
  test('Computer turn on', () async {
    final computer = Computer.create();
    await computer.turnOn();
    expect(computer.isRunning, equals(true));
    await computer.turnOff();
  });

  test('Computer initially turned off', () async {
    final computer = Computer.create();
    expect(computer.isRunning, equals(false));
  });

  test('Computer turn off', () async {
    final computer = Computer.create();
    await computer.turnOn();
    await computer.turnOff();
    expect(computer.isRunning, equals(false));
  });

  test('Computer reload', () async {
    final computer = Computer.create();
    await computer.turnOn();
    expect(computer.isRunning, equals(true));
    await computer.turnOff();
    expect(computer.isRunning, equals(false));
    await computer.turnOn();
    expect(computer.isRunning, equals(true));
    expect(await computer.compute<int, int>(fib, param: 20), equals(fib(20)));
    await computer.turnOff();
  });

  test('Execute function with param', () async {
    final computer = Computer.create();
    await computer.turnOn();

    expect(await computer.compute<int, int>(fib, param: 20), equals(fib(20)));

    await computer.turnOff();
  });

  test('Stress test', () async {
    final computer = Computer.create();
    await computer.turnOn();

    const numOfTasks = 500;

    final result = await Future.wait(
      List<Future<int>>.generate(
        numOfTasks,
        (_) async => await computer.compute(fib, param: 30),
      ),
    );

    final forComparison = List<int>.generate(
      numOfTasks,
      (_) => 832040,
    );

    expect(result, forComparison);

    await computer.turnOff();
  });

  test('Execute function without params', () async {
    final computer = Computer.create();
    await computer.turnOn();

    expect(await computer.compute<void, int>(fib20), equals(fib20()));

    await computer.turnOff();
  });

  test('Execute static method', () async {
    final computer = Computer.create();
    await computer.turnOn();

    expect(
      await computer.compute<int, int>(Fibonacci.fib, param: 20),
      equals(Fibonacci.fib(20)),
    );

    await computer.turnOff();
  });

  test('Execute async method', () async {
    final computer = Computer.create();
    await computer.turnOn();

    expect(
      await computer.compute<int, int>(fibAsync, param: 20),
      equals(await fibAsync(20)),
    );

    await computer.turnOff();
  });

  test("Compute stream without a parameter", () async {
    final computer = Computer.create();
    await computer.turnOn();

    final stream = await computer.computeStream<void, String>((_) async* {
      for (var i = 0; i < 5; i++) {
        await Future.delayed(Duration(milliseconds: 500));
        yield 'msg $i';
      }
    });

    final results = await stream.toList();

    expect(results, hasLength(5));
    expect(results, equals(['msg 0', 'msg 1', 'msg 2', 'msg 3', 'msg 4']));

    await computer.turnOff();
  });

  test("Compute stream with a parameter", () async {
    final computer = Computer.create();
    await computer.turnOn();

    // Define a function that takes a parameter and produces a stream
    Stream<String> streamWithParam(int param) async* {
      for (var i = 0; i < param; i++) {
        await Future.delayed(Duration(milliseconds: 100));
        yield 'msg $i';
      }
    }

    final stream =
        await computer.computeStream<int, String>(streamWithParam, param: 3);

    final results = await stream.toList();

    expect(results, hasLength(3));
    expect(results, equals(['msg 0', 'msg 1', 'msg 2']));

    await computer.turnOff();
  });

  test('computeStream handles errors in stream task gracefully', () async {
    final computer = Computer.create();
    await computer.turnOn();

    final stream = await computer.computeStream<int, int>(errorStream);

    expect(
      () async {
        await for (final i in stream) {
          print(i);
        }
      },
      throwsA(isA<RemoteExecutionError>()),
    );
  });

  test('computeStream throws CancelExecutionError on turnOff during processing',
      () async {
    final computer = Computer.create();
    await computer.turnOn();

    try {
      await computer.computeStream<int, int>(errorStream, param: 3);
    } catch (e) {
      expect(e, isA<CancelExecutionError>());
      expect(e, isA<ComputerError>());
    }

    await computer.turnOff();
  });

  test('computeStream handles an empty stream task gracefully', () async {
    Stream<String> emptyStream(void _) async* {}

    final computer = Computer.create();
    await computer.turnOn();

    final stream = await computer.computeStream<void, String>(emptyStream);

    final results = <String>[];
    await for (final value in stream) {
      results.add(value);
    }

    expect(results, isEmpty);
  });

  test('Add computes before workers have been created', () async {
    final computer = Computer.create();
    expect(Future.value(computer.compute<int, int>(fib, param: 20)),
        completion(equals(fib20())));
    unawaited(computer.turnOn());

    addTearDown(() async => await computer.turnOff());
  });

  test('Error method', () async {
    final computer = Computer.create();
    await computer.turnOn();

    try {
      await computer.compute<int, int>(errorFib, param: 20);
    } catch (e) {
      expect(e, isA<RemoteExecutionError>());
      expect(e, isA<ComputerError>());
    }

    await computer.turnOff();
  });

  test('Cancel running worker', () async {
    final computer = Computer.create();
    await computer.turnOn();

    Future<void>.delayed(Duration.zero, () async {
      try {
        await computer.compute<int, int>(errorFib, param: 20);
      } catch (e) {
        expect(e, isA<CancelExecutionError>());
        expect(e, isA<ComputerError>());
      }
    });

    await computer.turnOff();
  });

  test('Computer instance is a singleton', () async {
    final computer1 = Computer.shared();
    final computer2 = Computer.shared();

    expect(identical(computer1, computer2), true);
  });

  test('Computer create create new instances', () async {
    final computer1 = Computer.create();
    final computer2 = Computer.create();

    expect(identical(computer1, computer2), false);
  });
}

int fib(int n) {
  if (n < 2) {
    return n;
  }
  return fib(n - 2) + fib(n - 1);
}

int errorFib(int n) {
  throw Exception('Something went wrong');
}

Stream<int> errorStream(void _) async* {
  throw Exception('Something went wrong');
}

Future<int> fibAsync(int n) async {
  await Future<void>.delayed(const Duration(milliseconds: 100));

  return fib(n);
}

int fib20() {
  return fib(20);
}

abstract class Fibonacci {
  static int fib(int n) {
    if (n < 2) {
      return n;
    }
    return fib(n - 2) + fib(n - 1);
  }
}
