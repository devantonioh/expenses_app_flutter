import 'package:expenses_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/providers/providers.dart';
import 'package:expenses_app/widgets/widgets.dart';

class FlayerBalance extends StatelessWidget {
  const FlayerBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;
    double totalExp = 0;
    double totalEt = 0;
    double total = 0.0;

    totalExp = getSumOfExP(eList);
    totalEt = getSumOfEntries(etList);
    total = totalEt - totalExp;

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text('Ingresos'),
                trailing: Text(
                  getAmountFormat(totalEt),
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text('Gastos'),
                trailing: Text(
                  getAmountFormat(totalExp),
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              const Divider(
                indent: 15,
                endIndent: 15,
                thickness: 2.0,
              ),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text('Balance'),
                trailing: Text(
                  getBalance(eList, etList),
                  style: TextStyle(
                    color: (total < 0) ? Colors.red : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 200.0,
            child: ChartBar(),
          ),
        )
      ],
    );
  }
}
