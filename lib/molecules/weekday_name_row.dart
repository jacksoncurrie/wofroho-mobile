import 'package:flutter/material.dart';
import 'package:wofroho_mobile/molecules/day_tile.dart';

class WeekdayNameRow extends StatelessWidget {
  WeekdayNameRow({
    this.startDay = 1,
  });

  final int startDay;
  final weekdayNames = {
    1: "Mo",
    2: "Tu",
    3: "We",
    4: "Th",
    5: "Fr",
    6: "Sa",
    7: "Su",
  };

  List<T> _rotate<T>(List<T> list, int v) {
    if (list.isEmpty) return list;
    var i = v % list.length;
    return list.sublist(i)..addAll(list.sublist(0, i));
  }

  @override
  Widget build(BuildContext context) {
    final rotatedWeekdayNames =
        _rotate(weekdayNames.values.toList(), startDay - 1);
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
