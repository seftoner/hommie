import 'package:hommie/router/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'flow_definition.dart';
import 'flow_runner.dart';

part 'flow_providers.g.dart';

@Riverpod(keepAlive: true)
FlowRunner flowRunner(Ref ref) {
  final router = ref.read(goRouterProvider);
  return ref.watch(flowRunnerNotifierProvider(router).notifier);
}

@Riverpod(keepAlive: true)
FlowState flowState(Ref ref) {
  final router = ref.read(goRouterProvider);
  return ref.watch(flowRunnerNotifierProvider(router));
}
