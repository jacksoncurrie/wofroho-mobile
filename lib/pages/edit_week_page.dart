import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/rich_text_paragraph.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/molecules/dialog_popup.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/organisms/calendar_week_picker.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/setting_input_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';

class EditWeekPage extends StatefulWidget {
  EditWeekPage({
    this.focusedDays,
    required this.userId,
  });

  final List<DateTime>? focusedDays;
  final String userId;

  @override
  _EditWeekPageState createState() => _EditWeekPageState();
}

class _EditWeekPageState extends State<EditWeekPage> {
  DateTime? _startWeekDay;
  List<DateTime> _focusedDaysWeek = [];
  late DateTime _currentDay;
  late int _currentWeek;
  late bool _saveLoading;

  final _firestore = FirebaseFirestore.instance;

  bool _areListsEqual(var list1, var list2) {
    // check if both are lists
    if (!(list1 is List && list2 is List) || list1.length != list2.length)
      return false;

    // check if elements are equal
    for (var i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }

    return true;
  }

  void _openValidateClose() {
    // Check if changes have been made
    if (_areListsEqual(_focusedDaysWeek, widget.focusedDays)) {
      _closePressed();
      return;
    }

    showDialogPopup(
      context: context,
      title: 'Unsaved changes',
      message: 'Would you like to save the changes you have made?',
      primaryText: 'Leave without saving',
      primaryPressed: () {
        // Drop popup
        Navigator.pop(context);
        _closePressed();
      },
    );
  }

  void _closePressed() {
    Navigator.pop(context);
  }

  void _savePressed() async {
    try {
      setState(() {
        _saveLoading = true;
      });

      final timestamps =
          _focusedDaysWeek.map((i) => Timestamp.fromDate(i)).toList();

      await _firestore
          .collection('users')
          .doc(widget.userId)
          .update({'datesFromHome': timestamps});
    } on Exception catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        _saveLoading = false;
      });
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    final todaysDate = DateTime.now();
    final mondaysDate =
        todaysDate.subtract(Duration(days: todaysDate.weekday - 1));
    _startWeekDay =
        DateTime(mondaysDate.year, mondaysDate.month, mondaysDate.day);
    _currentDay = DateTime(todaysDate.year, todaysDate.month, todaysDate.day);
    _currentWeek = 0;
    _focusedDaysWeek.addAll(widget.focusedDays ?? []);
    _saveLoading = false;

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
          onPressed: _openValidateClose,
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
            // _showRemainderText(),
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
    // if (_focusedDaysWeek.length >= _focusedDay) {
    //   setState(() => _focusedDaysWeek.removeAt(0));
    // }
    setState(() => _focusedDaysWeek.add(day));
  }

  void _weekChanged(int weekNumber) {
    setState(() {
      _currentWeek = weekNumber;
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
        focusedDays: _focusedDaysWeek,
        weekChanged: _weekChanged,
        secondaryDay: _currentDay,
        showLeftArrow: _currentWeek > 0,
      ),
    );
  }

  // Widget _showCheckIcon() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 5.0),
  //     child: SvgPicture.asset(
  //       'assets/images/check.svg',
  //       semanticsLabel: "Check icon",
  //     ),
  //   );
  // }

  // Widget _showRemainderText() {
  //   final selections = _focusedDay - _focusedDaysWeek.length;
  //   final plural = selections == 1 ? "" : "s";

  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 20.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         ParagraphText(
  //           text: "You have $selections selection$plural left",
  //         ),
  //         if (selections == 0) _showCheckIcon(),
  //       ],
  //     ),
  //   );
  // }

  Widget _showBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: PrimaryButton(
        text: "Save",
        onPressed: _savePressed,
        isLoading: _saveLoading,
      ),
    );
  }
}
