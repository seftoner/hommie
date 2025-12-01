import 'package:oauth2/oauth2.dart';

/// Repository interface for managing OAuth2 credentials across multiple servers
///
/// This repository handles the storage and retrieval of credentials per server,
/// providing a clean abstraction for credential persistence operations.
abstract class ICredentialRepository {
  /// Reads stored credentials for a specific server
  ///
  /// Returns null if no credentials exist for the given server ID
  Future<Credentials?> read(int serverId);

  /// Saves OAuth2 credentials for a specific server
  ///
  /// Overwrites any existing credentials for the given server ID
  Future<void> save(int serverId, Credentials credentials);

  /// Clears stored credentials for a specific server
  ///
  /// No-op if no credentials exist for the given server ID
  Future<void> clear(int serverId);

  /// Checks if credentials exist for a specific server
  ///
  /// Returns true if valid credentials are stored, false otherwise
  Future<bool> hasCredentials(int serverId);
}
