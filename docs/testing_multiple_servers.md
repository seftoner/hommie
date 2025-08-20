# Testing Multiple Server Support

## Manual Testing Guide

### Prerequisites
1. Build and run the app: `flutter run`
2. Ensure you have access to one or more Home Assistant instances

### Testing Steps

#### 1. Basic Server Management
1. **Navigate to Servers**
   - Open app → Settings → Servers
   - Should show current server list (empty for new installs)

2. **Add New Server**
   - Tap "+" button
   - Fill in:
     - Name: "My Home"
     - Server URL: "http://homeassistant.local:8123" (or your HA URL)
     - External URL: (optional)
   - Tap "Test" button
   - Should show connection result (✅ success or ❌ error)
   - Tap "Add Server"

3. **Server Authentication**
   - After adding, authentication flow should start automatically
   - Follow OAuth flow to authenticate
   - Server should appear as active after authentication

#### 2. Multiple Servers
1. **Add Second Server**
   - Repeat add server process with different URL
   - Use test URLs for testing:
     - Valid: Any working HA instance
     - Invalid: "http://invalid.test"
     - Timeout: "http://timeout.test"

2. **Switch Between Servers**
   - Tap server menu (three dots)
   - Select "Set Active"
   - Should see loading toast → success toast
   - Active badge should move to new server

3. **Edit Server**
   - Tap server to edit
   - Modify name or URLs
   - Save changes
   - Verify changes are reflected

4. **Delete Server**
   - Only available if you have multiple servers
   - Tap server menu → "Delete"
   - Confirm deletion
   - Server should be removed from list

#### 3. Edge Cases
1. **Prevent Last Server Deletion**
   - Try to delete when only one server exists
   - Delete option should be disabled

2. **Invalid URLs**
   - Try adding server with invalid URL: "not-a-url"
   - Should show validation error

3. **Connection Testing**
   - Test with unreachable server
   - Should show error after timeout

#### 4. State Persistence
1. **App Restart**
   - Force close and restart app
   - Navigate to Settings → Servers
   - All servers should still be there
   - Active server should be maintained

2. **Background/Foreground**
   - Switch to background and return
   - Server state should be preserved

### Expected Behaviors

#### ✅ Success Cases
- Server list loads correctly
- Adding servers saves them persistently
- Connection test provides feedback
- Server switching updates active state
- Edit form pre-populates with existing data
- Delete removes server and updates UI
- Authentication flow works for new servers

#### ❌ Error Cases
- Invalid URLs show validation errors
- Connection failures show meaningful messages
- Cannot delete last remaining server
- Authentication failures are handled gracefully

### Test URLs for Development

Use these URLs to test different scenarios:

```
Valid test URLs:
- http://homeassistant.local:8123
- https://demo.home-assistant.io
- http://192.168.1.100:8123

Invalid test URLs (will fail):
- http://invalid.test
- not-a-url
- ftp://invalid.protocol
```

### Debugging Tips

1. **Check Logs**
   - Look for server management related logs
   - Authentication flow logs
   - Connection attempt logs

2. **Database State**
   - Servers are stored in Isar database
   - Credentials stored in FlutterSecureStorage
   - Each server has unique ID

3. **Provider State**
   - Use Flutter Inspector to check provider states
   - `activeServerProvider` should reflect current server
   - `serversListProvider` should show all servers

### Performance Testing

1. **Multiple Servers**
   - Add 5-10 servers
   - Test switching performance
   - Verify UI responsiveness

2. **Connection Tests**
   - Test multiple connections simultaneously
   - Check for memory leaks
   - Verify proper cleanup

### Integration Testing

The implementation integrates with:
- Existing authentication system
- WebSocket connection management
- Database persistence
- Secure credential storage

Test that switching servers properly:
- Updates WebSocket connections
- Maintains separate credentials
- Preserves server-specific data
- Handles authentication state correctly
