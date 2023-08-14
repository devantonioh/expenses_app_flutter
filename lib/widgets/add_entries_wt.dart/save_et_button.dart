import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:expenses_app/models/models.dart';
import 'package:expenses_app/providers/providers.dart';
import 'package:expenses_app/utils/utils.dart';

class SaveEtButton extends StatelessWidget {
  final CombinedModel cModel;
  const SaveEtButton({Key? key, required this.cModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
      onTap: () {
        if (cModel.amount != 0.0) {
          exProvider.addNewEntries(cModel);
          Fluttertoast.showToast(
              msg: 'Ingreso agregado 😁', backgroundColor: Colors.green);
          uiProvider.bnbIndex = 0;
          Navigator.pop(context);
        } else if (cModel.amount == 0.0) {
          Fluttertoast.showToast(
              msg: 'No olvides agregar un Ingreso',
              backgroundColor: Colors.red);
        }
      },
      child: SizedBox(
          height: 70.0,
          width: 150.0,
          child: Constants.customButton(
            Colors.green,
            Colors.white,
            'Guardar',
          )),
    );
  }
}
