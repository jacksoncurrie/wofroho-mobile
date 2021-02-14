import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/user_image.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/molecules/secondary_button.dart';
import 'package:wofroho_mobile/templates/requests_list_item_template.dart';
import '../theme.dart';

class RequestListItem extends StatelessWidget {
  RequestListItem({
    @required this.personId,
    @required this.image,
    @required this.name,
    this.personOutlined = false,
    @required this.role,
    @required this.dates,
    this.onTap,
    this.endWidget,
  });

  final String personId;
  final ImageProvider<Object> image;
  final String name;
  final bool personOutlined;
  final String role;
  final List<DateTime> dates;
  final Widget endWidget;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        child: RequestsListItemTemplate(
          image: _showImage(context),
          itemTitle: _showName(),
          itemSubtitle: _showRole(),
          actions: _showActions(),
        ),
      ),
    );
  }

  Widget _showImage(BuildContext context) {
    return Hero(
      tag: "${personId}_image",
      child: UserImage(
        height: 80,
        width: 80,
        image: image,
        borderColor:
            personOutlined ? Theme.of(context).colorScheme.accent : null,
      ),
    );
  }

  Widget _showName() {
    return Hero(
      tag: "${personId}_name",
      child: ParagraphText(
        text: name,
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _showRole() {
    return Hero(
      tag: "${personId}_role",
      child: ParagraphText(
        text: role,
        fontSize: 13,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _showActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PrimaryButton(
            text: 'Accept',
            onPressed: () {},
            padding: EdgeInsets.zero,
            fontSize: 14,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: SecondaryButton(
            text: 'Decline',
            onPressed: () {},
            padding: EdgeInsets.zero,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
