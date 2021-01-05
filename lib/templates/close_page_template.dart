import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';

class ClosePageTemplate extends StatelessWidget {
  ClosePageTemplate({
    @required this.pageWidgets,
    @required this.closePressed,
  });

  final Widget pageWidgets;
  final void Function() closePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: SingleIconButton(
            icon: Icon(Icons.close),
            onPressed: closePressed,
          ),
        ),
        Expanded(child: pageWidgets),
      ],
    );
  }
}
