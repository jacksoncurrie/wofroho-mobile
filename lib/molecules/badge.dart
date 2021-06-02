import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import '../theme.dart';

class Badge extends StatelessWidget {
  Badge({
    required this.number,
    this.maxNumber = 999,
  });

  final int? number;
  final int maxNumber;

  String get _finalNumber => number! > maxNumber ? '$maxNumber+' : '$number';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _showDecoration(context),
      child: Center(
        child: _showText(),
      ),
    );
  }

  Decoration _showDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Theme.of(context).colorScheme.errorColor,
    );
  }

  Widget _showText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: ParagraphText(
        text: _finalNumber,
        fontSize: 14,
        textColor: Colors.white,
      ),
    );
  }
}
