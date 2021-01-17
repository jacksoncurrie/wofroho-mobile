import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    @required this.child,
    @required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  final Widget child;
  final Function onPressed;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: backgroundColor,
      textColor: textColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1.0),
      ),
      child: child,
    );
  }
}
