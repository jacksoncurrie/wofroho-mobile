import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/molecules/sign_in_button.dart';
import 'package:wofroho_mobile/pages/all_set_up_page.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _loginWithMicrosoft() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => AllSetUpPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: _showLogo(),
            ),
            _showSignInWithMicrosoft(),
          ],
        ),
      ),
    );
  }

  Widget _showLogo() {
    return Center(
      child: SvgPicture.asset(
        'assets/images/wofroho_logo_full.svg',
        semanticsLabel: "Wofroho logo",
      ),
    );
  }

  Widget _showSignInWithMicrosoft() {
    return SignInButton(
      text: "Sign in with Microsoft",
      image: SvgPicture.asset(
        'assets/images/microsoft_logo.svg',
        semanticsLabel: "Microsft logo",
      ),
      onPressed: _loginWithMicrosoft,
    );
  }
}
