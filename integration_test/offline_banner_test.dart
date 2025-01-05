// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import './utils/common.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './step/the_device_regains_network_connectivity.dart';
import './step/i_wait_seconds.dart';
import './step/perform_cleanup.dart';
import './step/home_assistant_access_is_configured.dart';
import './step/i_have_successfully_logged_in.dart';
import './step/the_application_is_running_in_the_foreground.dart';
import './step/i_see_page.dart';
import './step/i_should_not_see_the_offline_banner.dart';
import './step/the_device_loses_network_connectivity.dart';
import './step/i_should_see_the_offline_banner.dart';

void main() {
  group('''Connection Status Banner''', () {
    Future<void> bddSetUp(PatrolIntegrationTester $) async {
      await homeAssistantAccessIsConfigured($);
      await iHaveSuccessfullyLoggedIn($);
    }

    Future<void> bddTearDown(PatrolIntegrationTester $) async {
      await theDeviceRegainsNetworkConnectivity($);
      await iWaitSeconds($, 3);
      await performCleanup($);
    }

    patrol('''Banner visibility when connection is lost and restored''',
        ($) async {
      try {
        await bddSetUp($);
        await theApplicationIsRunningInTheForeground($);
        await iSeePage($, K.home.page);
        await iShouldNotSeeTheOfflineBanner($);
        await theDeviceLosesNetworkConnectivity($);
        await iWaitSeconds($, 3);
        await iShouldSeeTheOfflineBanner($);
        await theDeviceRegainsNetworkConnectivity($);
        await iWaitSeconds($, 5);
        await iShouldNotSeeTheOfflineBanner($);
      } finally {
        await bddTearDown($);
      }
    });
    patrol('''Launch app in offline mode''', ($) async {
      try {
        await bddSetUp($);
        await theDeviceLosesNetworkConnectivity($);
        await iWaitSeconds($, 2);
        await theApplicationIsRunningInTheForeground($);
        await iSeePage($, K.home.page);
        await iShouldSeeTheOfflineBanner($);
        await theDeviceRegainsNetworkConnectivity($);
        await iWaitSeconds($, 5);
        await iShouldNotSeeTheOfflineBanner($);
      } finally {
        await bddTearDown($);
      }
    });
  });
}
