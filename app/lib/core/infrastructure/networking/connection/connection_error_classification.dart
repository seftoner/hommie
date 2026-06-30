import 'package:home_assistant_client/home_assistant_client.dart';

bool isConnectionAuthenticationFailure(Object error) {
  if (error is AuthenticationError) {
    return true;
  }

  if (error is! ConnectionError) {
    return false;
  }

  final message = error.toString().toLowerCase();
  return message.contains('authfailure.invalidtoken');
}
