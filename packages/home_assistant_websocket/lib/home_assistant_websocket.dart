/// Home Assistant WebSocket API client library.
///
/// Provides a simple interface to connect and communicate with
/// Home Assistant via WebSocket protocol.
library home_assistant_websocket;

export 'src/api/commands/ha_commands.dart';
export 'src/auth/ha_auth_token.dart';
export 'src/connection/connection_orchestrator.dart';
export 'src/connection/ha_connection.dart';
export 'src/connection/ha_connection_option.dart';
export 'src/connection/ha_socket.dart';
export 'src/connection/ha_socket_state.dart';
export 'src/logging/logger_interface.dart';
export 'src/protocol/messages/ha_messages.dart';
export 'src/protocol/types/ha_response.dart';
export 'src/protocol/types/hass_event.dart';
export 'src/protocol/types/hass_service.dart';
export 'src/protocol/types/hass_subscription.dart';
export 'src/protocol/types/hass_types.dart';
