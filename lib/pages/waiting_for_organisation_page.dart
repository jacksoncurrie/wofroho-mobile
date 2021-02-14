import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/rich_text_paragraph.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';

class WaitingForOrganisationPage extends StatefulWidget {
  @override
  _WaitingForOrganisationPageState createState() =>
      _WaitingForOrganisationPageState();
}

class _WaitingForOrganisationPageState
    extends State<WaitingForOrganisationPage> {
  String _organistionName;

  void _closePressed() {
    Navigator.of(context).pushAndRemoveUntil(
      FadePageTransition(
        LoginPage(),
      ),
      (_) => false,
    );
  }

  @override
  void initState() {
    _organistionName = 'Wayne Enterprises';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: SimpleScrollTemplate(
        pageWidgets: ActionPageTemplate(
          actionWidget: _showCloseAction(),
          pageWidgets: _showPageWidgets(),
        ),
      ),
    );
  }

  Widget _showCloseAction() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, right: 25),
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
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: PageHeadingTemplate(
        title: 'Waiting for organisation',
        pageWidgets: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichTextParagraph(
              textSpanItems: [
                TextSpanItem(text: 'Waiting for '),
                TextSpanItem(
                  text: '$_organistionName',
                  fontWeight: FontWeight.bold,
                ),
                TextSpanItem(
                  text:
                      ' to accept your invitation. This must be accepted before you can use the app.',
                ),
              ],
            ),
            _showWaiting(),
          ],
        ),
      ),
    );
  }

  Widget _showWaiting() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CircularProgressIndicator(),
    );
  }
}
