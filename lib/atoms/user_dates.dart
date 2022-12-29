import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';

class UserDates extends StatelessWidget {
  const UserDates({
    required this.dates,
  });

  final List<DateTime>? dates;

  static final _monthStringFormat = "MMM";

  void _sortDates(List<DateTime> dates) => dates.sort((a, b) => a.compareTo(b));

  String _getDays(List<DateTime> dates) => dates.map((i) => i.day).join(", ");

  String _getMonths(List<DateTime> dates) {
    final format = DateFormat(_monthStringFormat);
    final months = dates.map((i) => format.format(i));
    final distinctMonths = months.toSet();
    return distinctMonths.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    _sortDates(dates!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _showDays(),
        _showMonths(),
      ],
    );
  }

  Widget _showDays() {
    return ParagraphText(
      text: _getDays(dates!),
    );
  }

  Widget _showMonths() {
    return ParagraphText(
      text: _getMonths(dates!),
    );
  }
}
