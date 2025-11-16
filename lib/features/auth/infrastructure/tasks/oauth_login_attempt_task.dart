import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/shared/domain/models/htask.dart';
import 'package:hommie/features/shared/domain/models/htask_execution_context.dart';
import 'package:oauth2/oauth2.dart';

class OAuthLoginAttemptTask extends HTask<Credentials, AuthFailure> {
  final IAuthRepository _authRepository;

  final Uri _redirectUrl = Uri.parse('hommie://');

  OAuthLoginAttemptTask(this._authRepository);

  @override
  String get name => 'AttemptOAuthLogin';

  @override
  Future<HTaskResult<Credentials, AuthFailure>> execute(
    TaskExecutionContext context,
  ) async {
    final server = context.get<Server>('server');

    final authResult = await _authRepository.login(
      serverId: server.id!,
      serverUrl: server.baseUrl!,
      redirectUrl: _redirectUrl,
      handler: _handleAuthentication,
    );

    return authResult.fold(
      (error) => HTaskResult.failure(error),
      (credentials) => HTaskResult.success(credentials),
    );
  }

  Future<Map<String, String>> _handleAuthentication(Uri uri) async {
    final authenticateResult = await FlutterWebAuth2.authenticate(
      url: uri.toString(),
      callbackUrlScheme: _redirectUrl.scheme,
    );
    return Uri.parse(authenticateResult).queryParameters;
  }

  @override
  Future<void> rollback(TaskExecutionContext context) async {
    //TODO: sign out????
  }

  @override
  bool get supportsRollback => false;
}
