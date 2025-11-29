// In Riverpod 3, provider overrides are handled using provider.overrideWith() methods
// This class manages a list of dynamic overrides that can be used in ProviderScope
class TestProviderOverrides {
  factory TestProviderOverrides.instance() => _singleton;
  TestProviderOverrides._();
  static final TestProviderOverrides _singleton = TestProviderOverrides._();

  List<dynamic> _overrides = [];

  // Get current overrides for use in ProviderScope
  List<dynamic> get overrides => List.unmodifiable(_overrides);

  // Set overrides for tests
  void setOverrides(List<dynamic> overrides) {
    _overrides = List.from(overrides);
  }

  // Add additional overrides
  void addOverrides(List<dynamic> overrides) {
    _overrides.addAll(overrides);
  }

  // Clear all overrides
  void clear() {
    _overrides.clear();
  }
}
