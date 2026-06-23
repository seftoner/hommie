import 'package:home_assistant_websocket/home_assistant_websocket.dart';

bool isConnectionAuthenticationFailure(Object error) {
  if (error is AuthenticationError) {
    return true;
  }

  if (error is! ConnectionError) {
    return false;
  }

  final message = error.toString().toLowerCase();
  return message.contains('failed to resolve token') ||
      message.contains('authfailure.');
}
