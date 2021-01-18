import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/molecules/week_row.dart';
import 'package:wofroho_mobile/organisms/button_pair.dart';
import 'package:wofroho_mobile/organisms/calendar_week_picker.dart';
import 'package:wofroho_mobile/templates/close_page_template.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/setting_input_template.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  int _focusedDay = 2;
  DateTime _startWeekDay;
  List<int> _focusedDaysWeek = [];

  void _skipPressed() {
    log('Skip');
  }

  void _savePressed() {
    log('Save');
  }

  @override
  void initState() {
    final todaysDate = DateTime.now();
    final mondaysDate =
        todaysDate.subtract(Duration(days: todaysDate.weekday - 1));
    _startWeekDay = mondaysDate;

    super.initState();
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
          _showHowManyDaysInput(),
          _showThisWeekWofroho(),
        ],
      ),
    );
  }

  void _numberPerWeekChange(int day) {
    while (_focusedDaysWeek.length > day) {
      _focusedDaysWeek.removeAt(0);
    }
    setState(() {
      _focusedDay = day;
    });
  }

  Widget _showHowManyDaysInput() {
    return SettingInputTemplate(
      labelWidget: ParagraphText(
        text: "How many days per week do you wofroho?",
        fontSize: 20.0,
      ),
      inputWidget: WeekRow(
        days: [1, 2, 3, 4, 5, 6, 7],
        dayTapped: (day) => _numberPerWeekChange(day),
        focusedDays: [_focusedDay],
      ),
    );
  }

  void _updateWeek(int day) {
    if (_focusedDaysWeek.contains(day)) {
      setState(() => _focusedDaysWeek.remove(day));
      return;
    }
    if (_focusedDaysWeek.length >= _focusedDay) {
      setState(() => _focusedDaysWeek.removeAt(0));
    }
    setState(() => _focusedDaysWeek.add(day));
  }

  Widget _showThisWeekWofroho() {
    return SettingInputTemplate(
      labelWidget: ParagraphText(
        text: "Please select the wofroho for this week",
        fontSize: 20.0,
      ),
      inputWidget: CalendarWeekPicker(
        dayBegin: _startWeekDay,
        dayTapped: (day) => _updateWeek(day),
        focusedDays: _focusedDaysWeek,
        weekChanged: (i) => setState(() => _focusedDaysWeek.clear()),
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
