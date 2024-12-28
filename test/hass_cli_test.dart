import 'package:flutter_test/flutter_test.dart';

import '../integration_test/utils/hass_token_manager.dart';

void main() {
  test('Test RemoteHassCli tool', () async {
    final manager = HassTokenManager();
    final token = await manager.createToken();
    await manager.cleanupToken();

    expect(token, isNotEmpty);
  });
}
