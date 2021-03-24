import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/button.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import '../theme.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    required this.text,
    required this.onPressed,
    this.padding,
    this.fontSize,
  });

  final String text;
  final void Function() onPressed;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Button(
      backgroundColor: Theme.of(context).colorScheme.primaryColor,
      child: ParagraphText(
        text: text,
        textColor: Theme.of(context).colorScheme.textOnPrimary,
        fontSize: fontSize,
      ),
      onPressed: onPressed,
      padding: padding,
    );
  }
}
