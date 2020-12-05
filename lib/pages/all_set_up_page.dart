import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wofroho_mobile/organisms/button_pair.dart';
import 'package:wofroho_mobile/pages/details_page.dart';
import 'package:wofroho_mobile/templates/input_template.dart';

class AllSetUpPage extends StatefulWidget {
  @override
  _AllSetUpPageState createState() => _AllSetUpPageState();
}

class _AllSetUpPageState extends State<AllSetUpPage> {
  @override
  Widget build(BuildContext context) {
    return InputTemplate(
      pageWidgets: _showPageWidgets(),
      bottomWidget: _showBottomWidget(),
      background: _showBackground(),
    );
  }

  Widget _showPageWidgets() {
    return Center(
      child: SvgPicture.asset(
        'assets/all_set_up.svg',
        semanticsLabel: "All set up text",
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _showBottomWidget() {
    return ButtonPair(
      primaryText: "Setup",
      primaryOnPressed: () {
        log("Setup");
      },
      secondaryText: "Home",
      secondaryOnPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DetailsPage(),
          ),
        );
      },
    );
  }

  Widget _showBackground() {
    return SvgPicture.asset(
      'assets/confetti.svg',
      semanticsLabel: "Success confetti",
      fit: BoxFit.cover,
    );
  }
}
