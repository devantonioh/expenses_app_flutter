import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/models/models.dart';
import 'package:expenses_app/providers/providers.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:expenses_app/widgets/widgets.dart';
import 'package:expenses_app/utils/utils_extension.dart';

class AdminCategory extends StatelessWidget {
  const AdminCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fList = context.watch<ExpensesProvider>().fList;

    return ListView.builder(
        itemCount: fList.length,
        itemBuilder: (context, index) {
          var item = fList[index];
          return ListTile(
            leading: Icon(
              item.icon.toIcon(),
              size: 35.0,
              color: item.color.toColor(),
            ),
            title: Text(item.category),
            trailing: const Icon(
              Icons.edit,
              size: 25.0,
            ),
            onTap: () {
              Navigator.pop(context);
              _createCategory(context, item);
            },
          );
        });
  }

  _createCategory(BuildContext context, FeaturesModel fModel) {
    var features = FeaturesModel(
      id: fModel.id,
      category: fModel.category,
      color: fModel.color,
      icon: fModel.icon,
    );
    showModalBottomSheet(
      builder: (_) => CreateCategory(fModel: features),
      shape: Constants.bottomSheet(),
      context: context,
    );
  }
}
