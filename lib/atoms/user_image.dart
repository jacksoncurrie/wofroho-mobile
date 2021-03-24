import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme.dart';

class UserImage extends StatelessWidget {
  UserImage(
      {this.image,
      required this.width,
      required this.height,
      this.borderColor,
      this.borderRadius = 3.0,
      this.onTap});

  final ImageProvider<Object>? image;
  final double width;
  final double height;
  final double borderRadius;
  final Color? borderColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: borderColor == null
              ? null
              : Border.all(
                  color: borderColor!,
                  width: 2,
                ),
          image: image == null
              ? null
              : DecorationImage(
                  image: image!,
                  fit: BoxFit.cover,
                ),
          color: Theme.of(context).colorScheme.emptyPhoto,
        ),
        child: image == null ? _showEmptyImage() : null,
      ),
    );
  }

  Widget _showEmptyImage() {
    return Center(
      child: SvgPicture.asset(
        'assets/images/add.svg',
        semanticsLabel: "Add icon",
        width: 16,
      ),
    );
  }
}
