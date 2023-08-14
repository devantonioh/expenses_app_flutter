import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/providers/providers.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    //final uiProvider = Provider.of<UIProvider>(context);

    final watchIndex = context.watch<UIProvider>();
    final read = context.read<UIProvider>();

    return BottomNavigationBar(
        // currentIndex: uiProvider.bnbIndex,
        // onTap: (int i) => uiProvider.bnbIndex = i,
        currentIndex: watchIndex.bnbIndex,
        onTap: (value) => read.bnbIndex = value,
        elevation: 0.0,
        items: const [
          BottomNavigationBarItem(
              label: 'Balance', icon: Icon(Icons.account_balance_outlined)),
          BottomNavigationBarItem(
              label: 'Gráficos', icon: Icon(Icons.bar_chart_outlined)),
          BottomNavigationBarItem(
              label: 'Configuracion', icon: Icon(Icons.settings)),
        ]);
  }
}
