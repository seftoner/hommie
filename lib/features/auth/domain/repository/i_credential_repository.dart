import 'package:oauth2/oauth2.dart';

abstract class ICredentialRepository {
  Future<void> save(Credentials credentials);
  Future<Credentials?> read();
  Future<void> clear();
}
