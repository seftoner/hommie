import 'package:flutter_test/flutter_test.dart';

import '../../integration_test/utils/cold_phase.dart';

void main() {
  test('phase gate preserves caller skip and excludes wrong process', () {
    expect(coldPhaseSkip('none', ['cold_seed'], callerSkip: false), isTrue);
    expect(coldPhaseSkip('seed', ['cold_seed'], callerSkip: false), isFalse);
    expect(coldPhaseSkip('seed', ['cold_verify'], callerSkip: false), isTrue);
    expect(coldPhaseSkip('verify', ['cold_verify'], callerSkip: true), isTrue);
    expect(coldPhaseSkip('verify', ['offline'], callerSkip: false), isTrue);
    expect(coldPhaseSkip('none', ['offline']), isFalse);
  });
}
