import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import '../theme.dart';

void pickImageBottomSheet({
  @required BuildContext context,
  @required void Function() imgFromGallery,
  @required void Function() imgFromCamera,
}) {
  assert(context != null);
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
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
    child: Wrap(
      children: [
        _showMinimiseIcon(),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, top: 20.0, bottom: 10),
          child: ParagraphText(text: 'Choose image provider', fontSize: 14),
        ),
        _showListItem(
          Icon(Icons.photo_library),
          'Photo library',
          imgFromGallery,
          context,
        ),
        _showListItem(
          Icon(Icons.photo_camera),
          'Camera',
          imgFromCamera,
          context,
        ),
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
        semanticsLabel: "Minmise icon",
      ),
    ),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      onTap: () {
        onTap();
        Navigator.of(context).pop();
      },
    ),
  );
}
