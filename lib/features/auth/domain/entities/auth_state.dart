import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:oauth2/oauth2.dart';

part '../../application/auth_state.freezed.dart';

/// Represents the current state of authentication in the application.
///
/// This sealed class hierarchy defines the authentication states:
/// * [Initial] - The initial state before any authentication checks
/// * [Authenticating] - Credentials are being acquired or refreshed
/// * [Authenticated] - The user is successfully authenticated
/// * [Refreshing] - The token is being refreshed while retaining the session
/// * [Revoked] - The server invalidated the session and requires re-auth
/// * [Unauthenticated] - No credentials are available for the server
/// * [Failure] - Authentication process failed with a specific [AuthFailure]
///
/// The class is immutable and all its constructors are constant.
/// Uses Freezed for code generation (indicated by _$AuthState mixin).
@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.initial() = Initial;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.authenticating() = Authenticating;
  const factory AuthState.authenticated(Credentials credentials) =
      Authenticated;
  const factory AuthState.refreshing(Credentials credentials) = Refreshing;
  const factory AuthState.revoked({AuthFailure? failure}) = Revoked;
  const factory AuthState.failure(AuthFailure failure) = Failure;
}
