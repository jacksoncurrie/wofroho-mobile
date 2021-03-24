import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/item_tile.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';

class DayTile extends StatelessWidget {
  DayTile({
    required this.child,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  final String child;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return ItemTile(
      child: ParagraphText(
        text: child,
        textColor: textColor,
      ),
      backgroundColor: backgroundColor,
      borderColor: borderColor,
    );
  }
}
