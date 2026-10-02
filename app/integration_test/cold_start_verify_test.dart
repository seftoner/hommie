// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import 'utils/common.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './step/the_existing_persisted_session_is_used.dart';
import './step/the_application_is_running_in_the_foreground.dart';
import './step/i_see_page.dart';
import './step/i_should_see_the_offline_banner.dart';
import './step/i_see_light_card.dart';
import './step/home_assistant_remains_manageable.dart';
import './step/home_assistant_becomes_reachable_again.dart';
import './step/the_client_reconnects_to_home_assistant.dart';
import './step/i_should_not_see_the_offline_banner.dart';

void main() {
  group('''Recover a persisted offline cold launch''', () {
    patrol('''Launch a new process offline using persisted state''', ($) async {
      await theExistingPersistedSessionIsUsed($);
      await theApplicationIsRunningInTheForeground($);
      await iSeePage($, K.home.page);
      await iShouldSeeTheOfflineBanner($);
      await iSeeLightCard($, 'light.kitchen_light');
      await homeAssistantRemainsManageable($);
      await homeAssistantBecomesReachableAgain($);
      await theClientReconnectsToHomeAssistant($);
      await iShouldNotSeeTheOfflineBanner($);
      await iSeeLightCard($, 'light.kitchen_light');
    }, tags: ['cold_start', 'cold_verify']);
  });
}
