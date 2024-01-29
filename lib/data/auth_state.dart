import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hommie/networking/auth_failure.dart';

part 'auth_state.freezed.dart';

/// Authentication class for this sample application.
/// It should be self-explanatory.
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.signedIn({
    required String token,
  }) = _SignedIn;
  const AuthState._();
  const factory AuthState.initial() = _Initial;
  const factory AuthState.signedOut() = _SignedOut;
  const factory AuthState.unauthenticated() = _Unauthicated;
  const factory AuthState.failure(AuthFailure failure) = _Failure;

  bool get isAuth => switch (this) {
        _SignedIn() => true,
        _SignedOut() => false,
        _Failure() => false,
        _Unauthicated() => false,
        _Initial() => false,
      };
}
