import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hommie/features/auth/application/auth_flow_controller.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([authFlowController])
class EnterAddressPage extends HookConsumerWidget {
  const EnterAddressPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final haServerURLController = useTextEditingController(
      text: kDebugMode ? 'http://localhost:8123' : 'http://192.168.0.',
    );
    return Scaffold(
      key: K.manualAddress.page,
      appBar: AppBar(),
      //title: const Text('Enter your hub address')
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
                child: Text(
                  'Enter your hub address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Center(
                  child: TextField(
                    key: K.manualAddress.addressField,
                    controller: haServerURLController,
                    decoration: const InputDecoration(
                      labelText: 'Hub address',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) =>
                        ref.read(authFlowControllerProvider).login(value),
                  ),
                ),
              ),
              const Spacer(),
              FilledButton(
                key: K.manualAddress.connectButton,
                onPressed: () => ref
                    .read(authFlowControllerProvider)
                    .login(haServerURLController.text),
                child: const Text('Connect'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
