import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/molecules/empty_state.dart';
import 'package:wofroho_mobile/molecules/link_text.dart';
import 'package:wofroho_mobile/organisms/calendar_week_picker.dart';
import 'package:wofroho_mobile/organisms/person_list.dart';
import 'package:wofroho_mobile/pages/profile_page.dart';
import 'package:wofroho_mobile/pages/settings_page.dart';
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
  List<int> _outlinedDays = [3, 4];

  void _settingsPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => SettingsPage(),
      ),
    );
  }

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
            _showCompanyTitle(),
            Expanded(
              child: _showPersonList(),
            ),
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
        onPressed: _settingsPressed,
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
      _outlinedDays = weekNumber == 0 ? [3, 4] : [];
    });
    HapticFeedback.mediumImpact();
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

  Widget _showCompanyTitle() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: ParagraphText(
          text: "Wayne Enterprises",
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _showEmptyState() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: EmptyState(
        text: "No one is wofroho today",
      ),
    );
  }

  void _personTapped(Person person) {
    var profilePage = ProfilePage(person: person);
    Navigator.of(context).push(FadePageTransition(profilePage));
  }

  Widget _showPersonList() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: PersonList(
        personTapped: _personTapped,
        people: [
          Person(
            id: "1",
            imageUrl: "http://placekitten.com/300/300",
            name: "Bruce Wayne",
            role: "Businessman, entrepreneur, accountant",
            datesFromHome: [
              DateTime.now().add(Duration(days: 2)),
              DateTime.now().add(Duration(days: 3)),
            ],
            isUser: true,
          ),
          Person(
            id: "2",
            imageUrl: "http://placekitten.com/400/320",
            name: "Lucius Fox",
            role: "CEO",
            datesFromHome: [
              DateTime.now().add(Duration(days: 5)),
              DateTime.now().add(Duration(days: 6)),
            ],
            isUser: false,
          ),
        ],
      ),
    );
  }
}
