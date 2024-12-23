import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import './utils/common.dart';

@testMethodName: patrol
@testerName: $
@testerType: PatrolIntegrationTester
Feature: Sign In

  After:
    Then clean up after the test
  
  Scenario: Enter address manually and sign in
    Given the patrol app is running    
    And I see {K.serversDiscoveryPage} page
    And I see {K.enterAddresManuallyButton} button
    When I tap on {K.enterAddresManuallyButton} button
    Then I see {K.enterAddresManuallyPage} page
    
    When I enter {'http://10.0.2.2:8123'} into {K.hubAddressTextField} field
    And I tap on {K.connectButton} button
    Then I see credentials web view form
    
    When I enter {'admin'} {'yourpassword'} credentials
    And I tap on login button
    Then I see {K.hommiePage} page

  Scenario: Sign out
    Given I logged in    
    And the patrol app is running
    When I tap on {K.settingsButton} button  
    Then I see {K.settingsPage} page  
    When I tap on {K.hubListItem} list item  
    Then I see {K.hubPage} page  
    When I tap on {K.signOutButton} button  
    Then I see {K.signOutAlert} alert
    When I tap on {K.signOutButton} button 
    Then I see {K.serversDiscoveryPage} page 
    