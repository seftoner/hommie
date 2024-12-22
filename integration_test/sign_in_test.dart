// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:patrol/patrol.dart';
import 'common.dart';
import 'package:hommie/ui/keys.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './../test/step/the_patrol_app_is_running.dart';
import './../test/step/i_see_page.dart';
import './../test/step/i_see_button.dart';
import './../test/step/i_tap_on_button.dart';
import './../test/step/i_enter_into_field.dart';
import './../test/step/i_see_credentials_web_view_form.dart';
import './../test/step/i_enter_credentials.dart';
import './../test/step/i_tap_on_login_button.dart';

void main() {
  group('''Sign In''', () {
    Future<void> bddSetUp(PatrolIntegrationTester $) async {
      await thePatrolAppIsRunning($);
    }

    patrol('''Enter address manually''', ($) async {
      await bddSetUp($);
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
    });
  });
}
