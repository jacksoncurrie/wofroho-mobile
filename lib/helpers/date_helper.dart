class DateHelper {
  static List<DateTime> getDatesFromDate(
      List<DateTime> dates, List<DateTime> datesCompare) {
    final dateList = <DateTime>[];
    for (final date in dates) {
      if (datesCompare.contains(date)) dateList.add(date);
    }
    return dateList;
  }

  static List<int> getDaysFromDate(
      List<DateTime> dates, List<DateTime> datesCompare) {
    final dateList = <int>[];
    for (final date in dates) {
      final dateInt = getDayFromDateTime(date, datesCompare);
      if (dateInt != null) dateList.add(dateInt);
    }
    return dateList;
  }

  static int? getDayFromDateTime(DateTime dateTime, List<DateTime> dates) {
    if (!dates.contains(dateTime)) return null;
    return dateTime.day;
  }
}
