import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/presentation/screens/enter_address_page.dart';
import 'package:hommie/features/auth/presentation/screens/server_discovery_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

enum AddServerFlowState { discovery, manualEntry }

@Dependencies([authController])
/// Flow that orchestrates discovery and manual entry when adding a server.
class AddServerFlow extends ConsumerStatefulWidget {
  final bool userCanCancel;
  const AddServerFlow({super.key, this.userCanCancel = true});

  @override
  ConsumerState<AddServerFlow> createState() => _AddServerFlowState();
}

class _AddServerFlowState extends ConsumerState<AddServerFlow> {
  late final FlowController<AddServerFlowState> controller;

  @override
  void initState() {
    super.initState();
    controller = FlowController(AddServerFlowState.discovery);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AddServerFlowState>(
      controller: controller,
      onGeneratePages: (current, pages) {
        return [
          MaterialPage(
            child: ServerDiscoveryPage(
              onConnect: (serverAddress) => ref
                  .read(authControllerProvider)
                  .login(serverAddress.toString()),
              onManualEntry: () =>
                  controller.update((state) => AddServerFlowState.manualEntry),
              onExit: widget.userCanCancel ? controller.complete : null,
            ),
          ),
          if (current == AddServerFlowState.manualEntry)
            MaterialPage(
              child: EnterAddressPage(
                onConnect: (serverUrl) async {
                  await ref.read(authControllerProvider).login(serverUrl);
                },
              ),
            ),
        ];
      },
    );
  }
}
