import 'package:freezed_annotation/freezed_annotation.dart';

part 'ha_server.freezed.dart';

@freezed
class HaServer with _$HaServer {
  factory HaServer({
    required String name,
    required Uri uri,
  }) = _HaServer;
}
