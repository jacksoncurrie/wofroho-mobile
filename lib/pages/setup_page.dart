import 'dart:developer';

import 'package:flutter/material.dart';
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
  int focusedDay = 2;
  List<int> weekDates = [];
  List<int> focusedDaysWeek = [];

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
    final tuesdaysDate = mondaysDate.add(Duration(days: 1));
    final wednesdaysDate = mondaysDate.add(Duration(days: 2));
    final thursdaysDate = mondaysDate.add(Duration(days: 3));
    final fridaysDate = mondaysDate.add(Duration(days: 4));
    final saturdaysDate = mondaysDate.add(Duration(days: 5));
    final sundaysDate = mondaysDate.add(Duration(days: 6));
    weekDates = [
      mondaysDate.day,
      tuesdaysDate.day,
      wednesdaysDate.day,
      thursdaysDate.day,
      fridaysDate.day,
      saturdaysDate.day,
      sundaysDate.day,
    ];

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
    while (focusedDaysWeek.length > day) {
      focusedDaysWeek.removeAt(0);
    }
    setState(() {
      focusedDay = day;
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
        focusedDays: [focusedDay],
      ),
    );
  }

  void _updateWeek(int day) {
    if (focusedDaysWeek.contains(day)) {
      setState(() => focusedDaysWeek.remove(day));
      return;
    }
    if (focusedDaysWeek.length >= focusedDay) {
      setState(() => focusedDaysWeek.removeAt(0));
    }
    setState(() => focusedDaysWeek.add(day));
  }

  Widget _showThisWeekWofroho() {
    return SettingInputTemplate(
      labelWidget: ParagraphText(
        text: "Please select the wofroho for this week",
        fontSize: 20.0,
      ),
      inputWidget: CalendarWeekPicker(
        days: weekDates,
        dayTapped: (day) => _updateWeek(day),
        focusedDays: focusedDaysWeek,
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
