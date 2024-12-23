// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import './utils/common.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './step/clean_up_after_the_test.dart';
import './step/the_patrol_app_is_running.dart';
import './step/i_see_page.dart';
import './step/i_see_button.dart';
import './step/i_tap_on_button.dart';
import './step/i_enter_into_field.dart';
import './step/i_see_credentials_web_view_form.dart';
import './step/i_enter_credentials.dart';
import './step/i_tap_on_login_button.dart';
import './step/i_logged_in.dart';
import './step/i_tap_on_list_item.dart';
import './step/i_see_alert.dart';

void main() {
  group('''Sign In''', () {
    Future<void> bddTearDown(PatrolIntegrationTester $) async {
      await cleanUpAfterTheTest($);
    }

    patrol('''Enter address manually and sign in''', ($) async {
      try {
        await thePatrolAppIsRunning($);
        await iSeePage($, K.serversDiscoveryPage);
        await iSeeButton($, K.enterAddresManuallyButton);
        await iTapOnButton($, K.enterAddresManuallyButton);
        await iSeePage($, K.enterAddresManuallyPage);
        await iEnterIntoField($, 'http://10.0.2.2:8123', K.hubAddressTextField);
        await iTapOnButton($, K.connectButton);
        await iSeeCredentialsWebViewForm($);
        await iEnterCredentials($, 'admin', 'yourpassword');
        await iTapOnLoginButton($);
        await iSeePage($, K.hommiePage);
      } finally {
        await bddTearDown($);
      }
    });
    patrol('''Sign out''', ($) async {
      try {
        await iLoggedIn($);
        await thePatrolAppIsRunning($);
        await iTapOnButton($, K.settingsButton);
        await iSeePage($, K.settingsPage);
        await iTapOnListItem($, K.hubListItem);
        await iSeePage($, K.hubPage);
        await iTapOnButton($, K.signOutButton);
        await iSeeAlert($, K.signOutAlert);
        await iTapOnButton($, K.signOutButton);
        await iSeePage($, K.serversDiscoveryPage);
      } finally {
        await bddTearDown($);
      }
    });
  });
}
