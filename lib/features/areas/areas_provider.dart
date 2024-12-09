import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/services/networking/server_connection_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/areas/infrastructure/repositories/areas_repository.dart';

part 'areas_provider.g.dart';

@Riverpod(dependencies: [serverConnection])
Future<AreasRepository> areasRepository(Ref ref) async {
  final connection = await ref.watch(serverConnectionProvider.future);
  return AreasRepository(connection);
}
