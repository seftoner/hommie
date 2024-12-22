import 'package:flutter/foundation.dart';

typedef K = Keys;

class Keys {
  const Keys();

  /// PAGE: Servers Discovery
  static const serversDiscoveryPage = Key('serversDiscoveryPage');
  static const enterAddresManuallyButton = Key('enterAddresManuallyButton');

  /// PAGE: Enter Addres Manually
  static const enterAddresManuallyPage = Key('enterAddresManuallyPage');
  static const hubAddressTextField = Key('hubAddressTextField');
  static const connectButton = Key('connectButton');

  /// PAGE: Hommie
  static const hommiePage = Key('hommiePage');
}
