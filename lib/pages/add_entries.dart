import 'package:flutter/material.dart';

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/widgets/widgets.dart';

class AddEntriesPage extends StatelessWidget {
  const AddEntriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Agregar Ingreso'),
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
                    CommentBox(cModel: cModel),
                    Expanded(
                      child: Center(child: SaveEtButton(cModel: cModel)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
