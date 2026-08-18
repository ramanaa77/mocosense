import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocosense/core/theme/app_theme.dart';
import 'package:mocosense/core/theme/theme_preference_service.dart';
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
  final ThemePreferenceService _themePreferenceService =
      ThemePreferenceService();

  ThemeMode _themeMode = ThemeMode.light;
  bool _isThemeLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = await _themePreferenceService.loadThemeMode();

    if (!mounted) return;

    setState(() {
      _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      _isThemeLoaded = true;
    });
  }

  void _changeTheme(ThemeMode mode) async {
    setState(() {
      _themeMode = mode;
    });

    await _themePreferenceService.saveThemeMode(
      mode == ThemeMode.dark ? 'dark' : 'light',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isThemeLoaded) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp(
      title: 'MocoSense',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,

      home: DevicePostureScreen(onThemeChanged: _changeTheme),
    );
  }
}
