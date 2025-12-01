import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_data_controller.g.dart';

/// Example controller that demonstrates server-specific data.
///
/// This controller automatically refreshes when the active server changes thanks to
/// the ProviderScope approach. No manual invalidation needed!
///
/// To add new server-dependent providers:
/// 1. Depend on serverScopeConnectionProvider and/or serverScopeIdProvider
/// 2. Add the dependencies annotation: @Riverpod(dependencies: [serverScopeConnection, serverScopeId])
/// 3. That's it! The provider will automatically update when servers switch
@Riverpod(dependencies: [serverScopeConnection, serverScopeId])
class HomeDataController extends _$HomeDataController {
  @override
  Future<Map<String, dynamic>> build() async {
    try {
      // Get the current server connection and ID
      await ref.watch(serverScopeConnectionProvider.future);
      final serverId = ref.watch(serverScopeIdProvider);

      // Simulate server-specific home data
      return _getHomeDataForServer(serverId);
    } catch (e) {
      // No active server - return default/empty state
      return {
        'server_name': 'No Server',
        'location': 'Not Connected',
        'temperature': '--°C',
        'entities_count': 0,
        'areas_count': 0,
        'color_theme': 'grey',
        'error': 'No active server configured',
      };
    }
  }

  Map<String, dynamic> _getHomeDataForServer(int serverId) {
    // This would normally come from Home Assistant API
    // For demonstration, return different data based on server ID
    switch (serverId % 3) {
      case 1:
        return {
          'server_name': 'Home Server',
          'location': 'Living Room',
          'temperature': '22°C',
          'entities_count': 45,
          'areas_count': 8,
          'color_theme': 'blue',
        };
      case 2:
        return {
          'server_name': 'Office Server',
          'location': 'Office Building',
          'temperature': '24°C',
          'entities_count': 32,
          'areas_count': 6,
          'color_theme': 'green',
        };
      default:
        return {
          'server_name': 'Demo Server',
          'location': 'Demo House',
          'temperature': '20°C',
          'entities_count': 28,
          'areas_count': 4,
          'color_theme': 'orange',
        };
    }
  }
}
