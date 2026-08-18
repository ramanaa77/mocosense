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

  const DevicePostureScreen({
    super.key,
    required this.onThemeChanged,
  });

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
        child: auditState.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              'Security audit failed:\n$error',
              textAlign: TextAlign.center,
            ),
          ),
          data: (result) {
            if (result.checks.isEmpty) {
              return DevicePostureEmpty(
                onRunAudit: () {
                  ref
                      .read(devicePostureProvider.notifier)
                      .runAudit();
                },
              );
            }

            return SingleChildScrollView(
              child: Column(
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
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),

                  DevicePostureSummary(
                    checks: result.checks,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Device Checks',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ...result.checks.map(
                    (check) => SecurityCheckCard(
                      check: check,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ClipboardSection(
                    clipboardState: clipboardState,
                    onCheck: () {
                      ref
                          .read(clipboardProvider.notifier)
                          .checkClipboard();
                    },
                    onClear: () {
                      ref
                          .read(clipboardProvider.notifier)
                          .clearClipboard();
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}