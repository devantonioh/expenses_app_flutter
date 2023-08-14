import 'package:flutter/material.dart';

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/widgets/widgets.dart';

class AddExpensesPage extends StatelessWidget {
  const AddExpensesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();
    bool hasData = false;
    final editCModel =
        ModalRoute.of(context)!.settings.arguments as CombinedModel?;

    if (editCModel != null) {
      cModel = editCModel;
      hasData = true;
    }

    return Scaffold(
        appBar: AppBar(
          title: (hasData)
              ? const Text('Editar Gasto')
              : const Text('Agregar Gasto'),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            BSNumKeyboard(cModel: cModel),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: Constants.sheetBoxDecoration(
                    Theme.of(context).primaryColorDark),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DatePicker(cModel: cModel),
                    BSCategory(cModel: cModel),
                    CommentBox(cModel: cModel),
                    Expanded(
                      child: Center(
                          child: SaveButton(
                        cModel: cModel,
                        hasData: hasData,
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
