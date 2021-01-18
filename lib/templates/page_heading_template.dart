import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/heading_text.dart';

class PageHeadingTemplate extends StatelessWidget {
  PageHeadingTemplate({
    @required this.title,
    @required this.pageWidgets,
  });

  final String title;
  final Widget pageWidgets;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: HeadingText(text: title),
        ),
        Expanded(child: pageWidgets),
      ],
    );
  }
}
