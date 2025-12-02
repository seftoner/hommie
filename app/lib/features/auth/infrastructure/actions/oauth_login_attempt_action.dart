import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:hommie/core/infrastructure/actions/haction.dart';
import 'package:hommie/core/infrastructure/actions/haction_execution_context.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:oauth2/oauth2.dart';

class OAuthLoginAttemptAction extends HAction<Credentials, AuthFailure> {
  final IAuthRepository _authRepository;

  final Uri _redirectUrl = Uri.parse('hommie://');

  OAuthLoginAttemptAction(this._authRepository);

  @override
  String get name => 'AttemptOAuthLogin';

  @override
  Future<HActionResult<Credentials, AuthFailure>> execute(
    ActionExecutionContext context,
  ) async {
    final server = context.get<Server>('server');

    final authResult = await _authRepository.login(
      serverId: server.id!,
      serverUrl: server.baseUrl!.value.getOrElse((_) => ''),
      redirectUrl: _redirectUrl,
      handler: _handleAuthentication,
    );

    return authResult.fold(
      (error) => HActionResult.failure(error),
      (credentials) => HActionResult.success(credentials),
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
  Future<void> rollback(ActionExecutionContext context) async {
    //TODO: sign out????
  }

  @override
  bool get supportsRollback => false;
}
