import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:home_assistant_client/src/api/ha_api_exceptions.dart';
import 'package:http/http.dart' as http;

typedef HATokenProvider = FutureOr<String> Function();

class HARestTransport {
  HARestTransport({
    required Uri serverUri,
    required HATokenProvider tokenProvider,
    http.Client? client,
  }) : _isAvailable = true,
       _serverUri = serverUri,
       _tokenProvider = tokenProvider,
       _client = client ?? http.Client();

  HARestTransport.unavailable()
    : _isAvailable = false,
      _serverUri = Uri(),
      _tokenProvider = (() => throw const UnsupportedTransportException(
        'REST transport is unavailable.',
      )),
      _client = http.Client();

  final bool _isAvailable;
  final Uri _serverUri;
  final HATokenProvider _tokenProvider;
  final http.Client _client;

  Future<dynamic> getJson(String path) {
    return requestJson(method: 'GET', path: path);
  }

  Future<dynamic> requestJson({
    required String method,
    required String path,
    Object? body,
    Map<String, String>? headers,
  }) async {
    if (!_isAvailable) {
      throw const UnsupportedTransportException(
        'REST transport is unavailable.',
      );
    }

    final token = await _tokenProvider();
    final request = http.Request(method, _resolve(path));
    request.headers.addAll({
      'authorization': 'Bearer $token',
      'accept': 'application/json',
      ...?headers,
    });

    if (body != null) {
      request.headers.putIfAbsent('content-type', () => 'application/json');
      request.body = jsonEncode(body);
    }

    try {
      final streamed = await _client.send(request);
      final response = await http.Response.fromStream(streamed);
      return _handleResponse(response);
    } on HAApiException {
      rethrow;
    } on TimeoutException catch (error) {
      throw HAConnectionException(error.message);
    } on SocketException catch (error) {
      throw HAConnectionException(error.message);
    } on http.ClientException catch (error) {
      throw HAConnectionException(error.message);
    }
  }

  Uri _resolve(String path) {
    final normalizedBase = _serverUri.path.endsWith('/')
        ? _serverUri
        : _serverUri.replace(path: '${_serverUri.path}/');
    final normalizedPath = path.startsWith('/') ? path.substring(1) : path;
    return normalizedBase.resolve(normalizedPath);
  }

  Object? _handleResponse(http.Response response) {
    final body = _decodeBody(response.body);

    if (response.statusCode == 401 || response.statusCode == 403) {
      throw HAAuthenticationException(response.reasonPhrase);
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HAHttpException(
        statusCode: response.statusCode,
        body: body,
        message: response.reasonPhrase,
      );
    }

    return body;
  }

  Object? _decodeBody(String body) {
    if (body.isEmpty) {
      return null;
    }

    try {
      return jsonDecode(body);
    } on FormatException {
      return body;
    }
  }
}
