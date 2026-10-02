import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import 'utils/common.dart';

@testMethodName: patrol
@testerName: $
@testerType: PatrolIntegrationTester
Feature: Persist online state for cold launch
  @cold_start
  @cold_seed
  Scenario: Persist a real online session and kitchen light
    Given home assistant access is configured
    And I have successfully logged in
    And the application is running in the foreground
    And I see {K.home.page} page
    And the client is connected to home assistant
    And the kitchen light is selected for the home view
    And I see light card {'light.kitchen_light'}
    Then the kitchen light is persisted
