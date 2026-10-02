// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:patrol/patrol.dart';
import 'utils/common.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './step/app_owned_persisted_state_is_clean.dart';

void main() {
  group('''Internal persisted state recovery''', () {
    patrol('''Remove app owned session after native interruption''', ($) async {
      await appOwnedPersistedStateIsClean($);
    }, tags: ['internal_cleanup']);
  });
}
