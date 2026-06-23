import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:oauth2/oauth2.dart';

class HAOAuth2Token implements HAAuthToken {
  final Credentials _credentials;

  HAOAuth2Token(this._credentials);

  @override
  String get accessToken => _credentials.accessToken;

  @override
  bool get isExpired => _credentials.isExpired;

  @override
  Uri? get serverUri => _credentials.tokenEndpoint;
}
