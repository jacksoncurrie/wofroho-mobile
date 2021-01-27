import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/molecules/link_text.dart';
import 'package:wofroho_mobile/organisms/calendar_week_picker.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/padded_page_template.dart';
import '../theme.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DateTime _startWeekDay;
  int _currentDay = 0;
  DateTime _focusedDay;
  List<int> _outlinedDays = [27, 28];

  @override
  void initState() {
    final todaysDate = DateTime.now();
    final mondaysDate =
        todaysDate.subtract(Duration(days: todaysDate.weekday - 1));
    _startWeekDay = mondaysDate;
    _currentDay = todaysDate.day;
    _focusedDay = todaysDate;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PaddedPageTemplate(
      pageWidgets: ActionPageTemplate(
        pageWidgets: Column(
          children: [
            _showCalendar(),
            _showEditLink(),
          ],
        ),
        actionWidget: _showTopActions(),
      ),
    );
  }

  Widget _showTopActions() {
    return Align(
      alignment: Alignment.centerRight,
      child: SingleIconButton(
        icon: SvgPicture.asset(
          'assets/images/settings.svg',
          semanticsLabel: "Settings icon",
        ),
        onPressed: () {},
      ),
    );
  }

  void _updateWeek(DateTime day) {
    setState(() => _focusedDay = day);
  }

  void _weekChanged(int weekNumber) {
    // Get new weeks monday
    final newWeekMonday = _startWeekDay.add(Duration(days: weekNumber * 7));
    setState(() {
      _focusedDay = newWeekMonday;
      _currentDay = weekNumber == 0 ? DateTime.now().day : 0;
      _outlinedDays = weekNumber == 0 ? [27, 28] : [];
    });
  }

  Widget _showCalendar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CalendarWeekPicker(
        dayBegin: _startWeekDay,
        dayTapped: _updateWeek,
        secondaryDay: _currentDay,
        weekChanged: _weekChanged,
        focusedDays: [_focusedDay.day],
        outlinedDays: _outlinedDays,
        focusedBackgroundColor: Theme.of(context).colorScheme.primaryColor,
        focusedTextColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  Widget _showEditLink() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: LinkText(
        text: "Edit this week wofroho",
        onTap: () {},
      ),
    );
  }
}
