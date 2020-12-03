import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'details_page.dart';
import '../components/input_field.dart';
import '../components/primary_button.dart';
import '../components/secondary_button.dart';
import '../components/link_button.dart';
import '../theme.dart';

class LoginEmailPage extends StatefulWidget {
  @override
  _LoginEmailPageState createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
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
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(
                      child: _showLogo(),
                    ),
                    InputField(
                      label: "Email",
                      hint: "Please enter email",
                    ),
                    InputField(
                      label: "Password",
                      hint: "Please enter password",
                    ),
                    LinkButton(
                      text: "Forgot details?",
                      onPressed: () {
                        log("Forgot details");
                      },
                    ),
                    Flexible(
                      child: _showBottomButtons(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _showLogo() {
    return Center(
      child: SvgPicture.asset(
        'assets/wofroho_logo_full.svg',
        semanticsLabel: "Wofroho logo",
      ),
    );
  }

  Widget _showBottomButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PrimaryButton(
          text: "Sign in",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => DetailsPage(),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SecondaryButton(
            text: "Do not have an account?",
            onPressed: () {
              log("Create account");
            },
          ),
        ),
      ],
    );
  }
}
