import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/heading_text.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/theme.dart';

void showDialogPopup({
  required BuildContext context,
  required String title,
  required String message,
  required String primaryText,
  required void Function() primaryPressed,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondaryColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SingleIconButton(
              icon: _showCloseIcon(),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          HeadingText(
            text: title,
            fontSize: 24,
          ),
        ],
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
        ],
      ),
    ),
  );
}

Widget _showCloseIcon() {
  return SvgPicture.asset(
    'assets/images/close.svg',
    semanticsLabel: "Close icon",
  );
}
