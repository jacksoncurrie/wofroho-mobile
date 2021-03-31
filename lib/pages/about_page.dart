import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/rich_text_paragraph.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  void _skipPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: SimpleScrollTemplate(
        pageWidgets: InputTemplate(
          pageWidgets: ActionPageTemplate(
            actionWidget: _showBackAction(),
            pageWidgets: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: PageHeadingTemplate(
                title: 'About',
                pageWidgets: _showPageWidgets(),
              ),
            ),
          ),
          bottomWidget: _showAboutDetails(),
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
    return Column(
      children: [
        _showParagraph(
          ParagraphText(
            text:
                'We all know our companies wanted us to work from home/romote working but did not know how to implement it. Covid19 hit us all hard and we will never go back to how we worked before.',
            fontSize: 18.0,
          ),
        ),
        _showParagraph(
          RichTextParagraph(
            textSpanItems: [
              TextSpanItem(text: 'Thus we created ', fontSize: 18),
              TextSpanItem(
                  text: 'wofroho', fontWeight: FontWeight.bold, fontSize: 18),
              TextSpanItem(
                  text: ' to keep up with your work or organisation.',
                  fontSize: 18),
            ],
          ),
        ),
        _showParagraph(
          ParagraphText(
            text:
                'Thank you for your support! Please let us know if you have any suggestions at help@wofroho.com',
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _showParagraph(Widget text) {
    return Padding(padding: const EdgeInsets.only(bottom: 20), child: text);
  }

  Widget _showAboutDetails() {
    return Column(
      children: [
        ParagraphText(
          text: "Designed by Duann Schlechter",
          textColor: Theme.of(context).colorScheme.disabledText,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: ParagraphText(
            text: "Developed by Jackson Currie",
            textColor: Theme.of(context).colorScheme.disabledText,
          ),
        ),
      ],
    );
  }
}
