import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import './utils/common.dart';

@testMethodName: patrol
@testerName: $
@testerType: PatrolIntegrationTester
Feature: Connection Status Banner
  As a user
  I want to be notified when the app loses connection to Home Assistant
  So that I know when the system is not functioning properly

  After:
    Then the device regains network connectivity
    And I wait {3} seconds
    And clean up after the test
    
  Background:
    Given home assistant access is configured    
    And I have successfully logged in
    

  Scenario: Banner visibility when connection is lost and restored
    And the application is running in the foreground
    And I see {K.home.page} page
    
    # Check initial state
    Then I should not see the offline banner
    
    # Test connection loss
    When the device loses network connectivity
    And I wait {3} seconds
    Then I should see the offline banner

    # Test connection restoration
    When the device regains network connectivity
    And I wait {5} seconds
    Then I should not see the offline banner

  Scenario: Launch app in offline mode
    # Initial setup and app launch
    Given the device loses network connectivity
    And I wait {2} seconds
    
    # Launch app and verify
    When the application is running in the foreground
    And I see {K.home.page} page
    Then I should see the offline banner
    
    # Test connection restoration
    When the device regains network connectivity
    And I wait {5} seconds
    Then I should not see the offline banner
