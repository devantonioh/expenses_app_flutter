import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/providers/providers.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:expenses_app/utils/utils_extension.dart';

class PerCategoryList extends StatelessWidget {
  const PerCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final gList = context.watch<ExpensesProvider>().groupItemsList;

    return SliverList(
        delegate: SliverChildBuilderDelegate((context, i) {
      var item = gList[i];
      return ListTile(
        leading: Icon(
          item.icon.toIcon(),
          color: item.color.toColor(),
          size: 35.0,
        ),
        title: Text(item.category),
        trailing: Text(
          getAmountFormat(item.amount),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'catDetails', arguments: item);
        },
      );
    }, childCount: gList.length));
  }
}
