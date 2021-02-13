import 'package:flutter/material.dart';

class ParagraphText extends StatelessWidget {
  ParagraphText({
    @required this.text,
    this.fontSize = 16,
    this.textColor,
    this.overflow,
  });

  final String text;
  final double fontSize;
  final Color textColor;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: fontSize ?? 16,
          color: textColor,
        ),
        overflow: overflow,
      ),
    );
  }
}
