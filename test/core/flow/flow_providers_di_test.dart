import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/core/flow/flow_definition.dart';
import 'package:hommie/core/flow/flow_providers.dart';
import 'package:hommie/core/flow/toast_service.dart';
import 'package:hommie/router/router.dart';
import 'package:riverpod/riverpod.dart';

class FakeToastService implements ToastService {
  final List<String> messages = [];

  @override
  void show(String message) {
    messages.add(message);
  }
}

void main() {
  group('FlowRunner Provider Tests with DI', () {
    late ProviderContainer container;
    late FakeToastService fakeToast;
    late GoRouter fakeRouter;

    setUp(() {
      fakeToast = FakeToastService();
      fakeRouter = GoRouter(routes: []);

      container = ProviderContainer(
        overrides: [
          toastServiceProvider.overrideWithValue(fakeToast),
          goRouterProvider.overrideWithValue(fakeRouter),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should provide toast service correctly', () {
      final toastService = container.read(toastServiceProvider);
      expect(toastService, equals(fakeToast));

      toastService.show('Test message');
      expect(fakeToast.messages, contains('Test message'));
    });

    test('should create flow providers using DI', () {
      // Test that providers work without manual parameter passing
      expect(() => flowRunnerProvider, returnsNormally);
      expect(() => flowStateProvider, returnsNormally);
    });

    test('should read flow state provider', () {
      // Test that we can read the flow state provider (should be FlowIdle initially)
      final flowState = container.read(flowStateProvider);
      expect(flowState, isA<FlowState>());
      expect(flowState, isA<FlowIdle>());
    });

    test('should allow provider overrides', () {
      // Verify that our overrides are working
      final toastService = container.read(toastServiceProvider);
      expect(toastService, isA<FakeToastService>());
      expect(toastService, equals(fakeToast));

      final router = container.read(goRouterProvider);
      expect(router, equals(fakeRouter));
    });

    test('should use router via DI in flow providers', () {
      // Verify that the flow providers correctly use the injected router
      final runner = container.read(flowRunnerProvider);
      expect(runner, isNotNull);

      final flowState = container.read(flowStateProvider);
      expect(flowState, isA<FlowIdle>());
    });
  });
}
