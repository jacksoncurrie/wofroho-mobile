import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/animations/slide_right_transition.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/rich_text_paragraph.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/pages/about_page.dart';
import 'package:wofroho_mobile/pages/account_page.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'package:wofroho_mobile/pages/manage_organisation_page.dart';
import 'package:wofroho_mobile/pages/setup_page.dart';
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

  void _generalPressed() {
    Navigator.of(context).push(
      SlideRightTransition(SetupPage(initialSetup: false)),
    );
  }

  void _accountPressed() {
    Navigator.of(context).push(
      SlideRightTransition(
        AccountPage(
          initialSetup: false,
          person: Person(
            id: "1",
            imageUrl: "http://placekitten.com/300/300",
            name: "Bruce Wayne",
            role: "Businessman, entrepreneur, accountant",
          ),
        ),
      ),
    );
  }

  void _aboutPressed() {
    Navigator.of(context).push(
      SlideRightTransition(
        AboutPage(),
      ),
    );
  }

  void _organisationPressed() {
    Navigator.of(context).push(
      SlideRightTransition(
        ManageOrganisationPage(),
      ),
    );
  }

  void _logoutPressed() {
    Navigator.of(context).pushAndRemoveUntil(
      FadePageTransition(
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
        _showSettingDivider(),
        _showSettingItem("General", _generalPressed),
        _showSettingDivider(),
        _showSettingItem("Account", _accountPressed),
        _showSettingDivider(),
        _showSettingItem("About", _aboutPressed),
        _showSettingDivider(),
        _showSettingItem("Organisation", _organisationPressed),
        _showSettingDivider(),
        _showSettingItem("Logout", _logoutPressed),
        _showSettingDivider(),
      ],
    );
  }

  Widget _showSettingDivider() {
    return Divider(thickness: 1);
  }

  Widget _showSettingItem(String text, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: ParagraphText(text: text),
      ),
    );
  }

  Widget _showAboutDetails() {
    return Column(
      children: [
        ParagraphText(
          text: "Designed by Duann Schlechter",
          textColor: Theme.of(context).colorScheme.disabledText,
        ),
        ParagraphText(
          text: "Developed by Jackson Currie",
          textColor: Theme.of(context).colorScheme.disabledText,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 25.0),
          child: RichTextParagraph(
            textSpanItems: [
              TextSpanItem(
                text: 'Working from home = ',
                textColor: Theme.of(context).colorScheme.disabledText,
                fontSize: 16,
              ),
              TextSpanItem(
                text: 'wofroho',
                fontWeight: FontWeight.bold,
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
