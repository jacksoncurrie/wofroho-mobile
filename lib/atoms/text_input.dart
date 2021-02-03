import 'package:flutter/material.dart';
import '../theme.dart';

class TextInput extends StatelessWidget {
  TextInput({
    @required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide.none),
        fillColor: Theme.of(context).colorScheme.inputBackground,
        filled: true,
        contentPadding: const EdgeInsets.all(10),
      ),
      controller: controller,
    );
  }
}
