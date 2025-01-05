import 'package:freezed_annotation/freezed_annotation.dart';

part 'ha_version.freezed.dart';

@freezed
class HaVersion with _$HaVersion {
  const HaVersion._();

  factory HaVersion({
    required int major,
    required int minor,
    int? patch,
  }) = _HaVersion;

  factory HaVersion.fromString(String strVersion) {
    final parts = strVersion.split('.');

    if (parts.length < 2 || parts.length > 3) {
      throw FormatException('Invalid version format: $strVersion');
    }

    final major = int.tryParse(parts[0]);
    final minor = int.tryParse(parts[1]);
    final patch = parts.length == 3 ? int.tryParse(parts[2]) : null;

    if (major == null ||
        minor == null ||
        (parts.length == 3 && patch == null)) {
      throw FormatException('Invalid version numbers: $strVersion');
    }

    return HaVersion(major: major, minor: minor, patch: patch);
  }

  bool isAtLeast(int minMajor, int minMinor, [int minPatch = 0]) {
    return major > minMajor ||
        (major == minMajor &&
            (minor > minMinor ||
                (minor == minMinor && (patch ?? 0) >= minPatch)));
  }
}
