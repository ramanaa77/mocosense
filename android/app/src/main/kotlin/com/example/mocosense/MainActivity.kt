package com.example.mocosense

import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val clipboardChannel = "mocosense/clipboard"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            clipboardChannel
        ).setMethodCallHandler { call, result ->

            when (call.method) {
                "clearClipboard" -> {
                    val clipboardManager =
                        getSystemService(Context.CLIPBOARD_SERVICE)
                            as ClipboardManager

                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                        clipboardManager.clearPrimaryClip()
                    } else {
                        clipboardManager.setPrimaryClip(
                            ClipData.newPlainText("", "")
                        )
                    }

                    result.success(null)
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}