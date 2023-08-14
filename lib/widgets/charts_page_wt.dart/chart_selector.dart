import 'package:expenses_app/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartSelector extends StatefulWidget {
  const ChartSelector({super.key});

  @override
  State<ChartSelector> createState() => _ChartSelectorState();
}

class _ChartSelectorState extends State<ChartSelector> {
  @override
  Widget build(BuildContext context) {
    final currentChart = context.watch<UIProvider>().selectedChart;
    final uiProvider = context.read<UIProvider>();
    var _widgets = <Widget>[];

    Map<String, IconData> typeChart = {
      'Grafico Lineal': Icons.show_chart,
      'Grafico Pie': CupertinoIcons.chart_pie,
      'Grafico de dispersion': Icons.bubble_chart
    };
    typeChart.forEach((name, icon) {
      _widgets.add(GestureDetector(
        onTap: () {
          uiProvider.selectedChart = name;
          setState(() {});
        },
        child: BubbleTab(
          icon: icon,
          selected: currentChart == name,
        ),
      ));
    });

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 22.0),
      child: Wrap(
        spacing: 8.0,
        children: _widgets,
      ),
    );
  }
}

class BubbleTab extends StatelessWidget {
  final bool selected;
  final IconData icon;
  const BubbleTab({
    super.key,
    required this.selected,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: (selected) ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Icon(icon),
    );
  }
}
