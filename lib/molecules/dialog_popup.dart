import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/heading_text.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/molecules/secondary_button.dart';

void showDialogPopup({
  @required BuildContext context,
  @required String title,
  @required String message,
  @required String primaryText,
  @required String secondaryText,
  @required void Function() primaryPressed,
  @required void Function() secondaryPressed,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: HeadingText(
        text: title,
        fontSize: 24,
      ),
      contentPadding:
          const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ParagraphText(text: message),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 8),
            child: PrimaryButton(
              text: primaryText,
              onPressed: primaryPressed,
            ),
          ),
          SecondaryButton(
            text: secondaryText,
            onPressed: secondaryPressed,
          ),
        ],
      ),
    ),
  );
}
