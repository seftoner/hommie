import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/utils/state_logger.dart';

Future<ProviderContainer> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(
    overrides: [],
    observers: [const StateLogger()],
  );

  /// Auth
  container.read(authControllerProvider);
  return container;
}
