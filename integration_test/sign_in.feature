import 'package:patrol/patrol.dart';
import 'common.dart';
import 'package:hommie/ui/keys.dart';

@testMethodName: patrol
@testerName: $
@testerType: PatrolIntegrationTester
Feature: Sign In
  Background: 
    Given the patrol app is running
  
  Scenario: Enter address manually    
    Given I see {K.serversDiscoveryPage} page
    And I see {K.enterAddresManuallyButton} button
    When I tap on {K.enterAddresManuallyButton} button
    Then I see {K.enterAddresManuallyPage} page
    
    When I enter {'http://10.0.2.2:8123'} into {K.hubAddressTextField} field
    And I tap on {K.connectButton} button
    Then I see credentials web view form
    
    When I enter {'admin'} {'yourpassword'} credentials
    And I tap on login button
    Then I see {K.hommiePage} page