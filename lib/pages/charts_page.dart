import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/providers/providers.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:expenses_app/widgets/widgets.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentChart = context.watch<UIProvider>().selectedChart;
    bool _isPerDay = false;

    if (currentChart == 'Grafico Lineal' ||
        currentChart == 'Grafico de dispersion') {
      _isPerDay = true;
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: AppBar(
          title: Text(currentChart),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ChartSelector(),
                      Expanded(
                        child:
                            //ChartLine(),
                            //ChartPie(),
                            //ChartScatterPlot(),
                            ChartSwitch(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                //padding: const EdgeInsets.only(top: 10.0),
                height: 40.0,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  decoration: Constants.sheetBoxDecoration(
                      Theme.of(context).primaryColorDark),
                ),
              ),
            ),
            (_isPerDay) ? const PerDayList() : const PerCategoryList(),
          ],
        ));
  }
}
