import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/providers/providers.dart';

class EntriesDetails extends StatefulWidget {
  const EntriesDetails({Key? key}) : super(key: key);

  @override
  State<EntriesDetails> createState() => _EntriesDetailsState();
}

class _EntriesDetailsState extends State<EntriesDetails> {
  @override
  Widget build(BuildContext context) {
    final etList = context.watch<ExpensesProvider>().etList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desglose de Ingresos'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
              return ListTile(
                title: Text(etList[i].entries.toString()),
              );
            }, childCount: etList.length),
          )
        ],
      ),
    );
  }
}
