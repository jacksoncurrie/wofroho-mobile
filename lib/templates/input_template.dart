import 'package:flutter/material.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';

class InputTemplate extends StatelessWidget {
  InputTemplate({
    @required this.pageWidgets,
    @required this.bottomWidget,
    this.background,
  });

  final Widget pageWidgets;
  final Widget bottomWidget;
  final Widget background;

  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: Stack(
        children: [
          if (background != null) background,
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: pageWidgets),
                bottomWidget,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
