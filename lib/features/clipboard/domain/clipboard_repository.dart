import 'package:mocosense/features/clipboard/domain/clipboard_result.dart';

abstract class ClipboardRepository {
  Future<ClipboardResult> checkClipboard();

  Future<void> clearClipboard();
}
