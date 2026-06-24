// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import 'utils/common.dart';
import 'utils/hass_area_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './step/perform_cleanup.dart';
import './step/home_assistant_test_areas_are_clean.dart';
import './step/home_assistant_access_is_configured.dart';
import './step/i_have_successfully_logged_in.dart';
import './step/the_application_is_running_in_the_foreground.dart';
import './step/i_see_page.dart';
import './step/i_tap_on_button.dart';
import './step/i_tap_on_list_item.dart';
import './step/i_create_area.dart';
import './step/home_assistant_should_have_area.dart';
import './step/i_rename_area.dart';
import './step/home_assistant_should_not_have_area.dart';
import './step/i_delete_area.dart';

void main() {
  group('''Area Management''', () {
    Future<void> bddSetUp(PatrolIntegrationTester $) async {
      await homeAssistantAccessIsConfigured($);
      await homeAssistantTestAreasAreClean($);
      await iHaveSuccessfullyLoggedIn($);
    }

    Future<void> bddTearDown(PatrolIntegrationTester $) async {
      await performCleanup($);
      await homeAssistantTestAreasAreClean($);
    }

    patrol('''Create rename and delete an area''', ($) async {
      try {
        await bddSetUp($);
        await theApplicationIsRunningInTheForeground($);
        await iSeePage($, K.home.page);
        await iTapOnButton($, K.appScaffold.settingsButton);
        await iSeePage($, K.settings.page);
        await iTapOnListItem($, K.settings.areasItem);
        await iSeePage($, K.areas.page);
        await iCreateArea($, HassAreaManager.initialName);
        await homeAssistantShouldHaveArea($, HassAreaManager.initialName);
        await iRenameArea(
          $,
          HassAreaManager.initialName,
          HassAreaManager.renamedName,
        );
        await homeAssistantShouldHaveArea($, HassAreaManager.renamedName);
        await homeAssistantShouldNotHaveArea($, HassAreaManager.initialName);
        await iDeleteArea($, HassAreaManager.renamedName);
        await homeAssistantShouldNotHaveArea($, HassAreaManager.renamedName);
      } finally {
        await bddTearDown($);
      }
    });
  });
}
