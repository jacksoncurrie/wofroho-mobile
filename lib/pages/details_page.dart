import 'dart:developer';

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
  late DateTime _startWeekDay;
  late DateTime _currentDay;
  late DateTime _focusedDay;
  late int _weeknumber;
  late bool _editLoading;

  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void initState() {
    final todaysDate = DateTime.now();
    final mondaysDate =
        todaysDate.subtract(Duration(days: todaysDate.weekday - 1));
    _startWeekDay =
        DateTime(mondaysDate.year, mondaysDate.month, mondaysDate.day);
    _currentDay = DateTime(todaysDate.year, todaysDate.month, todaysDate.day);
    _focusedDay = DateTime(todaysDate.year, todaysDate.month, todaysDate.day);
    _weeknumber = 0;
    _editLoading = false;

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

  void _editThisWeek() async {
    try {
      setState(() {
        _editLoading = true;
      });

      final userDoc = await _firestore.collection('users').doc(_user).get();
      final person = Person.fromFirebase(userDoc.data() ?? {}, _user, true);

      Navigator.of(context).push(
        FadePageTransition(
          child: EditWeekPage(
            focusedDays: person.datesFromHome,
            userId: _user,
          ),
        ),
      );
    } on Exception catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        _editLoading = false;
      });
    }
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
    final newWeekMonday = _startWeekDay.add(Duration(days: weekNumber * 7));
    setState(() {
      _focusedDay = newWeekMonday;
      _weeknumber = weekNumber;
    });
    HapticFeedback.mediumImpact();
  }

  Widget _showCalendar() {
    return StreamBuilder<Object>(
      stream: _firestore.collection('users').doc(_user).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        final data = snapshot.data as DocumentSnapshot;
        final person = Person.fromFirebase(data.data() ?? {}, _user, true);

        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: CalendarWeekPicker(
            dayBegin: _startWeekDay,
            dayTapped: _updateWeek,
            secondaryDay: _currentDay,
            weekChanged: _weekChanged,
            focusedDays: [_focusedDay],
            outlinedDays: person.datesFromHome,
            focusedBackgroundColor: Theme.of(context).colorScheme.primaryColor,
            focusedTextColor: Theme.of(context).colorScheme.onPrimary,
            showLeftArrow: _weeknumber > 0,
          ),
        );
      },
    );
  }

  Widget _showEditLink() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SecondaryButton(
        text: "Select",
        onPressed: _editThisWeek,
        isLoading: _editLoading,
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
      stream: _firestore
          .collection('users')
          .where(
            'datesFromHome',
            arrayContains: Timestamp.fromDate(_focusedDay),
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        final data = snapshot.data as QuerySnapshot;
        final users = data.docs
            .map((i) => Person.fromFirebase(i.data(), i.id, i.id == _user))
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
