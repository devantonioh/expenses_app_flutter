import 'package:expenses_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/utils/utils_extension.dart';
import 'package:expenses_app/providers/providers.dart';

/* 
Graficos de modo de PIE circular. Forma de Dona
*/

class ChartPieFlayer extends StatefulWidget {
  const ChartPieFlayer({super.key});

  @override
  State<ChartPieFlayer> createState() => _ChartPieState();
}

class _ChartPieState extends State<ChartPieFlayer> {
  int _index = 0;
  bool _animate = true;

  @override
  Widget build(BuildContext context) {
    var gList = context.watch<ExpensesProvider>().groupItemsList;
    double totalOther = 0;

    if (_index >= gList.length) {
      _index = 0;
    }
    if (gList.length >= 6) {
      totalOther =
          gList.sublist(5).map((e) => e.amount).fold(0.0, (a, b) => a + b);
      gList = gList.sublist(0, 5).toList();
      gList.add(CombinedModel(
          category: 'Otros',
          amount: totalOther,
          icon: 'otros',
          color: '#20634b'));
    }
    var item = gList[_index];

    List<charts.Series<CombinedModel, String>> _series(int index) {
      return [
        charts.Series<CombinedModel, String>(
          id: 'PieChart',
          domainFn: (v, i) => v.category,
          measureFn: (v, i) => v.amount,
          keyFn: (v, i) => v.icon,
          colorFn: (v, i) {
            var onTap = i == index;
            if (onTap == false) {
              return charts.ColorUtil.fromDartColor(v.color.toColor());
            } else {
              return charts.ColorUtil.fromDartColor(v.color.toColor()).darker;
            }
          },
          data: gList,
        )
      ];
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        charts.PieChart<String>(
          _series(_index),
          animate: _animate, //corregir
          animationDuration: const Duration(milliseconds: 500),
          defaultInteractions: true,
          defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 45,
            //arcRatio: 0.45,
            strokeWidthPx: 0.0,
          ),
          selectionModels: [
            charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: (charts.SelectionModel model) {
                if (model.hasDatumSelection) {
                  _animate = false;
                  _index = model.selectedDatum[0].index!;

                  setState(() {});
                }
              },
            )
          ],
        ),
        SizedBox(
          width: 75.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Icon(
                  item.icon.toIcon(),
                  color: item.color.toColor(),
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(item.category),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(getAmountFormat(item.amount)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
