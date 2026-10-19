import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import 'utils/common.dart';

@testMethodName: patrol
@testerName: $
@testerType: PatrolIntegrationTester
Feature: Recover a persisted offline cold launch
  @cold_start
  @cold_verify
  Scenario: Launch a new process offline using persisted state
    Given the existing persisted session is used
    When the application is running in the foreground
    Then I see {K.home.page} page
    And I should see the offline banner
    And I see light card {'light.kitchen_light'}
    And home assistant remains manageable
    When home assistant becomes reachable again
    Then the client reconnects to home assistant
    And I should not see the offline banner
    And I see light card {'light.kitchen_light'}
