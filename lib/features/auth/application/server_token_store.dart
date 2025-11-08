import 'package:hommie/features/auth/domain/repository/i_credential_repository.dart';
import 'package:oauth2/oauth2.dart';

/// Thin wrapper around [ICredentialRepository] keyed by a specific server id.
class ServerTokenStore {
  ServerTokenStore(this._repository, this.serverId);

  final ICredentialRepository _repository;
  final int serverId;

  Future<Credentials?> read() => _repository.read(serverId);

  Future<void> save(Credentials credentials) =>
      _repository.save(serverId, credentials);

  Future<void> clear() => _repository.clear(serverId);
}
