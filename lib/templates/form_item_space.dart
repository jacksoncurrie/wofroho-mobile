import 'package:flutter/material.dart';

class FormItemSpace extends StatelessWidget {
  FormItemSpace({
    @required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: child,
    );
  }
}
