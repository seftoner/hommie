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
import './step/the_kitchen_light_is_persisted.dart';

void main() {
  group('''Persist online state for cold launch''', () {
    patrol('''Persist a real online session and kitchen light''', ($) async {
      await homeAssistantAccessIsConfigured($);
      await iHaveSuccessfullyLoggedIn($);
      await theApplicationIsRunningInTheForeground($);
      await iSeePage($, K.home.page);
      await theClientIsConnectedToHomeAssistant($);
      await theKitchenLightIsSelectedForTheHomeView($);
      await iSeeLightCard($, 'light.kitchen_light');
      await theKitchenLightIsPersisted($);
    }, tags: ['cold_start', 'cold_seed']);
  });
}
