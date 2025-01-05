class TestContext {
  factory TestContext.instance() => _singleton;
  TestContext._();
  static final TestContext _singleton = TestContext._();

  String? _authToken;

  void setAuthToken(String token) {
    _authToken = token;
  }

  String? get authToken => _authToken;

  void clear() {
    _authToken = null;
  }
}
