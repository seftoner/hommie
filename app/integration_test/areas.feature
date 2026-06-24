import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import 'utils/common.dart';
import 'utils/hass_area_manager.dart';

@testMethodName: patrol
@testerName: $
@testerType: PatrolIntegrationTester
Feature: Area Management
  As a user
  I want to create, rename, and delete Home Assistant areas
  So that Hommie stays synchronized with Home Assistant area registry state

  After:
    Then perform cleanup
    And home assistant test areas are clean

  Background:
    Given home assistant access is configured
    And home assistant test areas are clean
    And I have successfully logged in

  Scenario: Create rename and delete an area
    Given the application is running in the foreground
    And I see {K.home.page} page

    When I tap on {K.appScaffold.settingsButton} button
    Then I see {K.settings.page} page

    When I tap on {K.settings.areasItem} list item
    Then I see {K.areas.page} page

    When I create area {HassAreaManager.initialName}
    Then home assistant should have area {HassAreaManager.initialName}

    When I rename area {HassAreaManager.initialName} {HassAreaManager.renamedName}
    Then home assistant should have area {HassAreaManager.renamedName}
    And home assistant should not have area {HassAreaManager.initialName}

    When I delete area {HassAreaManager.renamedName}
    Then home assistant should not have area {HassAreaManager.renamedName}
