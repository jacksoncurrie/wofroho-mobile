import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/padded_scroll_page_template.dart';

import 'details_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    @required this.person,
  });

  final Person person;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _skipPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => DetailsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaddedScrollPageTemplate(
      pageWidgets: ActionPageTemplate(
        actionWidget: _showCloseAction(),
        pageWidgets: Center(
          child: ParagraphText(
            text: 'Profile page',
          ),
        ),
      ),
    );
  }

  Widget _showCloseAction() {
    return Align(
      alignment: Alignment.centerRight,
      child: SingleIconButton(
        icon: SvgPicture.asset(
          'assets/images/close.svg',
          semanticsLabel: "Close icon",
        ),
        onPressed: _skipPressed,
      ),
    );
  }
}
