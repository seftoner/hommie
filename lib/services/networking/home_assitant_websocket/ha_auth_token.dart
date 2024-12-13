abstract class HAAuthToken {
  String get accessToken;
  bool get isExpired;
  Uri? get serverUri;
}
