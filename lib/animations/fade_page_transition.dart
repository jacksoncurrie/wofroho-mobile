import 'package:flutter/material.dart';

class FadePageTransition<T> extends PageRoute<T> {
  FadePageTransition({
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
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);
}
