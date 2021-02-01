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
      appBar: _showEmptyAppBar(context),
      body: pageWidgets,
    );
  }

  Widget _showEmptyAppBar(BuildContext context) {
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
