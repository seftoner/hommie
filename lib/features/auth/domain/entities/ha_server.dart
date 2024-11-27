import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hommie/features/auth/domain/entities/ha_version.dart';

part 'ha_server.freezed.dart';

@freezed
class HaServer with _$HaServer {
  factory HaServer({
    String? uuid,
    required String name,
    required Uri uri,
    required HaVersion version,
    Uri? internalUrl,
    Uri? externalUrl,
  }) = _HaServer;
}
