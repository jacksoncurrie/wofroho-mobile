import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/button.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
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
      backgroundColor: Theme.of(context).colorScheme.primaryColor,
      textColor: Theme.of(context).colorScheme.textOnPrimary,
      child: ParagraphText(text: text),
      onPressed: onPressed,
    );
  }
}
