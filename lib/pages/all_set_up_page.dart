import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wofroho_mobile/components/primary_button.dart';
import 'package:wofroho_mobile/components/secondary_button.dart';
import 'package:wofroho_mobile/pages/details_page.dart';
import '../theme.dart';

class AllSetUpPage extends StatefulWidget {
  @override
  _AllSetUpPageState createState() => _AllSetUpPageState();
}

class _AllSetUpPageState extends State<AllSetUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.backgroundColor,
      body: LayoutBuilder(builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/confetti.svg',
                    semanticsLabel: "Success confetti",
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/all_set_up.svg',
                              semanticsLabel: "All set up text",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        _showBottomButtons(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _showBottomButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 12,
          child: SecondaryButton(
            text: "Home",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => DetailsPage(),
                ),
              );
            },
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 12,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: PrimaryButton(
              text: "Setup",
              onPressed: () {
                log("Setup");
              },
            ),
          ),
        ),
      ],
    );
  }
}
