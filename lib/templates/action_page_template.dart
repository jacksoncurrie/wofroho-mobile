import 'package:flutter/material.dart';

class ActionPageTemplate extends StatelessWidget {
  ActionPageTemplate({
    @required this.pageWidgets,
    @required this.actionWidget,
  });

  final Widget pageWidgets;
  final Widget actionWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        actionWidget,
        Expanded(child: pageWidgets),
      ],
    );
  }
}
