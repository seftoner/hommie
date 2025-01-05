import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<File> getLogsPath() async {
  final String dir = switch (Platform.operatingSystem) {
    'android' => (await getApplicationSupportDirectory()).path,
    'macos' => join((await getLibraryDirectory()).path, 'Logs'),
    'linux' => join(_getXdgStateHome(), 'hommie'),
    _ => (await getApplicationDocumentsDirectory()).path,
  };

  final file = File(join(dir, 'hommie_logs.log'));
  if (!await file.exists()) {
    await file.create(recursive: true);
  }
  return file;
}

String _getXdgStateHome() {
  if (const bool.hasEnvironment('XDG_STATE_HOME')) {
    final String xdgStateHomeRaw = Platform.environment['XDG_STATE_HOME'] ?? '';
    if (xdgStateHomeRaw.isNotEmpty) {
      return xdgStateHomeRaw;
    }
  }
  return join(Platform.environment['HOME'] ?? '', '.local', 'state');
}
