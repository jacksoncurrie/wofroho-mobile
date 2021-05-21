import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/animations/slide_left_page_transition.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/molecules/empty_state.dart';
import 'package:wofroho_mobile/molecules/secondary_button.dart';
import 'package:wofroho_mobile/organisms/calendar_week_picker.dart';
import 'package:wofroho_mobile/organisms/person_list.dart';
import 'package:wofroho_mobile/pages/edit_week_page.dart';
import 'package:wofroho_mobile/pages/profile_page.dart';
import 'package:wofroho_mobile/pages/settings_page.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/padded_page_template.dart';
import '../theme.dart';

class DetailsPage extends StatefulWidget {
  static String routeName = '/details';

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DateTime? _startWeekDay;
  int _currentDay = 0;
  late DateTime _focusedDay;
  List<int> _outlinedDays = [19, 20];
  late int _weeknumber;

  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    final todaysDate = DateTime.now();
    final mondaysDate =
        todaysDate.subtract(Duration(days: todaysDate.weekday - 1));
    _startWeekDay = mondaysDate;
    _currentDay = todaysDate.day;
    _focusedDay = DateTime(todaysDate.year, todaysDate.month, todaysDate.day);
    _weeknumber = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return PaddedPageTemplate(
      leftRightPadding: width < 340 ? 10 : 25,
      pageWidgets: ActionPageTemplate(
        pageWidgets: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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

  void _settingsPressed() {
    Navigator.of(context).push(
      SlideLeftPageTransition(
        child: SettingsPage(),
      ),
    );
  }

  void _editThisWeek() {
    Navigator.of(context).push(
      FadePageTransition(
        child: EditWeekPage(),
      ),
    );
  }

  Widget _showTopActions() {
    return Align(
      alignment: Alignment.centerRight,
      child: SingleIconButton(
        icon: SvgPicture.asset(
          'assets/images/menu.svg',
          semanticsLabel: "Menu icon",
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
    final newWeekMonday = _startWeekDay!.add(Duration(days: weekNumber * 7));
    setState(() {
      _focusedDay = newWeekMonday;
      _currentDay = weekNumber == 0 ? DateTime.now().day : 0;
      _outlinedDays = weekNumber == 0 ? [19, 20] : [];
      _weeknumber = weekNumber;
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
        showLeftArrow: _weeknumber > 0,
      ),
    );
  }

  Widget _showEditLink() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SecondaryButton(
        text: "Select",
        onPressed: _editThisWeek,
      ),
    );
  }

  Widget _showCompanyTitle() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: ParagraphText(
          text: "Who's wofroho?",
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
    Navigator.of(context).push(
      FadePageTransition(child: profilePage),
    );
  }

  Widget _showPersonList() {
    return StreamBuilder(
      stream: firestore
          .collection('users')
          .where(
            'datesFromHome',
            arrayContains: Timestamp.fromDate(_focusedDay),
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
        final data = snapshot.data as QuerySnapshot;
        final users = data.docs
            .map((i) => Person.fromFirebase(i.data(), i.id, i.id == userId))
            .toList();

        if (users.length == 0) return _showEmptyState();
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: PersonList(
            personTapped: _personTapped,
            people: users,
          ),
        );
      },
    );
  }
}
