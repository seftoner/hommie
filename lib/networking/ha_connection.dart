import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ha_connection.g.dart';

@Riverpod(keepAlive: true)
class HAConnection extends _$HAConnection {
  @override
  Stream<List<String>> build() {
    return Stream.value([]);
  }
}
