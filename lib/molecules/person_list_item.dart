import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/user_dates.dart';
import 'package:wofroho_mobile/atoms/user_image.dart';
import 'package:wofroho_mobile/templates/person_list_item_template.dart';
import '../theme.dart';

class PersonListItem extends StatelessWidget {
  PersonListItem({
    @required this.image,
    @required this.name,
    this.personOutlined = false,
    @required this.role,
    @required this.dates,
  });

  final ImageProvider<Object> image;
  final String name;
  final bool personOutlined;
  final String role;
  final List<DateTime> dates;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        child: PersonListItemTemplate(
          image: _showImage(context),
          itemTitle: _showName(),
          itemSubtitle: _showRole(),
          dates: _showDates(),
        ),
      ),
    );
  }

  Widget _showImage(BuildContext context) {
    return UserImage(
      height: 50,
      width: 50,
      image: image,
      borderColor: personOutlined ? Theme.of(context).colorScheme.accent : null,
    );
  }

  Widget _showName() {
    return ParagraphText(
      text: name,
      fontSize: 20,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _showRole() {
    return ParagraphText(
      text: role,
      fontSize: 14,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _showDates() {
    return UserDates(
      dates: dates,
    );
  }
}
