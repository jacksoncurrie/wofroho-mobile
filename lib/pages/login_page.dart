import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/pages/setup_page.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final numberController = TextEditingController();

  void _signInPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => SetupPage(
          initialSetup: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: SimpleScrollTemplate(
        pageWidgets: Padding(
          padding: const EdgeInsets.all(25.0),
          child: InputTemplate(
            pageWidgets: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: _showLogo(),
                ),
                _showPhoneField(),
              ],
            ),
            bottomWidget: _showBottomWidget(),
          ),
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

  Widget _showPhoneField() {
    return FormItemSpace(
      child: DataField(
        title: 'Phone number',
        child: TextInput(
          controller: numberController,
          hintText: 'Please enter phone number',
        ),
      ),
    );
  }

  Widget _showBottomWidget() {
    return PrimaryButton(
      onPressed: _signInPressed,
      text: 'Sign In',
    );
  }
}
