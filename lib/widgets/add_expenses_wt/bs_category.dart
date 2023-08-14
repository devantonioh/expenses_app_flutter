import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/providers/providers.dart';
import 'package:expenses_app/models/models.dart';
import 'package:expenses_app/widgets/widgets.dart';
import 'package:expenses_app/utils/utils_extension.dart';
import 'package:expenses_app/utils/utils.dart';

class BSCategory extends StatefulWidget {
  final CombinedModel cModel;

  const BSCategory({Key? key, required this.cModel}) : super(key: key);

  @override
  State<BSCategory> createState() => _BSCategoryState();
}

class _BSCategoryState extends State<BSCategory> {
  var catList = CategoryList().catList;
  final FeaturesModel fModel = FeaturesModel();
  @override
  void initState() {
    var exProvider = context.read<ExpensesProvider>();
    if (exProvider.fList.isEmpty) {
      for (FeaturesModel e in catList) {
        exProvider.addNewFeature(e);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final featureList = context.watch<ExpensesProvider>().fList;

    bool hasData = false;

    if (widget.cModel.category != 'Selecciona Categoria') {
      hasData = true;
    }

    return GestureDetector(
      onTap: () {
        _categorySelected(featureList);
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            const Icon(
                // (hasData)
                //   ? widget.cModel.icon.toIcon() :
                Icons.category_outlined,
                size: 35.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.7,
                      color: (hasData)
                          ? widget.cModel.color.toColor()
                          : Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(widget.cModel.category),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _categorySelected(List<FeaturesModel> fList) {
    void _itemSelected(String category, String color, int link) {
      widget.cModel.link = link;
      widget.cModel.category = category;
      widget.cModel.color = color;
      Navigator.pop(context);
      setState(() {});
    }

    var _widgets = [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: fList.length,
        itemBuilder: (_, index) {
          var item = fList[index];
          return ListTile(
            leading: Icon(item.icon.toIcon(),
                color: item.color.toColor(), size: 35.0),
            title: Text(item.category),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
            onTap: () {
              _itemSelected(item.category, item.color, item.id!);
            },
          );
        },
      ),
      const Divider(thickness: 2.0),
      ListTile(
        leading: const Icon(Icons.create_new_folder_outlined, size: 35.0),
        title: const Text('Crear nueva Categoria'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
        onTap: () {
          Navigator.pop(context);
          _createNewCategory();
        },
      ),
      ListTile(
        leading: const Icon(Icons.edit_outlined, size: 35.0),
        title: const Text('Administrar Categoria'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
        onTap: () {
          Navigator.pop(context);
          _adminCategory();
        },
      ),
    ];
    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.6,
          child: ListView(
            children: _widgets,
          ),
        );
      },
    );
  }

  _createNewCategory() {
    var features = FeaturesModel(
      id: fModel.id,
      category: fModel.category,
      color: fModel.color,
      icon: fModel.icon,
    );
    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) => CreateCategory(fModel: features));
  }

  _adminCategory() {
    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isDismissible: false,
        isScrollControlled: false,
        context: context,
        builder: (context) => const AdminCategory());
  }
}
