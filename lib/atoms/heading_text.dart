import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  HeadingText({
    @required this.text,
    this.fontSize = 32,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: fontSize,
      ),
    );
  }
}
