import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  HeadingText({
    required this.text,
    this.fontSize = 32,
    this.textAlign,
  });

  final String text;
  final double fontSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    );
  }
}
