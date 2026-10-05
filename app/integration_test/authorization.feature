import 'package:patrol/patrol.dart';
import 'package:hommie/ui/keys.dart';
import 'utils/common.dart';

@testMethodName: patrol
@testerName: $
@testerType: PatrolIntegrationTester
Feature: Sign In
  As a user
  I want to sign in to my Home Assistant server
  So that I can control my devices

  @quick
  @discovery
  Scenario: Enter address manually and sign in
    Given no home assistant servers are discoverable
    And the application is running in the foreground
    When I complete onboarding
    And I see {K.serversDiscovery.page} page
    Then I see no discovered home assistant servers
    And I see {K.serversDiscovery.enterManuallyButton} button
    When I tap on {K.serversDiscovery.enterManuallyButton} button
    Then I see {K.manualAddress.page} page
    
    When I enter the home assistant address
    And I tap on {K.manualAddress.connectButton} button
    Then I see credentials web view form
    
    When I enter the configured credentials
    And I tap on login button
    Then I see {K.home.page} page

  @discovery
  Scenario: Sign in through a discovered server
    Given a home assistant server is discoverable as {'Hommie E2E'}
    And the application is running in the foreground
    When I complete onboarding
    Then I see {K.serversDiscovery.page} page
    And I see the discovered home assistant {'Hommie E2E'}
    When I tap on {'Hommie E2E'}
    Then I see credentials web view form
    When I enter the configured credentials
    And I tap on login button
    Then I see {K.home.page} page

  Scenario: Sign out
    Given home assistant access is configured    
    And I have successfully logged in   
    And the application is running in the foreground
    
    When I tap on {K.appScaffold.settingsButton} button  
    Then I see {K.settings.page} page  
    When I scroll to {K.hub.signOutButton} button
    When I tap on {K.hub.signOutButton} button  
    Then I see {K.hub.signOutAlert} alert
    When I tap on {K.hub.signOutButton} button 
    Then I see {K.onboarding.welcomePage} page
    And the active session is removed
    When I complete onboarding
    Then I see {K.serversDiscovery.page} page

  @revocation
  Scenario: Logged out on server side
    Given home assistant access is configured    
    And I have successfully logged in   
    And the application is running in the foreground
    And I see {K.home.page} page
    And the client is connected to home assistant
    
    When home assistant revokes access
    Then I see {K.onboarding.welcomePage} page
    And the active session is removed
    When I complete onboarding
    Then I see {K.serversDiscovery.page} page
