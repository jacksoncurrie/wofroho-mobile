import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/button.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import '../theme.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({
    required this.text,
    required this.onPressed,
    this.padding,
    this.fontSize,
    this.isLoading = false,
  });

  final String text;
  final void Function() onPressed;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final bool isLoading;

  Widget _showLoadingWidget(BuildContext context) {
    return SizedBox(
      width: 20.0,
      height: 20.0,
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.textOnSecondary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Button(
      backgroundColor: Theme.of(context).colorScheme.secondaryColor,
      child: ParagraphText(
        text: text,
        textColor: Theme.of(context).colorScheme.textOnSecondary,
        fontSize: fontSize,
      ),
      onPressed: onPressed,
      padding: padding,
      isLoading: isLoading,
      loadingWidget: _showLoadingWidget(context),
    );
  }
}
