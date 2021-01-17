import 'package:flutter/material.dart';
import 'package:wofroho_mobile/molecules/day_tile.dart';
import '../theme.dart';

class WeekdayNameRow extends StatelessWidget {
  WeekdayNameRow({
    this.startDay = 1,
  });

  final int startDay;
  final List<String> weekdayNames = [
    "Mo",
    "Tu",
    "We",
    "Th",
    "Fr",
    "Sa",
    "Su",
  ];

  List<Object> _rotate(List<Object> list, int v) {
    if (list == null || list.isEmpty) return list;
    var i = v % list.length;
    return list.sublist(i)..addAll(list.sublist(0, i));
  }

  @override
  Widget build(BuildContext context) {
    final rotatedWeekdayNames = _rotate(weekdayNames, startDay - 1);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: rotatedWeekdayNames
          .map((weekdayName) => _showDayTile(context, weekdayName))
          .toList(),
    );
  }

  Widget _showDayTile(BuildContext context, String weekdayName) {
    return DayTile(
      child: weekdayName,
    );
  }
}
