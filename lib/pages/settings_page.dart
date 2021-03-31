import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/child_page_transition.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/animations/next_page_transition.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/rich_text_paragraph.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/pages/about_page.dart';
import 'package:wofroho_mobile/pages/account_page.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'package:wofroho_mobile/pages/manage_organisation_page.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _closePressed() {
    Navigator.pop(context);
  }

  void _accountPressed() {
    Navigator.of(context).push(
      FadePageTransition(
        AccountPage(
          initialSetup: false,
          person: Person(
            id: "1",
            imageUrl: "https://placekitten.com/300/300",
            name: "Bruce Wayne",
            role: "Businessman, entrepreneur, accountant",
          ),
        ),
      ),
    );
  }

  void _aboutPressed() {
    Navigator.of(context).push(
      FadePageTransition(
        AboutPage(),
      ),
    );
  }

  void _organisationPressed() {
    Navigator.of(context).push(
      FadePageTransition(
        ManageOrganisationPage(),
      ),
    );
  }

  void _logoutPressed() {
    Navigator.of(context).pushAndRemoveUntil(
      ChildPageTransition(
        LoginPage(),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: SimpleScrollTemplate(
          pageWidgets: ActionPageTemplate(
        actionWidget: _showCloseAction(),
        pageWidgets: InputTemplate(
          pageWidgets: _showPageWidgets(),
          bottomWidget: _showAboutDetails(),
        ),
      )),
    );
  }

  Widget _showCloseAction() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, right: 25.0),
        child: SingleIconButton(
          icon: SvgPicture.asset(
            'assets/images/close.svg',
            semanticsLabel: "Close icon",
          ),
          onPressed: _closePressed,
        ),
      ),
    );
  }

  Widget _showPageWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _showSettingItem(
            "Account",
            AccountPage(
              initialSetup: false,
              person: Person(
                id: "1",
                imageUrl: "https://placekitten.com/300/300",
                name: "Bruce Wayne",
                role: "Businessman, entrepreneur, accountant",
              ),
            )),
        _showSettingItem(
          "Organisation",
          ManageOrganisationPage(),
        ),
        _showSettingItem("About", AboutPage()),
        InkWell(
          onTap: _logoutPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: ParagraphText(text: 'Logout'),
          ),
        ),
      ],
    );
  }

  Widget _showSettingItem(String text, Widget openItem) {
    return OpenContainer(
      closedElevation: 0,
      closedColor: Theme.of(context).colorScheme.backgroundColor,
      transitionDuration: Duration(milliseconds: 300),
      closedBuilder: (context, open) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: ParagraphText(text: text),
        );
      },
      openBuilder: (context, _) => openItem,
    );

    // return InkWell(
    //   onTap: onTap,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
    //     child: ParagraphText(text: text),
    //   ),
    // );
  }

  Widget _showAboutDetails() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 25.0),
          child: RichTextParagraph(
            textSpanItems: [
              TextSpanItem(
                text: 'wofroho',
                fontWeight: FontWeight.bold,
                textColor: Theme.of(context).colorScheme.disabledText,
                fontSize: 16,
              ),
              TextSpanItem(
                text: ' = Working from home',
                textColor: Theme.of(context).colorScheme.disabledText,
                fontSize: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
