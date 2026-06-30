import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/infrastructure/providers/server_auth_token_provider.dart';
import 'package:hommie/features/auth/infrastructure/providers/server_credentials_provider.dart';
import 'package:oauth2/oauth2.dart';

void main() {
  test('rejects expired credentials before websocket authentication', () {
    final credentials = Credentials(
      'expired-access-token',
      refreshToken: 'refresh-token',
      tokenEndpoint: Uri.parse('http://localhost:8123/auth/token'),
      expiration: DateTime.now().subtract(const Duration(minutes: 1)),
    );

    expect(
      () => authTokenFromCredentials(credentials),
      throwsA(
        isA<AuthFailureException>().having(
          (error) => error.failure,
          'failure',
          const AuthFailure.connection(),
        ),
      ),
    );
  });
}
