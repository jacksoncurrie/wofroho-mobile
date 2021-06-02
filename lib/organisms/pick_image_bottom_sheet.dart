import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/molecules/secondary_button.dart';
import '../theme.dart';

void pickImageBottomSheet({
  required BuildContext context,
  required void Function() imgFromGallery,
  required void Function() imgFromCamera,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => _builder(context, imgFromGallery, imgFromCamera),
  );
}

Widget _builder(
  BuildContext context,
  void Function() imgFromGallery,
  void Function() imgFromCamera,
) {
  final backgroundColor = Theme.of(context).colorScheme.backgroundColor;

  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    child: Wrap(
      children: [
        _showMinimiseIcon(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ParagraphText(text: 'Choose photo source'),
        ),
        _showListItem(
          _showCameraIcon(),
          'Take photo',
          imgFromCamera,
          context,
        ),
        _showListItem(
          _showLibraryIcon(),
          'Choose existing',
          imgFromGallery,
          context,
        ),
        _showCancelButton(context),
      ],
    ),
  );
}

Widget _showMinimiseIcon() {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Center(
      child: SvgPicture.asset(
        'assets/images/minimise.svg',
        semanticsLabel: "Minimise icon",
      ),
    ),
  );
}

Widget _showCancelButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      width: double.infinity,
      child: SecondaryButton(
        text: 'Cancel',
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
  );
}

Widget _showCameraIcon() {
  return SvgPicture.asset(
    'assets/images/camera.svg',
    semanticsLabel: "Camera icon",
    width: 32,
  );
}

Widget _showLibraryIcon() {
  return SvgPicture.asset(
    'assets/images/libary.svg',
    semanticsLabel: "Libary icon",
    width: 32,
  );
}

Widget _showListItem(
  Widget leadingIcon,
  String text,
  void Function() onTap,
  BuildContext context,
) {
  return Material(
    // Need material widget to show inkwell
    child: ListTile(
      leading: leadingIcon,
      title: ParagraphText(text: text),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      onTap: () {
        onTap();
        Navigator.of(context).pop();
      },
    ),
  );
}
