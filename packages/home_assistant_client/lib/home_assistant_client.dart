/// Home Assistant API client library.
///
/// Provides typed and raw interfaces for Home Assistant REST and WebSocket APIs.
library home_assistant_client;

export 'src/api/home_assistant_api.dart';
export 'src/api/ha_api_exceptions.dart';
export 'src/api/transports/ha_rest_transport.dart';
export 'src/api/transports/ha_websocket_transport.dart';
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
export 'src/protocol/types/ha_subscription.dart';
export 'src/protocol/types/hass_types.dart';
