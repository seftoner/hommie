// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import 'utils/common.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './step/the_application_is_running_in_the_foreground.dart';
import './step/i_complete_onboarding.dart';
import './step/i_see_page.dart';
import './step/i_see_button.dart';
import './step/i_tap_on_button.dart';
import './step/i_enter_the_home_assistant_address.dart';
import './step/i_see_credentials_web_view_form.dart';
import './step/i_enter_the_configured_credentials.dart';
import './step/i_tap_on_login_button.dart';
import './step/home_assistant_access_is_configured.dart';
import './step/i_have_successfully_logged_in.dart';
import './step/i_scroll_to_button.dart';
import './step/i_see_alert.dart';
import './step/the_active_session_is_removed.dart';
import './step/the_client_is_connected_to_home_assistant.dart';
import './step/home_assistant_revokes_access.dart';

void main() {
  group('''Sign In''', () {
    patrol('''Enter address manually and sign in''', ($) async {
      await theApplicationIsRunningInTheForeground($);
      await iCompleteOnboarding($);
      await iSeePage($, K.serversDiscovery.page);
      await iSeeButton($, K.serversDiscovery.enterManuallyButton);
      await iTapOnButton($, K.serversDiscovery.enterManuallyButton);
      await iSeePage($, K.manualAddress.page);
      await iEnterTheHomeAssistantAddress($);
      await iTapOnButton($, K.manualAddress.connectButton);
      await iSeeCredentialsWebViewForm($);
      await iEnterTheConfiguredCredentials($);
      await iTapOnLoginButton($);
      await iSeePage($, K.home.page);
    }, tags: ['quick']);
    patrol('''Sign out''', ($) async {
      await homeAssistantAccessIsConfigured($);
      await iHaveSuccessfullyLoggedIn($);
      await theApplicationIsRunningInTheForeground($);
      await iTapOnButton($, K.appScaffold.settingsButton);
      await iSeePage($, K.settings.page);
      await iScrollToButton($, K.hub.signOutButton);
      await iTapOnButton($, K.hub.signOutButton);
      await iSeeAlert($, K.hub.signOutAlert);
      await iTapOnButton($, K.hub.signOutButton);
      await iSeePage($, K.onboarding.welcomePage);
      await theActiveSessionIsRemoved($);
      await iCompleteOnboarding($);
      await iSeePage($, K.serversDiscovery.page);
    });
    patrol('''Logged out on server side''', ($) async {
      await homeAssistantAccessIsConfigured($);
      await iHaveSuccessfullyLoggedIn($);
      await theApplicationIsRunningInTheForeground($);
      await iSeePage($, K.home.page);
      await theClientIsConnectedToHomeAssistant($);
      await homeAssistantRevokesAccess($);
      await iSeePage($, K.onboarding.welcomePage);
      await theActiveSessionIsRemoved($);
      await iCompleteOnboarding($);
      await iSeePage($, K.serversDiscovery.page);
    }, tags: ['revocation']);
  });
}
