// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import './utils/common.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './step/perform_cleanup.dart';
import './step/the_application_is_running_in_the_foreground.dart';
import './step/i_see_page.dart';
import './step/i_see_button.dart';
import './step/i_tap_on_button.dart';
import './step/i_enter_into_field.dart';
import './step/i_see_credentials_web_view_form.dart';
import './step/i_enter_credentials.dart';
import './step/i_tap_on_login_button.dart';
import './step/home_assistant_access_is_configured.dart';
import './step/i_have_successfully_logged_in.dart';
import './step/i_tap_on_list_item.dart';
import './step/i_see_alert.dart';
import './step/home_assistant_revokes_access.dart';
import './step/i_should_see_the_offline_banner.dart';

void main() {
  group('''Sign In''', () {
    Future<void> bddTearDown(PatrolIntegrationTester $) async {
      await performCleanup($);
    }

    patrol('''Enter address manually and sign in''', ($) async {
      try {
        await theApplicationIsRunningInTheForeground($);
        await iSeePage($, K.serversDiscovery.page);
        await iSeeButton($, K.serversDiscovery.enterManuallyButton);
        await iTapOnButton($, K.serversDiscovery.enterManuallyButton);
        await iSeePage($, K.manualAddress.page);
        await iEnterIntoField(
            $, 'http://10.0.2.2:8123', K.manualAddress.addressField);
        await iTapOnButton($, K.manualAddress.connectButton);
        await iSeeCredentialsWebViewForm($);
        await iEnterCredentials($, 'admin', 'yourpassword');
        await iTapOnLoginButton($);
        await iSeePage($, K.home.page);
      } finally {
        await bddTearDown($);
      }
    }, tags: ['quick']);
    patrol('''Sign out''', ($) async {
      try {
        await homeAssistantAccessIsConfigured($);
        await iHaveSuccessfullyLoggedIn($);
        await theApplicationIsRunningInTheForeground($);
        await iTapOnButton($, K.appScaffold.settingsButton);
        await iSeePage($, K.settings.page);
        await iTapOnListItem($, K.settings.hubItem);
        await iSeePage($, K.hub.page);
        await iTapOnButton($, K.hub.signOutButton);
        await iSeeAlert($, K.hub.signOutAlert);
        await iTapOnButton($, K.hub.signOutButton);
        await iSeePage($, K.serversDiscovery.page);
      } finally {
        await bddTearDown($);
      }
    });
    patrol('''Logged out on server side''', ($) async {
      try {
        await homeAssistantAccessIsConfigured($);
        await iHaveSuccessfullyLoggedIn($);
        await theApplicationIsRunningInTheForeground($);
        await iSeePage($, K.home.page);
        await homeAssistantRevokesAccess($);
        await iShouldSeeTheOfflineBanner($);
        await iSeePage($, K.serversDiscovery.page);
      } finally {
        await bddTearDown($);
      }
    });
  });
}
