import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  ItemTile({
    @required this.child,
    @required this.backgroundColor,
    this.borderColor,
    this.width = 40.0,
    this.height = 40.0,
  });

  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(1.0),
        border: borderColor == null
            ? null
            : Border.all(
                color: borderColor,
                width: 2,
              ),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
