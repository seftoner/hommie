import 'package:flutter_test/flutter_test.dart';

import '../integration_test/utils/hass_token_manager.dart';

@Skip('Skip this tests')
void main() {
  test('Test RemoteHassCli tool', skip: 'This test only for debug purpose',
      () async {
    final manager = HassTokenManager();
    final token = await manager.createToken();
    await manager.cleanupToken();

    expect(token, isNotEmpty);
  });
}
