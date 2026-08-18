import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mocosense/features/clipboard/domain/clipboard_result.dart';
import 'package:mocosense/features/clipboard/presentation/widgets/clipboard_security_card.dart';

class ClipboardSection extends StatelessWidget {
  final AsyncValue<ClipboardResult?> clipboardState;
  final VoidCallback onCheck;
  final VoidCallback onClear;

  const ClipboardSection({
    super.key,
    required this.clipboardState,
    required this.onCheck,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return clipboardState.when(
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, stackTrace) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Clipboard Security',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Clipboard check failed:\n$error',
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: onCheck,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
      data: (result) {
        if (result == null) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Clipboard Security',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Check whether text is currently available '
                    'in the system clipboard without displaying '
                    'the clipboard content.',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: onCheck,
                      icon: const Icon(
                        Icons.content_paste_search,
                      ),
                      label: const Text('Check Clipboard'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ClipboardSecurityCard(
          result: result,
          onCheck: onCheck,
          onClear: onClear,
        );
      },
    );
  }
}