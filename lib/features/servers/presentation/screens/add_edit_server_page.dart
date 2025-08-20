import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hommie/features/servers/application/server_management_controller.dart';
import 'package:hommie/features/servers/domain/models/server.dart';

class AddEditServerPage extends HookConsumerWidget {
  final Server? server;

  const AddEditServerPage({
    super.key,
    this.server,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = server != null;
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(
      text: isEditing ? server!.name : '',
    );
    final urlController = useTextEditingController(
      text: isEditing ? (server!.baseUrl ?? '') : '',
    );
    final externalUrlController = useTextEditingController(
      text: isEditing ? (server!.externalUrl ?? '') : '',
    );
    final testResult = ref.watch(serverManagementControllerProvider);

    bool canSave() {
      return nameController.text.trim().isNotEmpty &&
          urlController.text.trim().isNotEmpty;
    }

    Future<void> testConnection() async {
      if (urlController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a server URL first')),
        );
        return;
      }

      ref.read(serverManagementControllerProvider.notifier).testConnection(
            url: urlController.text.trim(),
          );
    }

    Future<void> saveServer() async {
      if (!formKey.currentState!.validate()) {
        return;
      }

      try {
        final controller =
            ref.read(serverManagementControllerProvider.notifier);
        Server? savedServer;

        if (isEditing) {
          savedServer = await controller.updateServer(
            serverId: server!.id!,
            name: nameController.text.trim(),
            url: urlController.text.trim(),
            externalUrl: externalUrlController.text.trim().isEmpty
                ? null
                : externalUrlController.text.trim(),
          );
        } else {
          savedServer = await controller.addServer(
            name: nameController.text.trim(),
            url: urlController.text.trim(),
            externalUrl: externalUrlController.text.trim().isEmpty
                ? null
                : externalUrlController.text.trim(),
          );
        }

        if (context.mounted && savedServer != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isEditing
                  ? 'Server updated successfully'
                  : 'Server added successfully'),
            ),
          );

          // If this is a new server, initiate authentication
          if (!isEditing) {
            await startAuthentication(savedServer, ref, context);
          }

          if (context.mounted) {
            Navigator.of(context).pop(savedServer);
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Server' : 'Add Server'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildNameField(nameController),
            const SizedBox(height: 16),
            _buildUrlField(urlController),
            const SizedBox(height: 16),
            _buildExternalUrlField(externalUrlController),
            const SizedBox(height: 24),
            _buildTestConnectionSection(testResult, testConnection, context),
            const SizedBox(height: 24),
            if (!isEditing) ...[
              _buildAuthenticationSection(),
              const SizedBox(height: 24),
            ],
            _buildSaveButton(canSave, saveServer),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField(TextEditingController nameController) {
    return TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        labelText: 'Server Name *',
        hintText: 'My Home Assistant',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Server name is required';
        }
        return null;
      },
    );
  }

  Widget _buildUrlField(TextEditingController urlController) {
    return TextFormField(
      controller: urlController,
      decoration: const InputDecoration(
        labelText: 'Server URL *',
        hintText: 'http://homeassistant.local:8123',
        border: OutlineInputBorder(),
        helperText: 'The internal URL of your Home Assistant server',
      ),
      keyboardType: TextInputType.url,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Server URL is required';
        }

        try {
          final uri = Uri.parse(value.trim());
          if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
            return 'Please enter a valid HTTP or HTTPS URL';
          }
        } catch (e) {
          return 'Please enter a valid URL';
        }

        return null;
      },
    );
  }

  Widget _buildExternalUrlField(TextEditingController externalUrlController) {
    return TextFormField(
      controller: externalUrlController,
      decoration: const InputDecoration(
        labelText: 'External URL (Optional)',
        hintText: 'https://my-ha.duckdns.org',
        border: OutlineInputBorder(),
        helperText: 'URL for accessing your server from outside your network',
      ),
      keyboardType: TextInputType.url,
      validator: (value) {
        if (value != null && value.trim().isNotEmpty) {
          try {
            final uri = Uri.parse(value.trim());
            if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
              return 'Please enter a valid HTTP or HTTPS URL';
            }
          } catch (e) {
            return 'Please enter a valid URL';
          }
        }
        return null;
      },
    );
  }

  Widget _buildTestConnectionSection(ServerTestResult testResult,
      VoidCallback testConnection, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.wifi_find),
                const SizedBox(width: 8),
                const Text(
                  'Test Connection',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                _buildTestButton(testResult, testConnection),
              ],
            ),
            const SizedBox(height: 12),
            _buildTestResult(testResult, context),
          ],
        ),
      ),
    );
  }

  Widget _buildTestButton(
      ServerTestResult testResult, VoidCallback testConnection) {
    return FilledButton.tonal(
      onPressed:
          testResult.status == ServerTestStatus.testing ? null : testConnection,
      child: testResult.status == ServerTestStatus.testing
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('Test'),
    );
  }

  Widget _buildTestResult(ServerTestResult testResult, BuildContext context) {
    switch (testResult.status) {
      case ServerTestStatus.idle:
        return const Text(
          'Test the connection to verify your server is accessible.',
          style: TextStyle(color: Colors.grey),
        );

      case ServerTestStatus.testing:
        return const Text('Testing connection...');

      case ServerTestStatus.success:
        return Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '✅ Connection successful!',
                    style: TextStyle(color: Colors.green),
                  ),
                  if (testResult.version != null)
                    Text(
                      'Home Assistant ${testResult.version}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ),
          ],
        );

      case ServerTestStatus.error:
        return Row(
          children: [
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '❌ ${testResult.message}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
    }
  }

  Widget _buildAuthenticationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.security),
                SizedBox(width: 8),
                Text(
                  'Authentication',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'After saving the server, you\'ll need to authenticate using your Home Assistant credentials.',
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: null, // Will be enabled after server is saved
              icon: const Icon(Icons.login),
              label: const Text('Setup Authentication'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(bool Function() canSave, VoidCallback saveServer) {
    return FilledButton(
      onPressed: canSave() ? saveServer : null,
      child: Text(server != null ? 'Update Server' : 'Add Server'),
    );
  }
}

Future<void> startAuthentication(
    Server server, WidgetRef ref, BuildContext context) async {
  try {
    final controller = ref.read(serverManagementControllerProvider.notifier);
    await controller.authenticateServer(server.id!, server.url);
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed: $e')),
      );
    }
  }
}
