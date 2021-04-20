import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class ChildPageTransition<T> extends PageRoute<T> {
  ChildPageTransition({
    required this.child,
    String? routeName,
  }) : super(settings: RouteSettings(name: routeName));

  final Widget child;

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.scaled,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 400);
}
