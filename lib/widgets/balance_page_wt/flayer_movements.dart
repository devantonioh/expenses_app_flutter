import 'package:expenses_app/providers/providers.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:expenses_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class FlayerMovements extends StatelessWidget {
  const FlayerMovements({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;
    double _totalExp = 0;
    double _totalEt = 0;

    _totalExp = getSumOfExP(eList);
    _totalEt = getSumOfEntries(etList);

    return SizedBox(
      height: 200.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: PercentCircular(
                percent: _totalExp / _totalEt,
                radius: 70.0,
                color: Colors.green,
                arcType: ArcType.FULL,
              )),
          Expanded(
              flex: 1,
              child: SizedBox(
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gastos Realizados',
                      style: TextStyle(fontSize: 16.0, letterSpacing: 1.3),
                    ),
                    Text(
                      getAmountFormat(_totalExp),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.3,
                      ),
                    ),
                    Text(
                      'Absorve un ${(_totalExp / _totalEt * 100).toStringAsFixed(2)}% de tus ingresos',
                      style:
                          const TextStyle(fontSize: 13.0, letterSpacing: 1.3),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
