import 'package:flutter/material.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/molecules/secondary_button.dart';

class ButtonPair extends StatelessWidget {
  ButtonPair({
    @required this.primaryText,
    @required this.primaryOnPressed,
    @required this.secondaryText,
    @required this.secondaryOnPressed,
  });

  final String primaryText;
  final Function primaryOnPressed;
  final String secondaryText;
  final Function secondaryOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 12,
          child: SecondaryButton(
            text: secondaryText,
            onPressed: secondaryOnPressed,
          ),
        ),
        Spacer(flex: 1),
        Expanded(
          flex: 12,
          child: PrimaryButton(
            text: primaryText,
            onPressed: primaryOnPressed,
          ),
        ),
      ],
    );
  }
}
