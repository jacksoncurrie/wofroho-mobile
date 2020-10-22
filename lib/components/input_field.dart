import 'package:flutter/material.dart';
import '../theme.dart';

class InputField extends StatelessWidget {
  InputField({
    @required this.label,
    this.hint,
  });

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 20.0),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Theme.of(context).colorScheme.inputBackground,
              filled: true,
              hintText: hint,
            ),
          ),
        ),
      ],
    );
  }
}
