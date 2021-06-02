import 'package:flutter/material.dart';

class SimpleScrollTemplate extends StatelessWidget {
  SimpleScrollTemplate({
    required this.pageWidgets,
  });

  final Widget pageWidgets;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
          child: IntrinsicHeight(child: pageWidgets),
        ),
      );
    });
  }
}
