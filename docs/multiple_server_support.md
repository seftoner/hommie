# Multiple Server Support Implementation

## Overview
This implementation adds comprehensive multiple server support to the Hommie Home Assistant client, allowing users to manage multiple HA servers and switch between them seamlessly.

## Architecture

### Domain Layer
- **Server Model** (`/lib/features/server_manager/domain/models/server.dart`)
  - Represents a Home Assistant server configuration
  - Includes name, base URL, external URL, active status, and version info

- **Server Manager Interface** (`/lib/features/server_manager/domain/i_server_manager.dart`)
  - Defines operations for managing servers
  - Provides access to authentication and WebSocket repositories per server

### Infrastructure Layer
- **Isar Server Repository** (`/lib/features/server_manager/infrastructure/repositories/isar_server_repository.dart`)
  - Persists server configurations using Isar database
  - Manages active server state

- **Server Manager** (`/lib/features/server_manager/infrastructure/server_manager.dart`)
  - Implements the server management interface
  - Coordinates between repositories and providers

### Application Layer
- **Server Management Controller** (`/lib/features/server_management/application/server_management_controller.dart`)
  - Handles server connection testing
  - Manages server CRUD operations
  - Integrates with authentication flow

- **Active Server Provider** (`/lib/features/server_manager/infrastructure/providers/active_server_provider.dart`)
  - Provides reactive access to current active server
  - Manages server switching logic

### Presentation Layer
- **Servers Page** (`/lib/features/server_management/presentation/screens/servers_page.dart`)
  - Lists all configured servers
  - Shows active status and connection state
  - Provides actions: Add, Edit, Set Active, Delete

- **Add/Edit Server Page** (`/lib/features/server_management/presentation/screens/add_edit_server_page.dart`)
  - Form for adding/editing server configurations
  - Connection testing functionality
  - Integration with OAuth authentication flow

- **Server List Tile** (`/lib/features/server_management/presentation/widgets/server_list_tile.dart`)
  - Reusable widget for displaying server information
  - Shows status indicators and action menu

## Features Implemented

### ✅ Core Functionality
- [x] Multiple server storage and management
- [x] Active server switching
- [x] Server CRUD operations (Create, Read, Update, Delete)
- [x] Basic server connection testing
- [x] Integration with existing authentication system

### ✅ UI/UX
- [x] Settings → Servers navigation
- [x] Server list with status indicators
- [x] Add/Edit server forms with validation
- [x] Connection test with visual feedback
- [x] Active server indication
- [x] Confirmation dialogs for destructive actions
- [x] Protection against removing last server
- [x] Toast notifications for operations

### ✅ Data Management
- [x] Persistent server configurations
- [x] Active server state management
- [x] Reactive UI updates via Riverpod
- [x] Server-specific credential storage

## Integration Points

### Authentication System
- Uses existing `ServerAuthController` for OAuth flow
- Server-specific credential repositories via `credentialsRepositoryProvider(serverId)`
- Seamless integration with existing auth tasks

### WebSocket Connections
- Server-specific connections via `serverConnectionProvider(serverId)`
- Connection manager handles multiple simultaneous connections
- Proper cleanup when switching servers

### Database
- Extends existing Isar database with `ServerEntity`
- Uses existing database connection provider
- Server-specific data isolation

## Usage Instructions

### For Users
1. **Access Servers**: Settings → Servers
2. **Add Server**: Tap "+" → Fill form → Test connection → Save → Authenticate
3. **Switch Server**: Select server → "Set Active" (brief loading, then switch complete)
4. **Edit Server**: Tap server → Edit form → Save
5. **Remove Server**: Server menu → Delete (requires confirmation, prevents removing last server)

### For Developers
```dart
## Navigation

### Go Router Integration
The server management follows the app's go_router pattern:

```dart
// Navigation to servers page (from Settings)
const ServersRouteData().push(context)
```

**Route Structure:**
- `/settings/servers` - Server management page
- Sub-navigation to add/edit forms uses Navigator.push for modal-style presentation

**Route Definition:**
```dart
@TypedGoRoute<SettingsRouteData>(
  path: '/settings',
  routes: [
    // ... other routes
    TypedGoRoute<ServersRouteData>(path: 'servers'),
  ],
)
```
```

## Future Enhancements

### 🔄 Planned Improvements
- [ ] Real-time connection status monitoring
- [ ] Server health/ping indicators
- [ ] Automatic server discovery via mDNS
- [ ] Server-specific settings and preferences
- [ ] Backup/restore server configurations
- [ ] Server connectivity troubleshooting tools

### 🔧 Technical Debt
- [ ] Implement real HTTP connection testing (currently simulated)
- [ ] Add comprehensive error handling for edge cases
- [ ] Implement proper connection pooling
- [ ] Add server performance metrics
- [ ] Improve offline handling for inactive servers

### 🎨 UI/UX Enhancements
- [ ] Server icons/avatars
- [ ] Advanced server filtering and search
- [ ] Server usage statistics
- [ ] Quick server switching from main navigation
- [ ] Server-specific theming options

## Security Considerations

- ✅ Server-specific credential storage using `FlutterSecureStorage`
- ✅ OAuth token isolation between servers
- ✅ Proper credential cleanup on server removal
- ⚠️ TODO: Consider certificate pinning for production
- ⚠️ TODO: Implement proper token refresh coordination

## Testing

### Manual Testing Scenarios
1. **Basic Operations**: Add, edit, delete, switch servers
2. **Edge Cases**: Remove last server (should be prevented), invalid URLs
3. **Authentication**: OAuth flow for new servers, re-authentication
4. **Connection Testing**: Valid/invalid URLs, timeouts, network errors
5. **State Management**: App restart, background/foreground transitions

### Recommended Automated Tests
- Unit tests for server management controller
- Widget tests for server forms and validation
- Integration tests for server switching flow
- Database tests for server persistence

## Migration Notes

### Backward Compatibility
- Existing single-server installations are automatically migrated
- Current authentication tokens are preserved
- No breaking changes to existing APIs

### Database Schema
- New `ServerEntity` table added to Isar database
- Automatic migration handles existing installations
- Server-specific credential keys in secure storage

## Conclusion

This implementation provides a robust foundation for multiple server support while maintaining compatibility with existing functionality. The architecture is designed to be extensible and follows established patterns in the codebase.

The UI is intuitive and follows platform conventions, with clear visual feedback for all operations. The integration with existing authentication and connection management ensures a seamless user experience.

Future enhancements can build upon this foundation to provide even more advanced server management capabilities.
