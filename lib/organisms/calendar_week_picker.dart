import 'package:flutter/material.dart';
import 'package:wofroho_mobile/molecules/week_row.dart';
import 'package:wofroho_mobile/molecules/weekday_name_row.dart';

class CalendarWeekPicker extends StatelessWidget {
  CalendarWeekPicker({
    @required this.days,
    @required this.dayTapped,
    @required this.focusedDays,
    this.startDay = 1,
  });

  final List<int> days;
  final void Function(int) dayTapped;
  final List<int> focusedDays;
  final int startDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
  }
}
