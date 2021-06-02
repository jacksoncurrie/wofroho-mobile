import 'package:flutter/material.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
