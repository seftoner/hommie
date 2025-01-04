import 'package:flutter_test/flutter_test.dart';

import '../integration_test/utils/hass_token_manager.dart';

@Skip('Skip this tests')
void main() {
  test('HassTokenManager should create and delete long-lived access token',
      skip: 'This test only for debug purpose', () async {
    final manager = HassTokenManager();
    final token = await manager.createLongLivedToken();
    final isDeleted = await manager.deleteLongLivedToken();

    expect(token, isNotEmpty);
    expect(isDeleted, isTrue);
  });

  test('HassTokenManager should delete existing Hommie client token',
      skip: 'This test only for debug purpose', () async {
    final manager = HassTokenManager();
    final isDeleted = await manager.deleteHommieToken();

    expect(isDeleted, isTrue);
  });
}
