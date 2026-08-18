import 'package:flutter/material.dart';
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
            const SizedBox(width: 10),
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
      ),
    );
  }
}
