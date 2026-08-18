import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mocosense/features/clipboard/presentation/providers/clipboard_provider.dart';
import 'package:mocosense/features/device_posture/presentation/providers/device_posture_provider.dart';
import 'package:mocosense/features/device_posture/presentation/widgets/clipboard_section.dart';
import 'package:mocosense/features/device_posture/presentation/widgets/device_posture_empty.dart';
import 'package:mocosense/features/device_posture/presentation/widgets/device_posture_summary.dart';
import 'package:mocosense/features/device_posture/presentation/widgets/security_check_card.dart';

class DevicePostureScreen extends ConsumerWidget {
  final void Function(ThemeMode mode) onThemeChanged;

  const DevicePostureScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auditState = ref.watch(devicePostureProvider);
    final clipboardState = ref.watch(clipboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MocoSense'),
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: const Icon(Icons.palette_outlined),
            onSelected: onThemeChanged,
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: ThemeMode.light,
                child: Row(
                  children: [
                    Icon(Icons.light_mode_outlined),
                    SizedBox(width: 12),
                    Text('Light'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Row(
                  children: [
                    Icon(Icons.dark_mode_outlined),
                    SizedBox(width: 12),
                    Text('Dark'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              auditState.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stackTrace) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Device Posture',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Security audit failed:\n$error',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () {
                            ref.read(devicePostureProvider.notifier).runAudit();
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                ),
                data: (result) {
                  if (result.checks.isEmpty) {
                    return DevicePostureEmpty(
                      onRunAudit: () {
                        ref.read(devicePostureProvider.notifier).runAudit();
                      },
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Device Posture',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Observable security signals from this device.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 24),

                      DevicePostureSummary(checks: result.checks),
                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ref.read(devicePostureProvider.notifier).runAudit();
                          },
                          label: const Text('Run Security Audit Again'),
                          icon: const Icon(Icons.refresh),
                        ),
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'Device Checks',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      ...result.checks.map(
                        (check) => SecurityCheckCard(check: check),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'App Protection',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),
              ClipboardSection(
                clipboardState: clipboardState,
                onCheck: () {
                  ref.read(clipboardProvider.notifier).checkClipboard();
                },
                onClear: () {
                  ref.read(clipboardProvider.notifier).clearClipboard();
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
