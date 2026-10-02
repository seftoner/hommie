import 'package:patrol/patrol.dart';
import 'utils/common.dart';

@testMethodName: patrol
@testerName: $
@testerType: PatrolIntegrationTester
Feature: Internal persisted state recovery
  @internal_cleanup
  Scenario: Remove app owned session after native interruption
    Then app owned persisted state is clean
