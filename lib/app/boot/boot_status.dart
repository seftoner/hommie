import 'package:freezed_annotation/freezed_annotation.dart';

part 'boot_status.freezed.dart';

/// Describes the application boot process and whether the UI can proceed past
/// the splash/initialization routes.
@freezed
sealed class BootStatus with _$BootStatus {
  /// Boot completed successfully, the main application shell can be shown.
  const factory BootStatus.ready() = BootReady;

  /// Boot is still in progress.
  const factory BootStatus.inProgress() = BootInProgress;

  /// Boot failed with an unrecoverable error. The app should stay on the splash
  /// screen and allow retry or show diagnostics.
  const factory BootStatus.failure(Object error, StackTrace stackTrace) =
      BootFailure;
}
