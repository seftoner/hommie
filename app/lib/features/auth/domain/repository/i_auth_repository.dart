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
/// All methods are server-aware and require a server ID to operate on the correct credentials.
abstract class IAuthRepository {
  /// Initiates the OAuth2 login flow with Home Assistant server.
  ///
  /// [serverId] The ID of the server to authenticate with
  /// [serverUrl] The base URL of the Home Assistant server
  /// [redirectUrl] The OAuth2 redirect URI for callback
  /// [handler] Callback function to process the OAuth2 response
  ///
  /// Returns either [AuthFailure] on error or valid [Credentials] on success
  Future<Either<AuthFailure, Credentials>> login({
    required int serverId,
    required String serverUrl,
    required Uri redirectUrl,
    required AuthResponseHandler handler,
  });

  /// Signs out the user from a specific server and clears stored credentials.
  ///
  /// [serverId] The ID of the server to sign out from
  ///
  /// Returns [Unit] on success or [AuthFailure] if sign out fails
  Future<Either<AuthFailure, Unit>> signOut(int serverId);

  /// Retrieves stored OAuth2 credentials for a specific server if they exist and refreshes them if necessary.
  ///
  /// This method performs the following:
  /// 1. Checks for existing stored credentials for the given server
  /// 2. Validates if the access token is expired
  /// 3. Automatically refreshes the token if it has expired using the refresh token
  /// 4. Stores the new credentials if refreshed
  ///
  /// [serverId] The ID of the server to get credentials for
  ///
  /// Returns either:
  /// - [Credentials] with valid access token (either existing or newly refreshed)
  /// - [AuthFailure] if:
  ///   * No credentials exist for this server
  ///   * Token refresh fails
  ///   * Refresh token is invalid or expired
  ///   * Storage operation fails
  Future<Either<AuthFailure, Credentials>> getCredentials(int serverId);

  /// Checks if user is currently logged in to a specific server.
  ///
  /// [serverId] The ID of the server to check login status for
  ///
  /// Returns true if valid credentials exist for the server, false otherwise
  Future<bool> isLoggedIn(int serverId);
}
