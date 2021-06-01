import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/molecules/week_row.dart';
import 'package:wofroho_mobile/molecules/weekday_name_row.dart';
import '../helpers/date_helper.dart';

class CalendarWeekPicker extends StatelessWidget {
  CalendarWeekPicker({
    required this.dayBegin,
    required this.dayTapped,
    required this.focusedDays,
    this.startDay = 1,
    this.weekChanged,
    this.secondaryDay,
    this.focusedBackgroundColor,
    this.focusedTextColor,
    this.outlinedDays,
    this.outlinedColor,
    this.showLeftArrow = true,
    this.showRightArrow = true,
  });

  final DateTime? dayBegin;
  final void Function(DateTime) dayTapped;
  final List<DateTime> focusedDays;
  final int startDay;
  final void Function(int)? weekChanged;
  final DateTime? secondaryDay;
  final Color? focusedBackgroundColor;
  final Color? focusedTextColor;
  final List<DateTime>? outlinedDays;
  final Color? outlinedColor;
  final bool showLeftArrow;
  final bool showRightArrow;

  final pageViewController = PageController(
    initialPage: 0,
  );

  static const _monthStringFormat = 'MMMM';

  WeekDetails _getDays(int weekNumber) {
    var days = <int>[];
    var dates = <DateTime>[];
    int? year;
    String? month;
    for (var i = 0; i < 7; i++) {
      final day = dayBegin!.add(Duration(days: i + (weekNumber * 7)));
      days.add(day.day);
      dates.add(day);
      if (i == 0) {
        final formatter = DateFormat(_monthStringFormat);
        month = formatter.format(day);
        year = day.year;
      }
    }
    return WeekDetails(year: year!, month: month!, days: days, dates: dates);
  }

  void _dayTapped(int day, List<DateTime> dates) {
    final dateTapped = dates.singleWhere((date) => date.day == day);
    dayTapped(dateTapped);
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
                dayTapped: (day) => _dayTapped(day, weekDetails.dates),
                focusedDays:
                    DateHelper.getDaysFromDate(focusedDays, weekDetails.dates),
                secondaryDay: secondaryDay == null
                    ? null
                    : DateHelper.getDayFromDateTime(
                        secondaryDay!, weekDetails.dates),
                focusedBackgroundColor: focusedBackgroundColor,
                focusedTextColor: focusedTextColor,
                outlinedDays: DateHelper.getDaysFromDate(
                    outlinedDays ?? [], weekDetails.dates),
                outlinedColor: outlinedColor,
              ),
            ],
          );
        },
        controller: pageViewController,
        onPageChanged: weekChanged,
      ),
    );
  }

  Widget _showArrowLeft() {
    return GestureDetector(
      onTap: () => pageViewController.animateToPage(
        pageViewController.page!.round() - 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: SvgPicture.asset(
          'assets/images/arrow_left.svg',
          semanticsLabel: "Left icon",
        ),
      ),
    );
  }

  Widget _showArrowRight() {
    return GestureDetector(
      onTap: () => pageViewController.animateToPage(
        pageViewController.page!.round() + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: SvgPicture.asset(
          'assets/images/arrow_right.svg',
          semanticsLabel: "Right icon",
        ),
      ),
    );
  }

  Widget _showMonthAndYear(String? month, int? year) {
    return GestureDetector(
      onTap: () => pageViewController.animateToPage(
        pageViewController.initialPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showLeftArrow) _showArrowLeft(),
            ParagraphText(
              text: "$month, $year",
            ),
            if (showRightArrow) _showArrowRight(),
          ],
        ),
      ),
    );
  }
}

class WeekDetails {
  WeekDetails({
    required this.year,
    required this.month,
    required this.days,
    required this.dates,
  });

  int year;
  String month;
  List<int> days;
  List<DateTime> dates;
}
