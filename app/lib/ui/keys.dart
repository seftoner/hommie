import 'package:flutter/foundation.dart';

typedef K = Keys;

class Keys {
  const Keys();

  static const serversDiscovery = ServersDiscoveryKeys();
  static const manualAddress = ManualAddressKeys();
  static const appScaffold = AppScaffoldKeys();
  static const home = HomeKeys();
  static const common = CommonKeys();
  static const settings = SettingsKeys();
  static const areas = AreasKeys();
  static const hub = HubKeys();
  static const onboarding = OnboardingKeys();
}

class ServersDiscoveryKeys {
  const ServersDiscoveryKeys();

  final page = const Key('serversDiscoveryPage');
  final enterManuallyButton = const Key('enterAddresManuallyButton');
}

class ManualAddressKeys {
  const ManualAddressKeys();

  final page = const Key('enterAddresManuallyPage');
  final addressField = const Key('hubAddressTextField');
  final connectButton = const Key('connectButton');
}

class CommonKeys {
  const CommonKeys();

  final offlineBanner = const Key('offlineBanner');
}

class HomeKeys {
  const HomeKeys();

  final page = const Key('hommiePage');
  final loadingSpinner = const Key('homeLoadingSpinner');
  final settingsButton = const Key('settingsButton');
}

class AppScaffoldKeys {
  const AppScaffoldKeys();

  final homeButton = const Key('homeButton');
  final automationButton = const Key('automationButton');
  final settingsButton = const Key('settingsButton');
}

class SettingsKeys {
  const SettingsKeys();

  final page = const Key('settingsPage');
  final hubItem = const Key('hubListItem');
  final areasItem = const Key('areasListItem');
  final sensorsItem = const Key('sensorsListItem');
  final nfcItem = const Key('nfcListItem');
  final logsItem = const Key('logsListItem');
  final aboutItem = const Key('aboutListItem');
}

class AreasKeys {
  const AreasKeys();

  final page = const Key('areasPage');
  final createButton = const Key('areasCreateButton');
  final nameField = const Key('areasNameField');
  final saveButton = const Key('areasSaveButton');
  final deleteDialog = const Key('areasDeleteDialog');
  final deleteConfirmButton = const Key('areasDeleteConfirmButton');
}

class HubKeys {
  const HubKeys();

  final page = const Key('hubPage');
  final signOutButton = const Key('signOutButton');
  final signOutAlert = const Key('signOutDialog');
}

class OnboardingKeys {
  const OnboardingKeys();

  final permissionPage = const Key('permissionsPage');
  final welcomePage = const Key('welcomePage');
  final welcomeContinueButton = const Key('welcomeContinueButton');
  final permissionsConnectButton = const Key('permissionsConnectButton');
}
