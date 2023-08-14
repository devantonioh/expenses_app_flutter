import 'package:expenses_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/utils/utils_extension.dart';
import '../utils/math_operations.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:expenses_app/providers/providers.dart';

class ExpensesDetails extends StatefulWidget {
  const ExpensesDetails({Key? key}) : super(key: key);

  @override
  State<ExpensesDetails> createState() => _ExpensesDetailsState();
}

class _ExpensesDetailsState extends State<ExpensesDetails> {
  List<CombinedModel> cList = [];
  final ScrollController _scrollController = ScrollController();
  double _offset = 0;

  void _listener() {
    _offset = _scrollController.offset / 100;
    if (_offset > 0.94) _offset = 0.9;
    setState(() {});
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
    cList = context.read<ExpensesProvider>().allItemsList;

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataDay = ModalRoute.of(context)!.settings.arguments as int?;
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();
    cList = context.watch<ExpensesProvider>().allItemsList;

    double totalExp = 0.0;

    if (dataDay != null) {
      cList = cList.where((e) => e.day == dataDay).toList();
    }

    totalExp = cList.map((e) => e.amount).fold(0.0, (a, b) => a + b);

    cList.sort((a, b) => a.day.compareTo(b.day));

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 125.0,
            title: const Text('Desglose de gastos'),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                  alignment: Alignment(_offset, 1),
                  child: Text(getAmountFormat(totalExp))),
              centerTitle: true,
              background: const Align(
                alignment: Alignment.bottomCenter,
                child: Text('Total'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 15.0),
              height: 30.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(
                    Theme.of(context).primaryColorDark),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            var item = cList[index];
            return Slidable(
              key: ValueKey(item),
              startActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      cList.removeAt(index);
                      setState(() {});
                      exProvider.deleteExpense(item.id!);
                      uiProvider.bnbIndex = 0;
                      Fluttertoast.showToast(
                        msg: 'Gasto eliminado',
                        backgroundColor: Colors.red,
                      );
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Borrar',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      Navigator.pushNamed(
                        context,
                        'AddExpenses',
                        arguments: item,
                      );
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Editar',
                  )
                ],
              ),
              child: ListTile(
                leading: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    const Icon(Icons.calendar_today, size: 40.0),
                    Positioned(top: 16.0, child: Text(item.day.toString())),
                  ],
                ),
                title: Row(
                  children: [
                    Text(item.category),
                    const SizedBox(width: 8.0),
                    Icon(
                      item.icon.toIcon(),
                      color: item.color.toColor(),
                      //size: 24.0,
                    )
                  ],
                ),
                subtitle: Text(item.comment),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      getAmountFormat(item.amount),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${(100 * item.amount / totalExp).toStringAsFixed(2)} %',
                      style: const TextStyle(fontSize: 11.0),
                    ),
                  ],
                ),
              ),
            );
          }, childCount: cList.length)),
        ],
      ),
    );
  }
}
