import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/styles/spacings.dart';

class AppStartup extends ConsumerStatefulWidget {
  const AppStartup({super.key});

  @override
  ConsumerState<AppStartup> createState() => _AppStartupState();
}

class _AppStartupState extends ConsumerState<AppStartup> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final authController = ref.read(authControllerProvider.notifier);
    await authController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      final authState = next.value;
      if (authState == null) return;

      if (authState is Unauthenticated || authState is Failure) {
        const DicoveryRoute().go(context);
      } else if (authState is Authenticated) {
        const HomeRouteData().go(context);
      }
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            $h24,
            Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
