import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_client_provider.g.dart';

class TimeoutHttpClient extends http.BaseClient {
  final http.Client _inner;
  final Duration _timeout;

  TimeoutHttpClient(this._inner, this._timeout);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request).timeout(_timeout);
  }
}

@Riverpod(keepAlive: true)
http.BaseClient httpClient(Ref ref) {
  final httpClient = TimeoutHttpClient(
    http.Client(),
    const Duration(seconds: 5),
  );

  return httpClient;
}
