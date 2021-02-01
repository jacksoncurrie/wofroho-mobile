import 'package:flutter/material.dart';

class PersonListItemTemplate extends StatelessWidget {
  PersonListItemTemplate({
    @required this.image,
    @required this.itemTitle,
    @required this.itemSubtitle,
    @required this.dates,
  });

  final Widget image;
  final Widget itemTitle;
  final Widget itemSubtitle;
  final Widget dates;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _showImage(),
        Expanded(
          child: _showNameDetails(),
        ),
        _showDates(),
      ],
    );
  }

  Widget _showImage() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: image,
    );
  }

  Widget _showNameDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        itemTitle,
        itemSubtitle,
      ],
    );
  }

  Widget _showDates() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: dates,
    );
  }
}
