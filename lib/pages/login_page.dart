import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/animations/next_page_transition.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/organisms/country_list_bottom_sheet.dart';
import 'package:wofroho_mobile/pages/details_page.dart';
import 'package:wofroho_mobile/pages/sign_up_page.dart';
import 'package:wofroho_mobile/pages/validate_phone_page.dart';
import 'package:wofroho_mobile/services/authentication.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _areaCodeController = TextEditingController();
  final _numberController = TextEditingController();
  ValidationType? _validationType;
  late bool _loginLoading;
  late BaseAuth _auth;

  @override
  void initState() {
    _areaCodeController.text = "+64";
    _validationType = ValidationType.none;
    _loginLoading = false;
    _auth = Auth();

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
                _showPhoneField(),
              ],
            ),
            bottomWidget: _showBottomWidget(),
          ),
        ),
      ),
    );
  }

  void _signInPressed() async {
    setState(() => _loginLoading = true);
    await _verifyPhoneNumber(
      '${_areaCodeController.text}${_numberController.text}',
    );
  }

  void _automaticVerification(String? userId) async {
    if (userId == null) return;
    await _loginOrSignup(userId);
    setState(() => _loginLoading = false);
  }

  Future<bool> _userExists() async {
    final user = _auth.getCurrentUser();
    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('users').doc(user?.uid).get();
    return doc.exists;
  }

  Future _loginOrSignup(String userId) async {
    if (await _userExists()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('signedUp', true);
      await prefs.setBool('inOrganisation', true);

      Navigator.pushAndRemoveUntil(
        context,
        FadePageTransition(
          child: DetailsPage(),
          routeName: DetailsPage.routeName,
        ),
        (route) => false,
      );
    } else {
      Navigator.pushReplacement(
        context,
        FadePageTransition(
          child: SignUpPage(
            userId: userId,
          ),
        ),
      );
    }
  }

  void _authenticationFailed(FirebaseAuthException e) {
    setState(() {
      _validationType = ValidationType.error;
      _loginLoading = false;
    });
  }

  void _codeSent(String verificationId, int? resendToken) {
    Navigator.push(
      context,
      NextPageTransition(
        child: ValidatePhonePage(
          number: '${_areaCodeController.text}${_numberController.text}',
          verificationId: verificationId,
          resendToken: resendToken,
        ),
      ),
    );
    setState(() => _loginLoading = false);
  }

  Future _verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      automaticVerification: _automaticVerification,
      authenticationFailed: _authenticationFailed,
      codeSent: _codeSent,
      timedOut: () => _authenticationFailed(
        FirebaseAuthException(code: "Timed out"),
      ),
    );
  }

  Widget _showLogo() {
    return Center(
      // Just temporary
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
        _areaCodeController.text = "+${countryPicked.phoneCode}";
      },
      countryFilter: ['NZ'],
    );
  }

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
                  enabled: false,
                  onTap: _showCountryPicker,
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
      validationMessage:
          _validationType == ValidationType.error ? _showErrorMessage() : null,
    );
  }

  Widget _showErrorMessage() {
    return ParagraphText(
      text: 'Phone number is not valid',
      textColor: Theme.of(context).colorScheme.errorColor,
    );
  }

  Widget _showBottomWidget() {
    return PrimaryButton(
      onPressed: () {
        if (_validatePhone()) _signInPressed();
      },
      text: 'Sign In',
      isLoading: _loginLoading,
    );
  }
}
