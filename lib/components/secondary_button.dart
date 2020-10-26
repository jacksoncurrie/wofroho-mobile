import 'package:flutter/material.dart';
import '../theme.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({
    @required this.text,
    @required this.onPressed,
  });

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.secondaryColor,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      textColor: Theme.of(context).primaryColor,
      elevation: 5,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
