import 'package:flutter/services.dart';

class ClipboardService {
  static const MethodChannel _channel = MethodChannel('mocosense/clipboard');

  Future<bool> hasText() async {
    return Clipboard.hasStrings();
  }

  Future<void> clear() async {
    await _channel.invokeMethod<void>('clearClipboard');
  }
}
