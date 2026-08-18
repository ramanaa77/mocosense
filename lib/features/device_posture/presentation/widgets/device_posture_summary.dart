import 'package:flutter/material.dart';

import 'package:mocosense/core/models/security_check_result.dart';
import 'package:mocosense/core/theme/app_colors.dart';

class DevicePostureSummary extends StatelessWidget {
  final List<SecurityCheckResult> checks;

  const DevicePostureSummary({super.key, required this.checks});

  // int get passedCount =>
  //     checks.where((check) => check.status == SecurityStatus.pass).length;

  int get warningCount =>
      checks.where((check) => check.status == SecurityStatus.warning).length;

  int get criticalCount =>
      checks.where((check) => check.status == SecurityStatus.critical).length;

  int get infoCount =>
      checks.where((check) => check.status == SecurityStatus.info).length;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Device Posture',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Security signals analyzed',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _SummaryItem(
                  label: 'Warnings',
                  value: warningCount,
                  color: AppColors.warning,
                ),
                _SummaryItem(
                  label: 'Critical',
                  value: criticalCount,
                  color: AppColors.critical,
                ),
                _SummaryItem(
                  label: 'Info',
                  value: infoCount,
                  color: AppColors.info,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
