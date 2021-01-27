import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import '../theme.dart';

class LinkText extends StatelessWidget {
  LinkText({
    @required this.text,
    @required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ParagraphText(
        text: text,
        textColor: Theme.of(context).colorScheme.primaryColor,
      ),
    );
  }
}
