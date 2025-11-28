import 'package:flutter/material.dart';
import 'package:hommie/features/mobile_companion/application/sensors_controller.dart';
import 'package:hommie/features/mobile_companion/sensors/sensor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class SensorsPage extends ConsumerWidget {
  const SensorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensorsState = ref.watch(sensorsControllerProvider);
    final notifier = ref.read(sensorsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensors'),
        actions: [
          IconButton(
            icon: const Icon(Symbols.refresh_rounded),
            onPressed: sensorsState.isLoading ? null : notifier.refresh,
          ),
        ],
      ),
      body: SafeArea(
        child: sensorsState.when(
          data: (sensors) => _SensorsList(sensors: sensors),
          error: (error, _) => _SensorsError(
            message: error.toString(),
            onRetry: notifier.refresh,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class _SensorsList extends StatelessWidget {
  const _SensorsList({required this.sensors});

  final List<Sensor> sensors;

  @override
  Widget build(BuildContext context) {
    if (sensors.isEmpty) {
      return const Center(
        child: Text('No sensors registered on this device yet.'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final sensor = sensors[index];
        final sensorValue = sensor.state?.toString() ?? 'Unknown';
        final subtitle = _formatAttributes(sensor.attributes);
        return ListTile(
          title: Text(sensor.name),
          subtitle: subtitle,
          trailing: Text(sensorValue),
        );
      },
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemCount: sensors.length,
    );
  }

  Widget? _formatAttributes(Map<String, dynamic>? attributes) {
    if (attributes == null || attributes.isEmpty) {
      return null;
    }
    final text = attributes.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join('\n');
    return Text(text);
  }
}

class _SensorsError extends StatelessWidget {
  const _SensorsError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Failed to load sensors',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
    );
  }
}
