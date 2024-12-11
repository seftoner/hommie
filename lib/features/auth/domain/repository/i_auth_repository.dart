import 'package:fpdart/fpdart.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:oauth2/oauth2.dart';

/// Function type for handling OAuth2 redirect responses
/// Takes a URI and returns a Future with response parameters as a Map
typedef AuthResponseHandler = Future<Map<String, String>> Function(Uri uri);

/// Repository interface for handling authentication operations with Home Assistant.
///
/// Provides methods for OAuth2-based authentication, including login, logout,
/// credential management and authentication state checking.
abstract class IAuthRepository {
  /// Initiates the OAuth2 login flow with Home Assistant server.
  ///
  /// [serverUrl] The base URL of the Home Assistant server
  /// [redirectUrl] The OAuth2 redirect URI for callback
  /// [handler] Callback function to process the OAuth2 response
  ///
  /// Returns either [AuthFailure] on error or valid [Credentials] on success
  Future<Either<AuthFailure, Credentials>> login(
      {required String serverUrl,
      required Uri redirectUrl,
      required AuthResponseHandler handler});

  /// Signs out the current user and clears stored credentials.
  ///
  /// Returns [Unit] on success or [AuthFailure] if sign out fails
  Future<Either<AuthFailure, Unit>> signOut();

  /// Retrieves stored OAuth2 credentials if they exist and refreshes them if necessary.
  ///
  /// This method performs the following:
  /// 1. Checks for existing stored credentials
  /// 2. Validates if the access token is expired
  /// 3. Automatically refreshes the token if it has expired using the refresh token
  /// 4. Stores the new credentials if refreshed
  ///
  /// Returns either:
  /// - [Credentials] with valid access token (either existing or newly refreshed)
  /// - [AuthFailure] if:
  ///   * No credentials exist
  ///   * Token refresh fails
  ///   * Refresh token is invalid or expired
  ///   * Storage operation fails
  Future<Either<AuthFailure, Credentials>> getCredentials();

  /// Checks if user is currently logged in.
  ///
  /// Returns true if valid credentials exist, false otherwise
  Future<bool> isLoggedIn();
}
