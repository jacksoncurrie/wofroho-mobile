import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/models/country.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/organisms/country_list_bottom_sheet.dart';
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
  final areaCodeController = TextEditingController();
  final numberController = TextEditingController();
  final countryController = TextEditingController();
  Country country;

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
  void initState() {
    areaCodeController.text = "+64";
    countryController.text = "New Zealand";
    super.initState();
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
                _showCountryField(),
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

  void _showCountryPicker() {
    showCountryListBottomSheet(
      context: context,
      showPhoneCode: true,
      onSelect: (countryPicked) {
        setState(() {
          country = countryPicked;
        });
        countryController.text = countryPicked.name;
        areaCodeController.text = "+${countryPicked.phoneCode}";
      },
    );
  }

  Widget _showCountryField() {
    return FormItemSpace(
      child: DataField(
        title: 'Country',
        child: TextInput(
          controller: countryController,
          hintText: 'Please select country',
          enabled: false,
          onTap: _showCountryPicker,
        ),
      ),
    );
  }

  Widget _showPhoneField() {
    return FormItemSpace(
      child: DataField(
        title: 'Phone number',
        child: Row(
          children: [
            Container(
              width: 80.0,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextInput(
                  controller: areaCodeController,
                  hintText: '+64',
                ),
              ),
            ),
            Expanded(
              child: TextInput(
                controller: numberController,
                hintText: 'Please enter phone number',
              ),
            ),
          ],
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
