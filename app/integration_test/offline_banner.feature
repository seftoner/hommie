import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import 'utils/common.dart';

@testMethodName: patrol
@testerName: $
@testerType: PatrolIntegrationTester
Feature: Connection Status Banner
  As a user
  I want to see when Hommie loses its connection to Home Assistant
  So that I can use cached devices until the connection recovers

  Background:
    Given home assistant access is configured
    And I have successfully logged in

  @offline
  Scenario: Banner visibility when connection is lost and restored
    Given the application is running in the foreground
    And I see {K.home.page} page
    And the client is connected to home assistant
    And the kitchen light is selected for the home view
    And I see light card {'light.kitchen_light'}
    And I should not see the offline banner

    When the client loses connection to home assistant
    Then I should see the offline banner
    And I see light card {'light.kitchen_light'}
    And home assistant remains manageable

    When home assistant becomes reachable again
    Then the client reconnects to home assistant
    And I should not see the offline banner
    And I see light card {'light.kitchen_light'}
