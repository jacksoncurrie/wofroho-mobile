import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/button.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import '../theme.dart';

class SignInButton extends StatelessWidget {
  SignInButton({
    @required this.text,
    @required this.onPressed,
    this.image,
  });

  final String text;
  final Function onPressed;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Button(
      backgroundColor: Theme.of(context).colorScheme.secondaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null)
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: image,
            ),
          ParagraphText(
              text: text,
              textColor: Theme.of(context).colorScheme.textOnSecondary),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
