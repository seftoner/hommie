import 'package:flutter/material.dart';
import 'package:hommie/ui/styles/spacings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final loginProvider =
//     ChangeNotifierProvider<LoginProvider>((ref) => LoginProvider());

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef watch) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            bottom: 16,
            left: 16,
            right: 16,
            top: MediaQuery.of(context).size.height * 0.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Enter your hub address',
                style: Theme.of(context).textTheme.headlineMedium),
            $h32,
            const TextField(
              // onChanged: (value) => watch(loginProvider).setPassword(value),
              decoration: InputDecoration(
                labelText: 'Hub address',
              ),
            ),
            Spacer(),
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: () {},
              child: const Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginProvider extends ChangeNotifier {
  String _username = '';
  String _password = '';
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  void setUsername(String username) {
    _username = username;
  }

  void setPassword(String password) {
    _password = password;
  }

  void login() {
    if (_username.isEmpty || _password.isEmpty) {
      _errorMessage = 'Please enter username and password';
    } else {
      // Perform login logic here
      // If successful, navigate to the next screen
      // If failed, set _errorMessage accordingly
    }
    notifyListeners();
  }
}
