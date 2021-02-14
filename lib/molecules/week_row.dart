import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wofroho_mobile/molecules/day_tile.dart';
import '../theme.dart';

class WeekRow extends StatelessWidget {
  WeekRow({
    @required this.days,
    @required this.dayTapped,
    this.focusedDays,
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
  final List<int> focusedDays;
  final Color focusedBackgroundColor;
  final Color focusedTextColor;
  final int secondaryDay;
  final Color secondaryBackgroundColor;
  final Color secondaryTextColor;
  final List<int> outlinedDays;
  final Color outlinedColor;

  void _dayTappedInitial(int day) {
    HapticFeedback.mediumImpact();
    dayTapped(day);
  }

  Color _getBackgroundColor(
    BuildContext context,
    int day,
    List<int> focusedDays,
    int secondaryDay,
  ) {
    return focusedDays.contains(day)
        ? focusedBackgroundColor ?? Theme.of(context).colorScheme.accent
        : day == secondaryDay
            ? secondaryBackgroundColor ??
                Theme.of(context).colorScheme.inputBackground
            : Colors.transparent;
  }

  Color _getTextColor(
    BuildContext context,
    int day,
    List<int> focusedDays,
    int secondaryDay,
  ) {
    return focusedDays.contains(day)
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
    return InkWell(
      child: DayTile(
        child: day.toString(),
        backgroundColor:
            _getBackgroundColor(context, day, focusedDays, secondaryDay),
        textColor: _getTextColor(context, day, focusedDays, secondaryDay),
        borderColor: outlinedDays?.contains(day) ?? false
            ? outlinedColor ?? Theme.of(context).colorScheme.accent
            : null,
      ),
      onTap: () => _dayTappedInitial(day),
    );
  }
}
