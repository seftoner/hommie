import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/services/networking/provider.dart';
import 'package:hommie/utils/state_logger.dart';

Future<ProviderContainer> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(
    overrides: [],
    //Is too noisy, temporaty disable
    observers: [const StateLogger()],
  );

  /// Auth
  container.read(authControllerProvider);

  return container;
}
