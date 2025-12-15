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

### DDD requirement (main app)
- The main app must follow **DDD / layered (clean) architecture** per feature:
  `domain/` → `application/` → `infrastructure/` → `presentation/`.
- Dependency direction must flow **inward**:
  - `presentation` may depend on `application` and `domain`
  - `application` may depend on `domain`
  - `infrastructure` may depend on `domain` (implements domain interfaces) and may be wired via providers
  - `domain` depends on **nothing** (no Flutter, no Riverpod, no platform code)
- Avoid cross-layer leaks:
  - No `presentation` imports in `domain`/`application`
  - No `BuildContext`/widgets in `domain`/`application`
  - Repositories are defined in `domain` (`I...Repository`) and implemented in `infrastructure`

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
