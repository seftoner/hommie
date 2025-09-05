import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toast_service.g.dart';

abstract interface class ToastService {
  void show(String message);
}

/// A toast service implementation using Flutter's ScaffoldMessenger
/// to match the project's existing approach for showing user messages
class ScaffoldToastService implements ToastService {
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  const ScaffoldToastService({this.scaffoldMessengerKey});

  @override
  void show(String message) {
    final messenger =
        scaffoldMessengerKey?.currentState ??
        ScaffoldMessenger.maybeOf(WidgetsBinding.instance.rootElement!);

    if (messenger != null) {
      messenger.showSnackBar(SnackBar(content: Text(message)));
    } else {
      // Fallback for testing or when no scaffold is available
      debugPrint('[TOAST] $message');
    }
  }
}

/// Debug toast implementation for testing and development
class DebugToastService implements ToastService {
  const DebugToastService();

  @override
  void show(String message) => debugPrint('[TOAST] $message');
}

@riverpod
ToastService toastService(Ref ref) {
  // Use debug toast in tests, scaffold toast in real app
  return const DebugToastService();
}
