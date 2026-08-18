import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocosense/core/theme/app_theme.dart';
// import 'package:mocosense/features/clipboard/presentation/screens/clipboard_screen.dart';
import 'package:mocosense/features/device_posture/presentation/screens/device_posture_screen.dart';

void main() {
  runApp(const ProviderScope(child: MocoSenseApp()));
}

class MocoSenseApp extends StatefulWidget {
  const MocoSenseApp({super.key});

  @override
  State<MocoSenseApp> createState() => _MocoSenseAppState();
}

class _MocoSenseAppState extends State<MocoSenseApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _changeTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MocoSense',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,

      home: DevicePostureScreen(onThemeChanged: _changeTheme),
      // home: ClipboardScreen(),
    );
  }
}
