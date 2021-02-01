import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  UserImage({
    @required this.image,
    @required this.width,
    @required this.height,
    this.borderColor,
  });

  final ImageProvider<Object> image;
  final double width;
  final double height;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        border: borderColor == null
            ? null
            : Border.all(
                color: borderColor,
                width: 2,
              ),
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
