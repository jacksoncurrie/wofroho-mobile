import 'package:flutter/material.dart';
import 'package:wofroho_mobile/molecules/day_tile.dart';
import '../theme.dart';

class WeekRow extends StatelessWidget {
  WeekRow({
    @required this.days,
    @required this.dayTapped,
    this.focusedDay,
    this.focusedBackgroundColor,
    this.focusedTextColor,
    this.secondaryDay,
    this.secondaryBackgroundColor,
    this.secondaryTextColor,
    this.outlinedDays,
    this.outlinedColor,
  });

  final List<int> days;
  final void Function(int) dayTapped;
  final int focusedDay;
  final Color focusedBackgroundColor;
  final Color focusedTextColor;
  final int secondaryDay;
  final Color secondaryBackgroundColor;
  final Color secondaryTextColor;
  final List<int> outlinedDays;
  final Color outlinedColor;

  Color _getBackgroundColor(
    BuildContext context,
    int day,
    int focusedDay,
    int secondaryDay,
  ) {
    return day == focusedDay
        ? focusedBackgroundColor ?? Theme.of(context).colorScheme.accent
        : day == secondaryDay
            ? secondaryBackgroundColor ??
                Theme.of(context).colorScheme.inputBackground
            : Colors.transparent;
  }

  Color _getTextColor(
    BuildContext context,
    int day,
    int focusedDay,
    int secondaryDay,
  ) {
    return day == focusedDay
        ? focusedTextColor ?? Theme.of(context).colorScheme.text
        : day == secondaryDay
            ? secondaryTextColor ?? Theme.of(context).colorScheme.disabledText
            : Theme.of(context).colorScheme.disabledText;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((day) => _showDayTile(context, day)).toList(),
    );
  }

  Widget _showDayTile(BuildContext context, int day) {
    return GestureDetector(
      child: DayTile(
        child: day,
        backgroundColor:
            _getBackgroundColor(context, day, focusedDay, secondaryDay),
        textColor: _getTextColor(context, day, focusedDay, secondaryDay),
        borderColor: outlinedDays?.contains(day) ?? false
            ? outlinedColor ?? Theme.of(context).colorScheme.accent
            : null,
      ),
      onTap: () => dayTapped(day),
    );
  }
}
