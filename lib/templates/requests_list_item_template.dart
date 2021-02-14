import 'package:flutter/material.dart';

class RequestsListItemTemplate extends StatelessWidget {
  RequestsListItemTemplate({
    @required this.image,
    @required this.itemTitle,
    @required this.itemSubtitle,
    this.endWidget,
    this.actions,
  });

  final Widget image;
  final Widget itemTitle;
  final Widget itemSubtitle;
  final Widget endWidget;
  final Widget actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _showImage(),
        Expanded(
          child: _showNameDetails(),
        ),
        if (endWidget != null) _showEndWidget(),
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
        actions,
      ],
    );
  }

  Widget _showEndWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: endWidget,
    );
  }
}
