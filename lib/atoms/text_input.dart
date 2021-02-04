import 'package:flutter/material.dart';
import '../theme.dart';

class TextInput extends StatelessWidget {
  TextInput({
    @required this.controller,
    this.hintText,
    this.enabled = true,
    this.onTap,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final bool enabled;
  final void Function() onTap;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide.none),
          fillColor: Theme.of(context).colorScheme.inputBackground,
          filled: true,
          contentPadding: const EdgeInsets.all(10),
          hintText: hintText,
        ),
        controller: controller,
        enabled: enabled,
        onChanged: onChanged,
      ),
    );
  }
}
