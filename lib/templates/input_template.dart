import 'package:flutter/material.dart';

class InputTemplate extends StatelessWidget {
  InputTemplate({
    @required this.pageWidgets,
    @required this.bottomWidget,
  });

  final Widget pageWidgets;
  final Widget bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: pageWidgets),
        bottomWidget,
      ],
    );
  }
}
