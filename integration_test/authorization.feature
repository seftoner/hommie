import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import './utils/common.dart';

@testMethodName: patrol
@testerName: $
@testerType: PatrolIntegrationTester
Feature: Sign In
  As a user
  I want to sign in to my Home Assistant server
  So that I can control my devices

  After:
    Then perform cleanup
  
  @quick
  Scenario: Enter address manually and sign in
    Given the application is running in the foreground
    And I see {K.serversDiscovery.page} page
    And I see {K.serversDiscovery.enterManuallyButton} button
    When I tap on {K.serversDiscovery.enterManuallyButton} button
    Then I see {K.manualAddress.page} page
    
    When I enter {'http://10.0.2.2:8123'} into {K.manualAddress.addressField} field
    And I tap on {K.manualAddress.connectButton} button
    Then I see credentials web view form
    
    When I enter {'admin'} {'yourpassword'} credentials
    And I tap on login button
    Then I see {K.home.page} page

  Scenario: Sign out
    Given home assistant access is configured    
    And I have successfully logged in   
    And the application is running in the foreground
    
    When I tap on {K.appScaffold.settingsButton} button  
    Then I see {K.settings.page} page  
    When I tap on {K.settings.hubItem} list item  
    Then I see {K.hub.page} page  
    When I tap on {K.hub.signOutButton} button  
    Then I see {K.hub.signOutAlert} alert
    When I tap on {K.hub.signOutButton} button 
    Then I see {K.serversDiscovery.page} page 

  Scenario: Logged out on server side
    Given home assistant access is configured    
    And I have successfully logged in   
    And the application is running in the foreground
    And I see {K.home.page} page
    
    When home assistant revokes access
    Then I should see the offline banner
    And I see {K.serversDiscovery.page} page