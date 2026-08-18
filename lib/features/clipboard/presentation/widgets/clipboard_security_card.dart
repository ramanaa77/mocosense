import 'package:flutter/material.dart';

import 'package:mocosense/core/theme/app_colors.dart';
import 'package:mocosense/features/clipboard/domain/clipboard_result.dart';

class ClipboardSecurityCard extends StatelessWidget {
  final ClipboardResult result;
  final VoidCallback onCheck;
  final VoidCallback onClear;

  const ClipboardSecurityCard({
    super.key,
    required this.result,
    required this.onCheck,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final statusColor = result.hasContent
        ? AppColors.warning
        : AppColors.success;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  result.hasContent
                      ? Icons.content_paste
                      : Icons.content_paste_off,
                  color: statusColor,
                  size: 28,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Clipboard Security',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              result.hasContent
                  ? 'Clipboard text detected'
                  : 'Clipboard appears empty',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 6),

            Text(
              result.hasContent
                  ? 'Text data is currently available in the system clipboard.'
                  : 'No text data was detected in the system clipboard.',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),

            if (result.hasContent) ...[
              const SizedBox(height: 12),

              Text(
                'Sensitive information such as passwords or codes '
                'should not remain in the clipboard longer than necessary.',
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onClear,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Clear Clipboard'),
                ),
              ),
            ],

            if (!result.hasContent) ...[
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onCheck,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Check Again'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
