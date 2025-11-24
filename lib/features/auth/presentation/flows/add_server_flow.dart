import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hommie/features/auth/application/auth_flow_controller.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/application/auth_state_provider.dart';
import 'package:hommie/features/auth/presentation/screens/enter_address_page.dart';
import 'package:hommie/features/auth/presentation/screens/server_discovery_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_server_flow.freezed.dart';
part 'add_server_flow.g.dart';

/// Steps that compose the add server experience.
@freezed
sealed class _AddServerFlowStep with _$AddServerFlowStep {
  const factory _AddServerFlowStep.discovery() = Discovery;
  const factory _AddServerFlowStep.manualEntry() = ManualEntry;
}

@riverpod
class _AddServerFlowController extends _$AddServerFlowController {
  @override
  _AddServerFlowStep build() {
    return const _AddServerFlowStep.discovery();
  }

  void goToManualEntry() {
    state = const _AddServerFlowStep.manualEntry();
  }

  void goToDiscovery() {
    state = const _AddServerFlowStep.discovery();
  }
}

// ignore: provider_dependencies
/// Flow that orchestrates discovery and manual entry when adding a server.
class AddServerFlow extends HookConsumerWidget {
  const AddServerFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*     final controller = useMemoized(
      () => FlowController(AddServerFlowStep.discovery),
    );
    useEffect(() {
      return controller.dispose;
    }, [controller]); */

    /*     ref.listen<AsyncValue<AuthState>>(authStateProvider, (previous, next) {
      next.whenData((state) {
        switch (state) {
          case Authenticated():
          case Refreshing():
            controller.complete();
          default:
            break;
        }
      });
    }); */

    final state = ref.watch(_addServerFlowControllerProvider);

    return FlowBuilder<_AddServerFlowStep>(
      state: state,
      onGeneratePages: (step, pages) {
        return [
          MaterialPage(
            child: ServerDiscoveryPage(
              onManualEntry: ref
                  .read(_addServerFlowControllerProvider.notifier)
                  .goToManualEntry,
              onExit: () => Navigator.of(context).pop(),
            ),
          ),

          if (step is ManualEntry)
            MaterialPage(
              child: EnterAddressPage(
                onConnect: (serverUrl) async {
                  await ref
                      .read(authFlowControllerProvider.notifier)
                      .login(serverUrl);
                },
              ),
            ),
        ];
      },
    );
  }
}
