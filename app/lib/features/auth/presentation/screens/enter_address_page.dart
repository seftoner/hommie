import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hommie/features/auth/domain/entities/server_url.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EnterAddressPage extends HookConsumerWidget {
  /// Optional callback for when connect button is pressed - used when in flow context
  final void Function(String serverUrl) onConnect;

  const EnterAddressPage({super.key, required this.onConnect});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final haServerURLController = useTextEditingController(
      text: kDebugMode ? 'http://localhost:8123' : 'http://192.168.0.',
    );

    void submitForm() {
      if (formKey.currentState!.validate()) {
        onConnect(haServerURLController.text);
      }
    }

    return Scaffold(
      key: K.manualAddress.page,
      appBar: AppBar(),
      //title: const Text('Enter your hub address')
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
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
                    child: TextFormField(
                      key: K.manualAddress.addressField,
                      controller: haServerURLController,
                      decoration: const InputDecoration(
                        labelText: 'Hub address',
                        border: OutlineInputBorder(),
                      ),
                      validator: ServerUrl.validate,
                      onFieldSubmitted: (_) => submitForm(),
                    ),
                  ),
                ),
                const Spacer(),
                FilledButton(
                  key: K.manualAddress.connectButton,
                  onPressed: submitForm,
                  child: const Text('Connect'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
