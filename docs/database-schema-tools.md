# Database Schema Tools

This guide covers useful Drift CLI commands for managing and inspecting your database schema.

## Prerequisites

Ensure `drift_dev` is in your `dev_dependencies` in `pubspec.yaml`:

```yaml
dev_dependencies:
  drift_dev: ^2.29.0
```

All commands should be run from the project root (where `pubspec.yaml` is located).

---

## Schema Export

Export all SQL `CREATE` statements that define your database schema.

### Basic Usage

```bash
dart run drift_dev schema export lib/core/database/database.dart
```

This outputs all SQL statements that would be executed when creating the database from scratch, each on its own line.

### Export to File

```bash
dart run drift_dev schema export lib/core/database/database.dart > schema.sql
```

---

## Schema Dump (Version Control)

Export detailed schema information to JSON for version control and migration testing.

```bash
dart run drift_dev schema dump lib/core/database/database.dart drift_schemas/schema_v1.json
```

The generated JSON contains:
- **Tables** with detailed column information
- **Triggers**
- **Indices**
- **`@create` queries** from `.drift` files
- **Dependencies** between schema entities

### Use Cases

1. **Migration Testing**: Generate test code for schema migrations
2. **Schema Versioning**: Track database changes over time
3. **Documentation**: Human-readable schema snapshots

See [Drift Migration Testing](https://drift.simonbinder.eu/migrations/tests) for details.

---

## Analyze

Run Drift's analyzer and linter across all `.drift` files in your project.

```bash
dart run drift_dev analyze
```

---

## Recommended Workflow

### 1. Development

```bash
# Watch mode for code generation during development
dart run build_runner watch --delete-conflicting-outputs
```

### 2. Before Committing

```bash
# Check for schema issues
dart run drift_dev analyze

# Export current schema for documentation
dart run drift_dev schema export lib/core/database/database.dart > docs/schema.sql

# Optional: Dump schema for version control
dart run drift_dev schema dump lib/core/database/database.dart drift_schemas/schema_v$(cat pubspec.yaml | grep version: | awk '{print $2}').json
```

### 3. Schema Changes

When modifying tables:

1. Update `tables.dart` or `.drift` files
2. Run `dart run build_runner build --delete-conflicting-outputs`
3. Export new schema: `dart run drift_dev schema export lib/core/database/database.dart`
4. Increment `schemaVersion` in `database.dart`
5. Add migration logic if needed

