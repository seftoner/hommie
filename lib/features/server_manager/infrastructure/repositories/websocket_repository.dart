import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_websocket_repository.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/types/hass_types.dart';

class WebSocketRepository implements IWebSocketRepository {
  final int _serverId;
  final IAuthRepository _authRepository;

  WebSocketRepository(this._serverId, this._authRepository);


  @override
  Future<void> connect() {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  // TODO: implement connectionState
  Stream<HAServerConnectionState> get connectionState =>
      throw UnimplementedError();

  @override
  Future<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Future<List<Area>> getAreas() {
    // TODO: implement getAreas
    throw UnimplementedError();
  }

  @override
  Future<List<Device>> getDevices() {
    // TODO: implement getDevices
    throw UnimplementedError();
  }

  @override
  Future<bool> sendPing() {
    // TODO: implement sendPing
    throw UnimplementedError();
  }

  @override
  Future<HassConfig> getConfig() {
    // TODO: implement getConfig
    throw UnimplementedError();
  }
}
