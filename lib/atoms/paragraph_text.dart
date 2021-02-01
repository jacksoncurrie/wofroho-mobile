import 'package:flutter/material.dart';

class ParagraphText extends StatelessWidget {
  ParagraphText({
    @required this.text,
    this.fontSize = 16,
    this.textColor,
  });

  final String text;
  final double fontSize;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        color: textColor,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
