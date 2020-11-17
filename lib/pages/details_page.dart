import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/components/calendar.dart';
import 'package:wofroho_mobile/components/link_button.dart';
import '../theme.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int selectedDayIndex;

  @override
  void initState() {
    selectedDayIndex = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 35.0,
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _showNotifications(),
                  _showSettings(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Calendar(
                selectedDayIndex: selectedDayIndex,
                newDaySelected: (newDayIndex) {
                  setState(() {
                    selectedDayIndex = newDayIndex;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: LinkButton(
                text: "Select this week wofroho",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showNotifications() {
    return GestureDetector(
      onTap: () {
        log("Notifications");
      },
      child: SvgPicture.asset(
        'assets/notification.svg',
        semanticsLabel: "Notifications",
        width: 24,
      ),
    );
  }

  Widget _showSettings() {
    return GestureDetector(
      onTap: () {
        log("Settings");
      },
      child: SvgPicture.asset(
        'assets/settings.svg',
        semanticsLabel: "Settings",
        width: 24,
      ),
    );
  }
}
