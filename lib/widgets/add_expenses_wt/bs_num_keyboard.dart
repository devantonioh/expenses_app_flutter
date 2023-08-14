import 'package:flutter/material.dart';

import 'package:expenses_app/models/models.dart';
import 'package:expenses_app/utils/utils.dart';

class BSNumKeyboard extends StatefulWidget {
  final CombinedModel cModel;
  const BSNumKeyboard({Key? key, required this.cModel}) : super(key: key);

  @override
  State<BSNumKeyboard> createState() => _BSNumKeyboardState();
}

class _BSNumKeyboardState extends State<BSNumKeyboard> {
  String import = '0.00';

  @override
  void initState() {
    import = widget.cModel.amount.toStringAsFixed(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //funcion match. para dectar digitos.
    String Function(Match) mathFunc;
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc = (Match match) => '${match[1]},';

    return GestureDetector(
      onTap: () {
        _numPad();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('Cantidad Ingresada'),
            Text(
              '\$ ${import.replaceAllMapped(reg, mathFunc)}',
              style: const TextStyle(
                fontSize: 30.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _numPad() {
    if (import == '0.00') import = '';

    _expenseChange(String amount) {
      if (amount == '') amount = '0.00';
      widget.cModel.amount = double.parse(amount);
    }

    _num(String _text, double _height) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          import += _text;
          widget.cModel.amount = double.parse(import);
          setState(() {});
        },
        child: SizedBox(
          height: _height,
          child: Center(
            child: Text(
              _text,
              style: const TextStyle(fontSize: 35.0),
            ),
          ),
        ),
      );
    }

    showModalBottomSheet(
        barrierColor: Colors.transparent,
        //isDismissible: false,
        isScrollControlled: true,
        //enableDrag: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SizedBox(
              height: 350.0,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                var _height = constraints.biggest.height / 5;
                return Column(
                  children: [
                    Table(
                      border: TableBorder.symmetric(
                          inside:
                              const BorderSide(color: Colors.grey, width: 0.1)),
                      children: [
                        TableRow(children: [
                          _num('1', _height),
                          _num('2', _height),
                          _num('3', _height),
                        ]),
                        TableRow(children: [
                          _num('4', _height),
                          _num('5', _height),
                          _num('6', _height),
                        ]),
                        TableRow(children: [
                          _num('7', _height),
                          _num('8', _height),
                          _num('9', _height),
                        ]),
                        TableRow(children: [
                          _num('.', _height),
                          _num('0', _height),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (import.length > 0.0) {
                                import = import.substring(0, import.length - 1);
                                _expenseChange(import);
                              }
                              setState(() {});
                            },
                            onLongPress: () {
                              import = '';
                              _expenseChange(import);
                              setState(() {});
                            },
                            child: SizedBox(
                              height: _height,
                              child: const Icon(
                                Icons.backspace,
                                size: 35.0,
                              ),
                            ),
                          )
                        ])
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              import = '0.00';
                              _expenseChange(import);

                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: Constants.customButton(
                                Colors.transparent, Colors.red, 'Cancelar'),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (import.length == 0.0) import = '0.00';
                              _expenseChange(import);

                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: Constants.customButton(
                                Colors.green, Colors.transparent, 'Aceptar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          );
        });
  }
}
