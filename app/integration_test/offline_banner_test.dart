// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import 'utils/common.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './step/home_assistant_access_is_configured.dart';
import './step/i_have_successfully_logged_in.dart';
import './step/the_application_is_running_in_the_foreground.dart';
import './step/i_see_page.dart';
import './step/the_client_is_connected_to_home_assistant.dart';
import './step/the_kitchen_light_is_selected_for_the_home_view.dart';
import './step/i_see_light_card.dart';
import './step/i_should_not_see_the_offline_banner.dart';
import './step/the_client_loses_connection_to_home_assistant.dart';
import './step/i_should_see_the_offline_banner.dart';
import './step/home_assistant_remains_manageable.dart';
import './step/home_assistant_becomes_reachable_again.dart';
import './step/the_client_reconnects_to_home_assistant.dart';

void main() {
  group('''Connection Status Banner''', () {
    Future<void> bddSetUp(PatrolIntegrationTester $) async {
      await homeAssistantAccessIsConfigured($);
      await iHaveSuccessfullyLoggedIn($);
    }

    patrol('''Banner visibility when connection is lost and restored''',
        ($) async {
      await bddSetUp($);
      await theApplicationIsRunningInTheForeground($);
      await iSeePage($, K.home.page);
      await theClientIsConnectedToHomeAssistant($);
      await theKitchenLightIsSelectedForTheHomeView($);
      await iSeeLightCard($, 'light.kitchen_light');
      await iShouldNotSeeTheOfflineBanner($);
      await theClientLosesConnectionToHomeAssistant($);
      await iShouldSeeTheOfflineBanner($);
      await iSeeLightCard($, 'light.kitchen_light');
      await homeAssistantRemainsManageable($);
      await homeAssistantBecomesReachableAgain($);
      await theClientReconnectsToHomeAssistant($);
      await iShouldNotSeeTheOfflineBanner($);
      await iSeeLightCard($, 'light.kitchen_light');
    }, tags: ['offline']);
  });
}
