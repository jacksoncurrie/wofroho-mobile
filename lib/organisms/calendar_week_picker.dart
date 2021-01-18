import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/molecules/week_row.dart';
import 'package:wofroho_mobile/molecules/weekday_name_row.dart';

class CalendarWeekPicker extends StatelessWidget {
  CalendarWeekPicker({
    @required this.dayBegin,
    @required this.dayTapped,
    @required this.focusedDays,
    this.startDay = 1,
  });

  final DateTime dayBegin;
  final void Function(int) dayTapped;
  final List<int> focusedDays;
  final int startDay;

  var _month = "";
  var _year = 0;

  final pageViewController = PageController(
    initialPage: 0,
  );

  List<int> _getDays(int weekNumber) {
    var days = List<int>();
    for (var i = 0; i < 7; i++) {
      final day = dayBegin.add(Duration(days: i + (weekNumber * 7)));
      days.add(day.day);
      if (i == 0) {
        final formatter = DateFormat('MMMM');
        _month = formatter.format(day);
        _year = day.year;
      }
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: PageView.builder(
        itemBuilder: (context, index) {
          final days = _getDays(index);
          return Column(
            children: [
              _showMonthAndYear(_month, _year),
              WeekdayNameRow(
                startDay: startDay,
              ),
              WeekRow(
                days: days,
                dayTapped: dayTapped,
                focusedDays: focusedDays,
              ),
            ],
          );
        },
        controller: pageViewController,
      ),
    );
  }

  Widget _showMonthAndYear(String month, int year) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ParagraphText(
        text: "$month, $year",
      ),
    );
  }
}
