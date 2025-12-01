## Project Overview

Hommie is a Flutter (Dart 3.6+) multi‑platform client for Home Assistant focusing on fast, offline‑aware control and a polished UX. Targets iOS, Android, macOS; communicates via Home Assistant WebSocket API + REST.

## Tech Stack
- Flutter SDK ~3.27, Dart >=3.6
- State: Riverpod (codegen), hooks_riverpod, freezed, json_serializable
- Navigation: go_router
- Data: Isar (primary cache), shared_preferences, flutter_secure_storage
- Testing: flutter_test, mockito, patrol, bdd_widget_test

## MCP Workflows
Use natural language prompts for development tasks:
- "Find and fix layout overflow errors in the running app"
- "Add a chart package for time-series data"
- "Run tests and explain failures"
- "Format code according to project standards"

## Architecture Patterns

### Domain Layer
- **Entities:** `@freezed` classes with `@JsonSerializable(fieldRename: FieldRename.snake)`
- **Repositories:** Abstract interface classes with `I` prefix. Can throw domain-specific exceptions
- **Value Objects:** Validation classes for primitives (ServerName, EmailAddress)

### Infrastructure Layer
- **Repositories:** Implement domain interfaces. Convert platform exceptions to domain failures
- **Providers:** Each feature must have `providers.dart` facade

### Application Layer
- **Controllers:** One per operation (CreateServerController, EditServerController)
- **State:** Use `AsyncValue<T>` directly. Handle exceptions with try/catch → `AsyncError`
- **Dependencies:** Use `@Riverpod(dependencies: [...])`

### Presentation Layer
- **AsyncValue:** Use sealed pattern matching with `switch` statements
- **Forms:** Use value objects for validation
- **State:** Use `.select()` to minimize rebuilds

## Code Examples

**Domain Entity:**
```dart
@freezed
class ServerEntity with _$ServerEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ServerEntity({
    @JsonKey(includeIfNull: false) String? id,
    required String name,
    required String url,
  }) = _ServerEntity;
  
  factory ServerEntity.fromJson(Map<String, dynamic> json) => 
    _$ServerEntityFromJson(json);
}
```

**Repository Interface:**
```dart
abstract interface class IServerRepository {
  Future<List<ServerEntity>> getServers();
  Future<ServerEntity> createServer(ServerUrl url, ServerName name);
  Future<void> deleteServer(String id);
}
```

**Controller:**
```dart
@Riverpod(dependencies: [serverRepository])
class CreateServerController extends _$CreateServerController {
  @override
  Future<ServerEntity?> build() async => null;
  
  Future<void> createServer(ServerUrl url, ServerName name) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(serverRepositoryProvider);
      final server = await repo.createServer(url, name);
      state = AsyncData(server);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
```

**UI Pattern:**
```dart
Widget build(BuildContext context, WidgetRef ref) {
  final createState = ref.watch(createServerControllerProvider);
  
  return switch (createState) {
    AsyncData(:final value) => value != null 
      ? Text('Server created: ${value.name}')
      : const SizedBox.shrink(),
    AsyncError(:final error) => Text('Error: $error'),
    AsyncLoading() => const CircularProgressIndicator(),
  };
}
```

## Feature Development
1. Create feature folder: domain/application/infrastructure/presentation
2. **Domain:** Define entities (freezed), value objects, repository interfaces
3. **Infrastructure:** Implement repositories, create `providers.dart` facade
4. **Application:** Create operation-specific controllers using `AsyncValue<T>`
5. **Presentation:** Use sealed `AsyncValue` pattern matching

## Key Rules
- **Security:** Never log tokens/PII. Use `flutter_secure_storage` for tokens
- **State:** Keep immutable, use freezed data classes
- **Providers:** Co-locate in features, use codegen `@riverpod`
- **Testing:** Write tests early, handle all AsyncValue states
- **Commands:** `flutter pub get` → `dart run build_runner build` → `flutter analyze` → `flutter test`

🔑 **Focus for Copilot:** Follow architecture + code patterns above.  
Other details (CI, Docker, patrol, full workflows) — see `/docs`.
