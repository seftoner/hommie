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
  static const homeButton = Key('homeButton');
  static const settingsButton = Key('settingsButton');

  /// PAGE: Settings
  static const settingsPage = Key('settingsPage');
  static const hubListItem = Key('hubListItem');
  static const sensorsListItem = Key('sensorsListItem');
  static const nfsListItem = Key('nfsListItem');
  static const logsListItem = Key('logsListItem');
  static const aboutListItem = Key('aboutListItem');

  /// PAGE: Hub
  static const hubPage = Key('hubPage');
  static const signOutButton = Key('signOutButton');
  static const signOutAlert = Key('signOutDialog');
}
