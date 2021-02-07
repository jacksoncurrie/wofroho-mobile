import 'package:flutter/material.dart';
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
        Material(
          // Need material widget to show inkwell
          color: Colors.transparent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: ListTile(
            leading: Icon(Icons.photo_library),
            title: Text(
              'Photo library',
              style: TextStyle(fontSize: 18.0),
            ),
            contentPadding: EdgeInsets.all(10),
            onTap: () {
              imgFromGallery();
              Navigator.of(context).pop();
            },
          ),
        ),
        Material(
          // Need material widget to show inkwell
          color: Colors.transparent,
          child: ListTile(
            leading: Icon(Icons.photo_camera),
            title: Text(
              'Camera',
              style: TextStyle(fontSize: 18.0),
            ),
            contentPadding: EdgeInsets.all(10),
            onTap: () {
              imgFromCamera();
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    ),
  );
}
