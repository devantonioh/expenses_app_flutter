import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/utils/utils.dart';
import 'package:expenses_app/utils/utils_extension.dart';
import 'package:expenses_app/providers/providers.dart';
import 'package:expenses_app/models/models.dart';

class CreateCategory extends StatefulWidget {
  final FeaturesModel fModel;
  const CreateCategory({super.key, required this.fModel});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  bool hasData = false;
  String stcCategory = ''; //static string Category
  @override
  void initState() {
    if (widget.fModel.id != null) {
      stcCategory = widget.fModel.category; // lee el valor y no redibuja
      hasData = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fList = context.watch<ExpensesProvider>().fList;
    final exProvider = context.read<ExpensesProvider>();

    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    Iterable<FeaturesModel> contain;
    contain = fList.where((e) =>
        e.category.toLowerCase() == widget.fModel.category.toLowerCase());

    _addCategory() {
      if (contain.isNotEmpty) {
        Fluttertoast.showToast(
            msg: 'Ya Existe esa Categoria 🤦‍♂️',
            backgroundColor: Colors.red,
            fontSize: 20.0,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER);
        print('Ya existe esa Categoria');
      } else if (widget.fModel.category.isNotEmpty) {
        exProvider.addNewFeature(widget.fModel);
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: ' Procede a Guardar 👌',
            backgroundColor: Colors.green,
            fontSize: 20.0,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER);
        print('Procede a Guardar');
      } else {
        Fluttertoast.showToast(
            msg: ' No olvides nombrar una categoria 😉',
            backgroundColor: Colors.green,
            fontSize: 20.0,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER);

        print('No olvides nombrar una categoria');
      }
    }

    _editCategory() {
      if (widget.fModel.category.toLowerCase() == stcCategory.toLowerCase()) {
        exProvider.updateFeatures(widget.fModel);
        Fluttertoast.showToast(
            msg: 'Categoria Editada 👍',
            backgroundColor: Colors.green,
            fontSize: 20.0,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER);
        Navigator.pop(context);
        print('Procede a Editar');
      } else if (contain.isNotEmpty) {
        Fluttertoast.showToast(
            msg: 'Ya Existe esa Categoria 🤦‍♂️',
            backgroundColor: Colors.red,
            fontSize: 20.0,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER);
        print('Ya existe esa Categoria');
      } else if (widget.fModel.category.isNotEmpty) {
        exProvider.updateFeatures(widget.fModel);
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: 'Cambios Editados 👍',
            backgroundColor: Colors.green,
            fontSize: 20.0,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER);

        print('Procede a Editar Cambios');
      } else {
        Fluttertoast.showToast(
            msg: ' No olvides nombrar una categoria 😉',
            backgroundColor: Colors.green,
            fontSize: 20.0,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER);
        print('No olvides nombrar una categoria');
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: viewInsets / 3),
              child: ListTile(
                trailing: const Icon(Icons.text_fields_outlined, size: 35.0),
                title: TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  initialValue: widget.fModel.category,
                  decoration: InputDecoration(
                      hintText: 'Nombra una categoria',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                  onChanged: (txt) {
                    widget.fModel.category = txt;
                  },
                ),
              ),
            ),
            ListTile(
              onTap: () => _selectedColor(),
              trailing: CircleColor(
                color: widget.fModel.color.toColor(),
                circleSize: 40.0,
              ),
              title: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).cardColor),
                    borderRadius: BorderRadius.circular(35.0)),
                child: const Center(
                  child: Text('Color'),
                ),
              ),
            ),
            ListTile(
              onTap: () => _selectedIcon(),
              trailing: Icon(widget.fModel.icon.toIcon(), size: 35.0),
              title: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).cardColor),
                    borderRadius: BorderRadius.circular(35.0)),
                child: const Center(
                  child: Text('Icono'),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Constants.customButton(
                      Colors.transparent,
                      Colors.red,
                      'CANCELAR',
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      (hasData) ? _editCategory() : _addCategory();
                    },
                    child: Constants.customButton(
                      Colors.green,
                      Colors.transparent,
                      'ACEPTAR',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _selectedColor() {
    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isDismissible: false,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialColorPicker(
                selectedColor: widget.fModel.color.toColor(),
                physics: const NeverScrollableScrollPhysics(),
                circleSize: 45.0,
                //allowShades: false, //entrar mas colores.
                //iconSelected: Icons.edit_outlined,
                //colors: fullMaterialColors,
                onColorChange: (Color color) {
                  var hexColor =
                      '#${color.value.toRadixString(16).substring(2, 8)}';
                  widget.fModel.color = hexColor;
                  setState(() {});
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Constants.customButton(
                    Colors.green, Colors.transparent, 'LISTO'),
              )
            ],
          );
        });
  }

  _selectedIcon() {
    final iconList = IconList().iconMap;
    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isDismissible: false,
        context: context,
        builder: (context) {
          return SizedBox(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5),
              itemCount: iconList.length,
              itemBuilder: (context, i) {
                var key = iconList.keys.elementAt(i);
                return GestureDetector(
                  child: Icon(
                    key.toIcon(),
                    size: 30.0,
                    color: Theme.of(context).dividerColor,
                  ),
                  onTap: () {
                    widget.fModel.icon = key;
                    Navigator.pop(context);
                    setState(() {});
                  },
                );
              },
            ),
          );
        });
  }
}
