import 'package:flutter/material.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/molecules/week_row.dart';
import 'package:wofroho_mobile/organisms/button_pair.dart';
import 'package:wofroho_mobile/organisms/calendar_week_picker.dart';
import 'package:wofroho_mobile/pages/details_page.dart';
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
  List<DateTime> _focusedDaysWeek = [];
  int _currentDay;

  void _skipPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => DetailsPage(),
      ),
    );
  }

  void _savePressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => DetailsPage(),
      ),
    );
  }

  @override
  void initState() {
    final todaysDate = DateTime.now();
    final mondaysDate =
        todaysDate.subtract(Duration(days: todaysDate.weekday - 1));
    _startWeekDay = mondaysDate;
    _currentDay = todaysDate.day;

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
          _showRemainderText(),
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
        dayTapped: _numberPerWeekChange,
        focusedDays: [_focusedDay],
      ),
    );
  }

  void _updateWeek(DateTime day) {
    if (_focusedDaysWeek.contains(day)) {
      setState(() => _focusedDaysWeek.remove(day));
      return;
    }
    if (_focusedDaysWeek.length >= _focusedDay) {
      setState(() => _focusedDaysWeek.removeAt(0));
    }
    setState(() => _focusedDaysWeek.add(day));
  }

  void _weekChanged(int weekNumber) {
    setState(() {
      _focusedDaysWeek.clear();
      _currentDay = weekNumber == 0 ? DateTime.now().day : 0;
    });
  }

  Widget _showThisWeekWofroho() {
    return SettingInputTemplate(
      labelWidget: ParagraphText(
        text: "Please select the wofroho for this week",
        fontSize: 20.0,
      ),
      inputWidget: CalendarWeekPicker(
        dayBegin: _startWeekDay,
        dayTapped: _updateWeek,
        focusedDays: _focusedDaysWeek.map((i) => i.day).toList(),
        weekChanged: _weekChanged,
        secondaryDay: _currentDay,
      ),
    );
  }

  Widget _showRemainderText() {
    final selections = _focusedDay - _focusedDaysWeek.length;
    final plural = selections == 1 ? "" : "s";

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: ParagraphText(
          text: "You have $selections selection$plural left",
        ),
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
