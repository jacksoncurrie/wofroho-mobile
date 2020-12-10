import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/button.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
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
    return Button(
      backgroundColor: Theme.of(context).colorScheme.secondaryColor,
      textColor: Theme.of(context).colorScheme.textOnSecondary,
      child: ParagraphText(text: text),
      onPressed: onPressed,
    );
  }
}
