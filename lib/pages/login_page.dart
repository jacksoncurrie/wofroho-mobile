import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/slide_right_transition.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/organisms/country_list_bottom_sheet.dart';
import 'package:wofroho_mobile/pages/validate_phone_page.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _areaCodeController = TextEditingController();
  final _numberController = TextEditingController();
  final _countryController = TextEditingController();
  ValidationType _validationType;

  void _unsetValidation() {
    if (_validationType != ValidationType.none) {
      setState(() {
        _validationType = ValidationType.none;
      });
    }
  }

  bool _validatePhone() {
    var error = false;
    if (!_areaCodeController.text.startsWith('+')) error = true;
    if (_numberController.text.isEmpty) error = true;
    if (error) {
      setState(() {
        _validationType = ValidationType.error;
      });
      return false;
    }
    return true;
  }

  void _signInPressed() {
    var nextPage = ValidatePhonePage(
      number: '${_areaCodeController.text}${_numberController.text}',
    );
    Navigator.of(context).pushReplacement(SlideRightTransition(nextPage));
  }

  @override
  void initState() {
    _areaCodeController.text = "+64";
    _countryController.text = "New Zealand";
    _validationType = ValidationType.none;
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
                if (_validationType == ValidationType.error) _showErrorMessage()
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
        _countryController.text = countryPicked.name;
        _areaCodeController.text = "+${countryPicked.phoneCode}";
      },
    );
  }

  Widget _showCountryField() {
    return FormItemSpace(
      child: DataField(
        title: 'Country',
        child: TextInput(
          controller: _countryController,
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
                  controller: _areaCodeController,
                  hintText: '+64',
                  keyboardType: TextInputType.phone,
                  validationType: _validationType,
                  showIconWithValidation: false,
                  onChanged: (_) => _unsetValidation(),
                ),
              ),
            ),
            Expanded(
              child: TextInput(
                controller: _numberController,
                hintText: 'Please enter phone number',
                keyboardType: TextInputType.phone,
                validationType: _validationType,
                onChanged: (_) => _unsetValidation(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showErrorMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ParagraphText(
        text: 'Phone number is not valid',
        textColor: Theme.of(context).colorScheme.disabledText,
      ),
    );
  }

  Widget _showBottomWidget() {
    return PrimaryButton(
      onPressed: () {
        if (_validatePhone()) _signInPressed();
      },
      text: 'Sign In',
    );
  }
}
