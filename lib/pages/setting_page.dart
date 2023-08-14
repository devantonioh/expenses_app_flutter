import 'package:expenses_app/widgets/setting_page_wt/dark_mode_switch.dart';
import 'package:expenses_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracion '),
      ),
      body: ListView(
        children: const [
          DarkModeSwitch(),
          Divider(thickness: 2),
          TimePicker(),
          Divider(thickness: 2),
        ],
      ),
    );
  }
}
