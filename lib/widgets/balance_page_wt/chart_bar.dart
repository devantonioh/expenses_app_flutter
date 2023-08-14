import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:expenses_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/providers/providers.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;
    double totalExp = 0;
    double totalEt = 0;

    totalExp = getSumOfExP(eList);
    totalEt = getSumOfEntries(etList);

    final data = [
      OrdinalSales('Ingresos', totalEt, Colors.green),
      OrdinalSales('Gastos', totalExp, Colors.red),
    ];

    List<charts.Series<OrdinalSales, String>> seriesList = [
      charts.Series<OrdinalSales, String>(
        id: 'Balance',
        data: data,
        domainFn: (v, i) => v.name,
        measureFn: (v, i) => v.amount,
        colorFn: (v, i) => charts.ColorUtil.fromDartColor(v.color),
      )
    ];

    return SizedBox(
      child: charts.BarChart(
        seriesList,
        defaultRenderer: charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(50),
        ),
        primaryMeasureAxis:
            const charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
      ),
    );
  }
}

class OrdinalSales {
  String name;
  double amount;
  Color color;

  OrdinalSales(this.name, this.amount, this.color);
}
