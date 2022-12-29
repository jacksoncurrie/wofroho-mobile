import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0),
    this.isLoading = false,
    this.loadingWidget,
  });

  final Widget child;
  final void Function() onPressed;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          padding ?? const EdgeInsets.symmetric(vertical: 10.0),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        elevation: MaterialStateProperty.all(5),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.0),
          ),
        ),
      ),
      child: isLoading ? loadingWidget : child,
    );
  }
}
