import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestProviderOverrides {
  factory TestProviderOverrides.instance() => _singleton;
  TestProviderOverrides._();
  static final TestProviderOverrides _singleton = TestProviderOverrides._();

  List<Override> _overrides = [];

  void setOverrides(List<Override> overrides) {
    _overrides = overrides;
  }

  List<Override> get overrides => _overrides;

  void clear() {
    _overrides = [];
  }
}
