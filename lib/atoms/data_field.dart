import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';

class DataField extends StatelessWidget {
  DataField({
    @required this.title,
    @required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _showTitle(),
        _showValue(),
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

  Widget _showValue() {
    return ParagraphText(
      text: value,
    );
  }
}
