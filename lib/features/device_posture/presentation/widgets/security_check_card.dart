import 'package:flutter/material.dart';
import 'package:mocosense/core/models/security_check_info.dart';
import 'package:mocosense/core/models/security_check_result.dart';
import 'package:mocosense/core/theme/app_colors.dart';

class SecurityCheckCard extends StatelessWidget {
  final SecurityCheckResult check;

  const SecurityCheckCard({super.key, required this.check});

  IconData get _statusIcon {
    switch (check.status) {
      case SecurityStatus.pass:
        return Icons.check_circle_outline;
      case SecurityStatus.warning:
        return Icons.warning_amber_rounded;
      case SecurityStatus.critical:
        return Icons.error_outline;
      case SecurityStatus.info:
        return Icons.info_outline;
      case SecurityStatus.unavailable:
        return Icons.help_outline;
    }
  }

  Color _statusColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (check.status) {
      case SecurityStatus.pass:
        return AppColors.success;
      case SecurityStatus.warning:
        return AppColors.warning;
      case SecurityStatus.critical:
        return AppColors.critical;
      case SecurityStatus.info:
        return AppColors.info;
      case SecurityStatus.unavailable:
        return colorScheme.onSurfaceVariant;
    }
  }

  void _showInformation(BuildContext context) {
    final info = SecurityCheckInfoProvider.get(check.id);

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _InfoSection(
                    title: 'What does it check?',
                    text: info.whatItChecks,
                  ),
                  _InfoSection(
                    title: 'Why does it matter?',
                    text: info.whyItMatters,
                  ),
                  _InfoSection(
                    title: 'What does this result mean?',
                    text: info.whatResultMeans,
                  ),
                  _InfoSection(
                    title: 'MocoSense limitation',
                    text: info.limitation,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(_statusIcon, color: statusColor, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    check.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    check.description,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _showInformation(context),
                  icon: const Icon(Icons.info_outline),
                  tooltip: 'About this check',
                ),

                Text(
                  check.status.name.toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final String text;

  const _InfoSection({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: TextStyle(
              height: 1.45,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
