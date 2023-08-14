import 'package:expenses_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({super.key});

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool _darkMode = false;
  final prefs = UserPrefs();

  @override
  void initState() {
    super.initState();
    _darkMode = prefs.darkMode;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _darkMode,
      title: const Text('Modo Oscuro', style: TextStyle(fontSize: 14.0)),
      subtitle: const Text('El modo oscuro ayuda ahorrar bateria'),
      onChanged: (bool value) {
        _darkMode = value;
        prefs.darkMode = value;
        context.read<ThemeProvider>().swapTheme();
        setState(() {});
      },
    );
  }
}
