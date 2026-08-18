// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mocosense/features/clipboard/presentation/providers/clipboard_provider.dart';
// import 'package:mocosense/features/clipboard/presentation/widgets/clipboard_security_card.dart';

// class ClipboardScreen extends ConsumerWidget {
//   const ClipboardScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final clipboardState = ref.watch(clipboardProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Clipboard Security')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: clipboardState.when(
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (error, stackTrace) => Center(
//             child: Text(
//               'Clipboard check failed:\n$error',
//               textAlign: TextAlign.center,
//             ),
//           ),
//           data: (result) {
//             if (result == null) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Clipboard Security',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Check and clear text currently stored in the system clipboard.',
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   Center(
//                     child: FilledButton.icon(
//                       onPressed: () {
//                         ref.read(clipboardProvider.notifier).checkClipboard();
//                       },
//                       icon: const Icon(Icons.security),
//                       label: const Text('Check Clipboard'),
//                     ),
//                   ),
//                 ],
//               );
//             }

//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Clipboard Security',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Check and clear text currently stored in the system clipboard.',
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   ClipboardSecurityCard(
//                     result: result,
//                     onClear: () {
//                       ref.read(clipboardProvider.notifier).clearClipboard();
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
