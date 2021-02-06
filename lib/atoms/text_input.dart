import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme.dart';

class TextInput extends StatelessWidget {
  TextInput({
    @required this.controller,
    this.hintText,
    this.enabled = true,
    this.onTap,
    this.onChanged,
    this.keyboardType,
    this.validationType = ValidationType.none,
    this.showIconWithValidation = true,
  });

  final TextEditingController controller;
  final String hintText;
  final bool enabled;
  final void Function() onTap;
  final void Function(String) onChanged;
  final TextInputType keyboardType;
  final ValidationType validationType;
  final bool showIconWithValidation;

  static final _borderRadius = BorderRadius.circular(2);

  Color _getBorderColor(ValidationType validationType, BuildContext context) {
    switch (validationType) {
      case ValidationType.none:
        return Colors.transparent;
      case ValidationType.error:
        return Theme.of(context).colorScheme.errorColor;
      case ValidationType.success:
        return Theme.of(context).colorScheme.primaryColor;
      default:
        return Colors.transparent;
    }
  }

  Widget _getSuffixIcon(ValidationType validationType) {
    if (!showIconWithValidation) return null;
    switch (validationType) {
      case ValidationType.none:
        return null;
      case ValidationType.error:
        return Container(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset(
              'assets/images/error.svg',
              semanticsLabel: "Error icon",
            ),
          ),
        );
      case ValidationType.success:
        return Container(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset(
              'assets/images/check.svg',
              semanticsLabel: "Success icon",
            ),
          ),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          border: Border.all(
              color: _getBorderColor(validationType, context), width: 1),
        ),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: _borderRadius, borderSide: BorderSide.none),
            fillColor: Theme.of(context).colorScheme.inputBackground,
            filled: true,
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            suffixIcon: _getSuffixIcon(validationType),
            suffixIconConstraints: BoxConstraints.tightFor(),
          ),
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}

enum ValidationType {
  none,
  error,
  success,
}
