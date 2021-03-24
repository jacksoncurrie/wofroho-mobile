import 'package:flutter/material.dart';

class SettingInputTemplate extends StatelessWidget {
  SettingInputTemplate({
    required this.labelWidget,
    required this.inputWidget,
    this.inputPadding = 20.0,
    this.labelPadding = 30.0,
  });

  final Widget labelWidget;
  final Widget inputWidget;
  final double labelPadding;
  final double inputPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: inputPadding),
          child: labelWidget,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: labelPadding),
          child: inputWidget,
        ),
      ],
    );
  }
}
