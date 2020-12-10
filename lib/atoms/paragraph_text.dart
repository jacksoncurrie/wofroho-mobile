import 'package:flutter/material.dart';

class ParagraphText extends StatelessWidget {
  ParagraphText({
    @required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 17,
      ),
    );
  }
}
