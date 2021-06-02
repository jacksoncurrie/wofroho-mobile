import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import '../theme.dart';

class EmptyState extends StatelessWidget {
  EmptyState({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ParagraphText(
      text: text,
      textColor: Theme.of(context).colorScheme.disabledText,
    );
  }
}
