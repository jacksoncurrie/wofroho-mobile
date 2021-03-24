import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';

class DataField extends StatelessWidget {
  DataField({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _showTitle(),
        child,
      ],
    );
  }

  Widget _showTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: ParagraphText(
        text: title,
        fontSize: 14,
      ),
    );
  }
}
