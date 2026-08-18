import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mocosense/features/clipboard/data/clipboard_repository_impl.dart';
import 'package:mocosense/features/clipboard/data/clipboard_service.dart';
import 'package:mocosense/features/clipboard/domain/clipboard_result.dart';

final clipboardRepositoryProvider = Provider<ClipboardRepositoryImpl>((ref) {
  return ClipboardRepositoryImpl(clipboardService: ClipboardService());
});

final clipboardProvider =
    AsyncNotifierProvider<ClipboardNotifier, ClipboardResult?>(
      ClipboardNotifier.new,
    );

class ClipboardNotifier extends AsyncNotifier<ClipboardResult?> {
  @override
  Future<ClipboardResult?> build() async {
    return null;
  }

  Future<void> checkClipboard() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(clipboardRepositoryProvider);

      return repository.checkClipboard();
    });
  }

  Future<void> clearClipboard() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(clipboardRepositoryProvider);

      await repository.clearClipboard();

      return const ClipboardResult(hasContent: false);
    });
  }
}
