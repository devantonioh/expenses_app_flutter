import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/providers.dart';
import 'package:expenses_app/utils/constants.dart';

class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  final bool hasData;
  const SaveButton({
    Key? key,
    required this.cModel,
    required this.hasData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
      onTap: () {
        if (cModel.amount != 0.0 && cModel.link != null) {
          (hasData)
              ? exProvider.updateExpense(cModel)
              : exProvider.addNewExpense(cModel);
          Fluttertoast.showToast(
              msg: (hasData) ? 'Gasto Editado' : 'gasto agregado 😁',
              backgroundColor: Colors.green);
          uiProvider.bnbIndex = 0;
          Navigator.pop(context);
        } else if (cModel.amount == 0.0) {
          Fluttertoast.showToast(
              msg: 'No olvides agregar un Monto', backgroundColor: Colors.red);
        } else {
          Fluttertoast.showToast(
              msg: 'No olvides seleccionar una categoria',
              backgroundColor: Colors.red);
        }
      },
      child: SizedBox(
          height: 70.0,
          width: 150.0,
          child: Constants.customButton(
            Colors.green,
            Colors.white,
            (hasData) ? 'Editar' : 'Guardar',
          )),
    );
  }
}
