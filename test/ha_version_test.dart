import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/domain/entities/ha_version.dart';

void main() {
  group('HaVersion', () {
    test('parses valid version strings', () {
      expect(
        HaVersion.fromString('2023.12'),
        equals(HaVersion(major: 2023, minor: 12)),
      );
      expect(
        HaVersion.fromString('2023.12.0'),
        equals(HaVersion(major: 2023, minor: 12, patch: 0)),
      );
    });

    test('throws FormatException for invalid version strings', () {
      expect(
        () => HaVersion.fromString('2023'),
        throwsFormatException,
      );
      expect(
        () => HaVersion.fromString('2023.12.0.0'),
        throwsFormatException,
      );
      expect(
        () => HaVersion.fromString('invalid'),
        throwsFormatException,
      );
      expect(
        () => HaVersion.fromString('2023.abc'),
        throwsFormatException,
      );
    });

    group('isAtLeast', () {
      final version = HaVersion(major: 2023, minor: 12, patch: 1);

      test('compares major versions correctly', () {
        expect(version.isAtLeast(2022, 12), isTrue);
        expect(version.isAtLeast(2024, 12), isFalse);
      });

      test('compares minor versions correctly', () {
        expect(version.isAtLeast(2023, 11), isTrue);
        expect(version.isAtLeast(2023, 13), isFalse);
      });

      test('compares patch versions correctly', () {
        expect(version.isAtLeast(2023, 12, 0), isTrue);
        expect(version.isAtLeast(2023, 12, 1), isTrue);
        expect(version.isAtLeast(2023, 12, 2), isFalse);
      });

      test('handles missing patch version', () {
        final versionNoPatch = HaVersion(major: 2023, minor: 12);
        expect(versionNoPatch.isAtLeast(2023, 12, 0), isTrue);
        expect(versionNoPatch.isAtLeast(2023, 12, 1), isFalse);
      });
    });
  });
}
