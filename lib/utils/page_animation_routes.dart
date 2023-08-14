import 'package:flutter/material.dart';

class PageAnimationRoutes extends PageRouteBuilder {
  final Widget widget;
  final double ejeX;
  final double ejeY;

  PageAnimationRoutes({
    required this.ejeX,
    required this.ejeY,
    required this.widget,
  }) : super(
            transitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
              return ScaleTransition(
                alignment: Alignment(ejeX, ejeY),
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
