import 'package:flutter_test/flutter_test.dart';

import '../../integration_test/utils/cold_phase.dart';

void main() {
  test('phase gate preserves caller skip and excludes wrong process', () {
    expect(coldPhaseSkip('none', ['cold_seed'], false), isTrue);
    expect(coldPhaseSkip('seed', ['cold_seed'], false), isFalse);
    expect(coldPhaseSkip('seed', ['cold_verify'], false), isTrue);
    expect(coldPhaseSkip('verify', ['cold_verify'], true), isTrue);
    expect(coldPhaseSkip('verify', ['offline'], false), isTrue);
    expect(coldPhaseSkip('none', ['offline'], null), isFalse);
  });
}
