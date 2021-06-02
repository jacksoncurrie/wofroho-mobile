import 'package:flutter/material.dart';

class FormItemSpace extends StatelessWidget {
  FormItemSpace({
    required this.child,
    this.validationMessage,
  });

  final Widget child;
  final Widget? validationMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(bottom: validationMessage == null ? 0 : 10.0),
            child: child,
          ),
          if (validationMessage != null) validationMessage!,
        ],
      ),
    );
  }
}
