sealed class HAApiException implements Exception {
  const HAApiException([this.message]);

  final String? message;

  @override
  String toString() {
    final details = message;
    return details == null ? runtimeType.toString() : '$runtimeType: $details';
  }
}

final class HAAuthenticationException extends HAApiException {
  const HAAuthenticationException([super.message]);
}

final class HAConnectionException extends HAApiException {
  const HAConnectionException([super.message]);
}

final class HAHttpException extends HAApiException {
  const HAHttpException({required this.statusCode, this.body, String? message})
    : super(message);

  final int statusCode;
  final Object? body;
}

final class HAWebSocketException extends HAApiException {
  const HAWebSocketException([super.message]);
}

final class UnsupportedTransportException extends HAApiException {
  const UnsupportedTransportException([super.message]);
}
