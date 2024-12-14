import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';

part 'auth_state.freezed.dart';

/// Represents the current state of authentication in the application.
///
/// This sealed class hierarchy defines four possible authentication states:
/// * [Initial] - The initial state before any authentication checks
/// * [Authenticated] - The user is successfully authenticated
/// * [Unauthenticated] - The user is not authenticated
/// * [Failure] - Authentication process failed with a specific [AuthFailure]
///
/// The class is immutable and all its constructors are constant.
/// Uses Freezed for code generation (indicated by _$AuthState mixin).
@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.initial() = Initial;
  const factory AuthState.authenticated() = Authenticated;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.failure(AuthFailure failure) = Failure;
}
