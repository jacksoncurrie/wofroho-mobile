import 'package:flutter/material.dart';
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
    return RaisedButton(
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.secondaryColor,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      textColor: Theme.of(context).primaryColor,
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null)
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: image,
            ),
          Text(
            text,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
