import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class FadePageTransition<T> extends PageRoute<T> {
  FadePageTransition(this.child);

  final Widget child;

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeScaleTransition(
      animation: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);
}
