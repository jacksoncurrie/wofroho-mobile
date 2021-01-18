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
    this.weekChanged,
    this.secondaryDay,
  });

  final DateTime dayBegin;
  final void Function(int) dayTapped;
  final List<int> focusedDays;
  final int startDay;
  final void Function(int) weekChanged;
  final int secondaryDay;

  final pageViewController = PageController(
    initialPage: 0,
  );

  WeekDetails _getDays(int weekNumber) {
    var days = List<int>();
    int year;
    String month;
    for (var i = 0; i < 7; i++) {
      final day = dayBegin.add(Duration(days: i + (weekNumber * 7)));
      days.add(day.day);
      if (i == 0) {
        final formatter = DateFormat('MMMM');
        month = formatter.format(day);
        year = day.year;
      }
    }
    return WeekDetails(year: year, month: month, days: days);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: PageView.builder(
        itemBuilder: (context, index) {
          final weekDetails = _getDays(index);
          return Column(
            children: [
              _showMonthAndYear(weekDetails.month, weekDetails.year),
              WeekdayNameRow(
                startDay: startDay,
              ),
              WeekRow(
                days: weekDetails.days,
                dayTapped: dayTapped,
                focusedDays: focusedDays,
                secondaryDay: secondaryDay,
              ),
            ],
          );
        },
        controller: pageViewController,
        onPageChanged: weekChanged,
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

class WeekDetails {
  WeekDetails({
    this.year,
    this.month,
    this.days,
  });

  int year;
  String month;
  List<int> days;
}
