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
      appBar: _showAppBar(context),
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

  Widget _showAppBar(BuildContext context) {
    // Empty app bar
    return PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: AppBar(
        backgroundColor: Theme.of(context).colorScheme.backgroundColor,
        brightness: Brightness.light,
        shadowColor: Colors.transparent,
      ),
    );
  }
}
