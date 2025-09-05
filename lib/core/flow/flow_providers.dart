import 'package:hommie/router/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'flow_definition.dart';
import 'flow_runner.dart';

part 'flow_providers.g.dart';

@riverpod
FlowRunner flowRunner(Ref ref) {
  final router = ref.read(goRouterProvider);
  return ref.watch(flowRunnerNotifierProvider(router).notifier);
}

@riverpod
FlowState flowState(Ref ref) {
  final router = ref.read(goRouterProvider);
  return ref.watch(flowRunnerNotifierProvider(router));
}
