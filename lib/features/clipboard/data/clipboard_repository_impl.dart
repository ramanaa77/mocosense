import 'package:mocosense/features/clipboard/data/clipboard_service.dart';
import 'package:mocosense/features/clipboard/domain/clipboard_repository.dart';
import 'package:mocosense/features/clipboard/domain/clipboard_result.dart';

class ClipboardRepositoryImpl implements ClipboardRepository {
  final ClipboardService clipboardService;

  ClipboardRepositoryImpl({required this.clipboardService});

  @override
  Future<ClipboardResult> checkClipboard() async {
    final hasContent = await clipboardService.hasText();

    return ClipboardResult(hasContent: hasContent);
  }

  @override
  Future<void> clearClipboard() async {
    await clipboardService.clear();
  }
}
