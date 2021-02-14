import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    @required this.child,
    @required this.onPressed,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0),
  });

  final Widget child;
  final Function onPressed;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 10.0),
      color: backgroundColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1.0),
      ),
      child: child,
    );
  }
}
