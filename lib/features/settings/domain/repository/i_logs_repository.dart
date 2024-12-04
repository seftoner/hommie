import 'package:hommie/features/settings/domain/entities/logs.dart';

abstract class ILogsRepository {
  Future<List<Log>> fetchLogs(int offset, int limit);
}
