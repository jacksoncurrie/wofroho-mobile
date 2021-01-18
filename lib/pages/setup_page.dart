import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/organisms/button_pair.dart';
import 'package:wofroho_mobile/organisms/week_row.dart';
import 'package:wofroho_mobile/templates/close_page_template.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  int focusedDay = 2;

  void _skipPressed() {
    log('Skip');
  }

  void _savePressed() {
    log('Save');
  }

  @override
  Widget build(BuildContext context) {
    return InputTemplate(
      pageWidgets: ClosePageTemplate(
        closePressed: _skipPressed,
        pageWidgets: _showPageWidgets(),
      ),
      bottomWidget: _showBottomWidget(),
    );
  }

  Widget _showPageWidgets() {
    return PageHeadingTemplate(
      title: "Setup",
      pageWidgets: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ParagraphText(
            text: "How many days per week do you wofroho?",
            fontSize: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: WeekRow(
              days: [1, 2, 3, 4, 5, 6, 7],
              dayTapped: (day) => setState(() => focusedDay = day),
              focusedDay: focusedDay,
            ),
          ),
        ],
      ),
    );
  }

  Widget _showBottomWidget() {
    return ButtonPair(
      primaryText: "Save",
      primaryOnPressed: _savePressed,
      secondaryText: "Skip",
      secondaryOnPressed: _skipPressed,
    );
  }
}
