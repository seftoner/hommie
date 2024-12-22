import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EnterAddressPage extends HookConsumerWidget {
  const EnterAddressPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final haServerURLController =
        useTextEditingController(text: 'http://192.168.0.');

    return Scaffold(
      key: K.enterAddresManuallyPage,
      appBar: AppBar(title: const Text('Enter your hub address')),
      body: Padding(
        padding: EdgeInsets.only(
            bottom: 16,
            left: 16,
            right: 16,
            top: MediaQuery.of(context).size.height * 0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              key: K.hubAddressTextField,
              controller: haServerURLController,
              decoration: const InputDecoration(
                labelText: 'Hub address',
              ),
            ),
            const Spacer(),
            FilledButton(
              key: K.connectButton,
              style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: () {
                ref
                    .read(authControllerProvider.notifier)
                    .login(haServerURLController.text);
              },
              child: const Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}
