import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/pages/pages.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomePage(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    //final exProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final exProvider = context.read<ExpensesProvider>();
    final currentIndex = uiProvider.bnbIndex;

    final DateTime _date = DateTime.now();

    final currentMonth = uiProvider.selectedMonth + 1;

    switch (currentIndex) {
      case 0:
        exProvider.getEntriesBydate(currentMonth, _date.year);
        exProvider.getExpensesBydate(currentMonth, _date.year);
        exProvider.getAllFeatures();
        return const BalancePage();
      case 1:
        return const ChartsPage();
      case 2:
        return const SettingPage();
      default:
        return const BalancePage();
    }
  }
}
