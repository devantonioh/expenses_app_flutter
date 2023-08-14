import 'package:expenses_app/providers/providers.dart';
import 'package:expenses_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartSwitch extends StatelessWidget {
  const ChartSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final currentChart = context.watch<UIProvider>().selectedChart;

    switch (currentChart) {
      case 'Grafico Lineal':
        return const ChartLine();
      case 'Grafico Pie':
        return const ChartPie();
      case 'Grafico de dispersion':
        return const ChartScatterPlot();
      default:
        return const ChartLine();
    }
  }
}
