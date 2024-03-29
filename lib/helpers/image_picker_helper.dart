import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<File?> imgFromCamera() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 300,
    );

    if (image == null) return null;
    return File(image.path);
  }

  static Future<File?> imgFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 300,
    );

    if (image == null) return null;
    return File(image.path);
  }
}
