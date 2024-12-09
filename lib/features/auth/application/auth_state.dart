import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';

part 'auth_state.freezed.dart';

/// Authentication class for this sample application.
/// It should be self-explanatory.
@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.initial() = Initial;
  const factory AuthState.authenticated() = Authenticated;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.failure(AuthFailure failure) = Failure;
}
