import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme.dart';

class UserImage extends StatelessWidget {
  UserImage({
    this.image,
    @required this.width,
    @required this.height,
    this.borderColor,
    this.borderRadius = 3.0,
  });

  final ImageProvider<Object> image;
  final double width;
  final double height;
  final double borderRadius;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor == null
            ? null
            : Border.all(
                color: borderColor,
                width: 2,
              ),
        image: image == null
            ? null
            : DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
        color: Theme.of(context).colorScheme.emptyPhoto,
      ),
      child: _showEmptyImage(),
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
