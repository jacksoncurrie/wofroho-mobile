import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/heading_text.dart';

class TextWithImage extends StatelessWidget {
  TextWithImage({
    @required this.text,
    @required this.image,
  });

  final String text;
  final SvgPicture image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        HeadingText(text: text),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: image,
        )
      ],
    );
  }
}
