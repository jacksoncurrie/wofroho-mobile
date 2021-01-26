import 'package:flutter/material.dart';
import 'package:wofroho_mobile/templates/padded_page_template.dart';

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
    return PaddedPageTemplate(
      pageWidgets: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: pageWidgets),
          bottomWidget,
        ],
      ),
      background: background,
    );
  }
}
