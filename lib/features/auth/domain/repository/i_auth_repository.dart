import 'package:fpdart/fpdart.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:oauth2/oauth2.dart';

typedef Future<Map<String, String>> AuthResponseHandler(Uri uri);

abstract class IAuthRepository {
  Future<Either<AuthFailure, Credentials>> login(
      {required String serverUrl,
      required Uri redirectUrl,
      required AuthResponseHandler handler});

  Future<Either<AuthFailure, Unit>> signOut();

  Future<Either<AuthFailure, Credentials>> getCredentials();
}
