import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/settings/infrastructure/tasks/fetch_logs_task.dart';

void main() {
  test("Test FetchLogsTask logs parsing", () async {
    final fetchTask =
        FetchLogsTask(FetchLogsParams(0, 100, "test/data_samples/logs.log"));
    final result = await fetchTask.run();

    expect(result, isNotEmpty);
    expect(result.first.msg, equals("First message"));
    expect(result.last.msg, equals("Last message"));
  });

  test("FetchLogsTask respects offset and limit parameters", () async {
    const offset = 1;
    const limit = 3;

    final fetchTask = FetchLogsTask(
      FetchLogsParams(
        offset,
        limit,
        "test/data_samples/logs.log",
      ),
    );

    final result = await fetchTask.run();

    expect(result, isNotEmpty, reason: "The result should not be empty.");
    expect(result.length, equals(limit),
        reason: "The number of fetched logs should match the limit.");
    expect(result.first.msg, equals("Start the application 🚀"),
        reason: "The first log should match the expected offset.");
    expect(result.last.msg, equals("Access token is expired"),
        reason: "The last log should match the expected offset and limit.");
  });
}
