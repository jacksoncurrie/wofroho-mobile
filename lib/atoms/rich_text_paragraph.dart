import 'package:flutter/material.dart';
import '../theme.dart';

class RichTextParagraph extends StatelessWidget {
  RichTextParagraph({
    @required this.textSpanItems,
  });

  final List<TextSpanItem> textSpanItems;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: textSpanItems.first.text,
        style: _getFinalStyle(textSpanItems.first, context),
        children: textSpanItems
            .skip(1)
            .map((i) => TextSpan(
                  text: i.text,
                  style: _getFinalStyle(i, context),
                ))
            .toList(),
      ),
    );
  }

  TextStyle _getFinalStyle(TextSpanItem textSpanItem, BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: textSpanItem.fontWeight ?? FontWeight.normal,
      fontSize: textSpanItem.fontSize ?? 20,
      color: textSpanItem.textColor ?? Theme.of(context).colorScheme.text,
    );
  }
}

class TextSpanItem {
  TextSpanItem({
    @required this.text,
    this.fontWeight,
    this.textColor,
    this.fontSize,
  });

  final String text;
  final FontWeight fontWeight;
  final Color textColor;
  final double fontSize;
}
