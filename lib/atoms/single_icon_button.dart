import 'package:flutter/material.dart';

class SingleIconButton extends StatelessWidget {
  const SingleIconButton({
    required this.icon,
    required this.onPressed,
  });

  final Widget? icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed as void Function()?,
      icon: icon!,
    );
  }
}
