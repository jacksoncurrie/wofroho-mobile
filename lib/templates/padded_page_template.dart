import 'package:flutter/material.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';

class PaddedPageTemplate extends StatelessWidget {
  PaddedPageTemplate({
    required this.pageWidgets,
    this.background,
    this.overlayWidget,
  });

  final Widget pageWidgets;
  final Widget? background;
  final Widget? overlayWidget;

  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: Stack(
        children: <Widget>[
          if (background != null)
            Positioned(
              top: 0,
              child: background!,
            ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 25.0,
                right: 25.0,
                bottom: 25.0,
              ),
              child: pageWidgets,
            ),
          ),
        ],
      ),
      overlayWidget: overlayWidget,
    );
  }
}
