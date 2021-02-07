import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';

class ManageOrganisationPage extends StatefulWidget {
  @override
  _ManageOrganisationPageState createState() => _ManageOrganisationPageState();
}

class _ManageOrganisationPageState extends State<ManageOrganisationPage> {
  void _skipPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: SimpleScrollTemplate(
        pageWidgets: ActionPageTemplate(
          actionWidget: _showBackAction(),
          pageWidgets: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: PageHeadingTemplate(
              title: 'Wayne Enterprises',
              pageWidgets: _showPageWidgets(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showBackAction() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10),
        child: SingleIconButton(
          icon: SvgPicture.asset(
            'assets/images/back.svg',
            semanticsLabel: "Back icon",
          ),
          onPressed: _skipPressed,
        ),
      ),
    );
  }

  Widget _showPageWidgets() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ParagraphText(
        text: 'Manage organisation coming soon...',
      ),
    );
  }
}
