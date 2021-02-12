import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/rich_text_paragraph.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/organisms/calendar_week_picker.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/setting_input_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';

class EditWeekPage extends StatefulWidget {
  @override
  _EditWeekPageState createState() => _EditWeekPageState();
}

class _EditWeekPageState extends State<EditWeekPage> {
  int _focusedDay = 2;
  DateTime _startWeekDay;
  List<DateTime> _focusedDaysWeek = [];
  int _currentDay;

  void _skipPressed() {
    Navigator.pop(context);
  }

  void _savePressed() {
    Navigator.pop(context);
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
    return SimpleTemplate(
      pageWidgets: SimpleScrollTemplate(
        pageWidgets: InputTemplate(
          pageWidgets: ActionPageTemplate(
            actionWidget: _showCloseAction(),
            pageWidgets: _showPageWidgets(),
          ),
          bottomWidget: _showBottomWidget(),
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
          onPressed: _skipPressed,
        ),
      ),
    );
  }

  Widget _showPageWidgets() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: PageHeadingTemplate(
        title: "Select days",
        pageWidgets: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _showThisWeekWofroho(),
            _showRemainderText(),
          ],
        ),
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
      labelWidget: RichTextParagraph(
        textSpanItems: [
          TextSpanItem(text: 'Please select the '),
          TextSpanItem(text: 'wofroho', fontWeight: FontWeight.bold),
          TextSpanItem(text: ' for this week'),
        ],
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

  Widget _showCheckIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: SvgPicture.asset(
        'assets/images/check.svg',
        semanticsLabel: "Check icon",
      ),
    );
  }

  Widget _showRemainderText() {
    final selections = _focusedDay - _focusedDaysWeek.length;
    final plural = selections == 1 ? "" : "s";

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ParagraphText(
            text: "You have $selections selection$plural left",
          ),
          if (selections == 0) _showCheckIcon(),
        ],
      ),
    );
  }

  Widget _showBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: PrimaryButton(
        text: "Save",
        onPressed: _savePressed,
      ),
    );
  }
}
