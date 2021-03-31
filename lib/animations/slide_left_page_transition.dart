import 'package:flutter/material.dart';

class SlideLeftPageTransition<T> extends PageRoute<T> {
  SlideLeftPageTransition(this.child);

  final Widget child;

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    var begin = Offset(1.0, 0.0);
    var end = Offset.zero;
    var curve = Curves.ease;
    var curveTween = CurveTween(curve: curve);
    var tween = Tween(begin: begin, end: end).chain(curveTween);

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);
}
