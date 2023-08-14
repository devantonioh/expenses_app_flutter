import 'package:flutter/material.dart';

import 'package:expenses_app/widgets/widgets.dart';

class FlayerFrecuency extends StatelessWidget {
  const FlayerFrecuency({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 180.0,
      child: ChartLine(),
    );
  }
}
