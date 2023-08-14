import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/utils/utils.dart';
import 'package:expenses_app/widgets/widgets.dart';
import 'package:expenses_app/providers/providers.dart';

class FrontSheet extends StatelessWidget {
  const FrontSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    bool hasData = false;

    if (eList.isNotEmpty) {
      hasData = true;
    }

    return Container(
        //height: 800.0,
        decoration: Constants.sheetBoxDecoration(
            Theme.of(context).scaffoldBackgroundColor),
        child: (hasData)
            ? ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const FlayerSkin(
                    myTitle: 'Categoria de Gastos',
                    myWidget: FlayerCategories(),
                  ),
                  const FlayerSkin(
                    myTitle: 'Frecuencia de Gastos',
                    myWidget: FlayerFrecuency(),
                  ),
                  const FlayerSkin(
                    myTitle: 'Movimientos',
                    myWidget: FlayerMovements(),
                  ),
                  const FlayerSkin(
                    myTitle: 'Balance General',
                    myWidget: FlayerBalance(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(50.0),
                    child: Image.asset('assets/empty.png'),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(50.0),
                    child: Image.asset('assets/empty.png'),
                  ),
                  const Text(
                    'No Tienes Gastos este mes, agrega aqui 👇',
                    style: TextStyle(fontSize: 15.0, letterSpacing: 1.3),
                  )
                ],
              ));
  }
}
