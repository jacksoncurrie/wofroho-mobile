import 'package:flutter/material.dart';
import '../theme.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    @required this.text,
    @required this.onPressed,
  });

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).colorScheme.textOnPrimary,
      elevation: 5,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 17,
        ),
      ),
    );
  }
}
