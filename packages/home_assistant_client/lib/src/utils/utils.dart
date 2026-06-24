bool atLeastHaVersion(String version, int major, int minor, [int? patch]) {
  final parts = version.split('.');
  if (parts.length < 3) {
    return false; // Handle invalid version format
  }

  final haMajor = int.parse(parts[0]);
  final haMinor = int.parse(parts[1]);
  final haPatch = patch ?? int.parse(parts[2]);

  return haMajor > major ||
      (haMajor == major &&
          (patch == null ? haMinor >= minor : haMinor > minor)) ||
      (patch != null &&
          haMajor == major &&
          haMinor == minor &&
          haPatch >= patch);
}
