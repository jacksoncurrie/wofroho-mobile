import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/button.dart';
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
    return Button(
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Theme.of(context).colorScheme.textOnPrimary,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 17,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
