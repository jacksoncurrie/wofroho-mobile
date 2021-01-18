import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/item_tile.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';

class DayTile extends StatelessWidget {
  DayTile({
    @required this.child,
    @required this.backgroundColor,
    @required this.textColor,
    this.borderColor,
  });

  final int child;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ItemTile(
      child: ParagraphText(
        text: child.toString(),
        textColor: textColor,
      ),
      backgroundColor: backgroundColor,
      borderColor: borderColor,
    );
  }
}
