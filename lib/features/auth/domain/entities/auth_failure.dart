import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const AuthFailure._();
  const factory AuthFailure.server([String? message]) = ServerFailure;
  const factory AuthFailure.userBrake([String? message]) = UserBrake;
  const factory AuthFailure.storage() = Storage;
  const factory AuthFailure.missingCredentials() = MissingCredentials;
  const factory AuthFailure.invalidToken([String? message]) = InvalidToken;
  const factory AuthFailure.connection() = Connection;
}
