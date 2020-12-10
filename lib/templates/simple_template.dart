import 'package:flutter/material.dart';
import '../theme.dart';

class SimpleTemplate extends StatelessWidget {
  SimpleTemplate({
    @required this.pageWidgets,
  });

  final Widget pageWidgets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.backgroundColor,
      body: LayoutBuilder(builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: IntrinsicHeight(child: pageWidgets),
          ),
        );
      }),
    );
  }
}
