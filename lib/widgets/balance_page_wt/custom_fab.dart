//floating action bottom
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:expenses_app/pages/pages.dart';
import 'package:expenses_app/utils/utils.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    List<SpeedDialChild> childButtons = [];

    childButtons.add(SpeedDialChild(
      backgroundColor: Colors.red,
      child: const Icon(Icons.remove),
      label: 'Gasto',
      labelStyle: const TextStyle(fontSize: 18.0),
      onTap: () {
        Navigator.push(
            context,
            PageAnimationRoutes(
                widget: const AddExpensesPage(), ejeX: 0.8, ejeY: 0.8));
      },
    ));

    childButtons.add(SpeedDialChild(
      backgroundColor: Colors.green,
      child: const Icon(Icons.add),
      label: 'Ingreso',
      labelStyle: const TextStyle(fontSize: 18.0),
      onTap: () {
        Navigator.push(
            context,
            PageAnimationRoutes(
                widget: const AddEntriesPage(), ejeX: 0.8, ejeY: 0.8));
      },
    ));

    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      children: childButtons,
      spacing: 10.0,
      childMargin: const EdgeInsets.symmetric(horizontal: 6.0),
      childrenButtonSize: const Size(60.0, 60.0),
    );
  }
}
