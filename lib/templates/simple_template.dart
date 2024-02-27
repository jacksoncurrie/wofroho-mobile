import 'package:flutter/material.dart';
import '../theme.dart';

class SimpleTemplate extends StatelessWidget {
  SimpleTemplate({
    required this.pageWidgets,
    this.overlayWidget,
  });

  final Widget pageWidgets;
  final Widget? overlayWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.backgroundColor,
      appBar: _showEmptyAppBar(context),
      body: Stack(
        children: [
          pageWidgets,
          if (overlayWidget != null) overlayWidget!,
        ],
      ),
    );
  }

  PreferredSizeWidget? _showEmptyAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: AppBar(
        backgroundColor: Theme.of(context).colorScheme.backgroundColor,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
