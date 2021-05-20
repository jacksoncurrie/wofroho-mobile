import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/child_page_transition.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/notification_toast.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/molecules/dialog_popup.dart';
import 'package:wofroho_mobile/molecules/link_text.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/pages/details_page.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'package:wofroho_mobile/pages/sign_up_page.dart';
import 'package:wofroho_mobile/services/authentication.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

class ValidatePhonePage extends StatefulWidget {
  ValidatePhonePage({
    required this.number,
    required this.verificationId,
    required this.resendToken,
  });

  final String number;
  final String verificationId;
  final int? resendToken;

  @override
  _ValidatePhonePageState createState() => _ValidatePhonePageState();
}

class _ValidatePhonePageState extends State<ValidatePhonePage> {
  final _codeController = TextEditingController();
  late ValidationType _validationType;
  late bool _isResendingCode;
  late bool _showNotification;
  String? _newVerificationId;
  int? _newResendToken;
  late bool _nextLoading;
  late BaseAuth _auth;

  bool _validateCode() {
    if (_codeController.text.isEmpty) {
      setState(() {
        _validationType = ValidationType.error;
      });
      return false;
    }
    return true;
  }

  Future _resendCode() async {
    setState(() {
      _isResendingCode = true;
    });
    await _verifyPhoneNumber(widget.number);
  }

  Future _showNotificationNow() async {
    if (_showNotification == true) return;
    setState(() {
      _showNotification = true;
    });
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _showNotification = false;
    });
  }

  void _automaticVerification(String? userId) async {
    await _loginOrSignup(userId);
    setState(() => _isResendingCode = false);
  }

  void _authenticationFailed(FirebaseAuthException e) {
    setState(() {
      _validationType = ValidationType.error;
      _isResendingCode = false;
    });
  }

  void _codeSent(String verificationId, int? resendToken) {
    setState(() {
      _newVerificationId = verificationId;
      _newResendToken = resendToken;
      _isResendingCode = false;
    });
    _showNotificationNow();
  }

  Future _verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      resendToken: _newResendToken ?? widget.resendToken,
      automaticVerification: _automaticVerification,
      authenticationFailed: _authenticationFailed,
      codeSent: _codeSent,
    );
  }

  Future _verifyCode() async {
    setState(() => _nextLoading = true);
    final verificationId = _newVerificationId ?? widget.verificationId;
    final smsCode = _codeController.text;
    String? userId;
    try {
      userId = await _auth.signIn(verificationId, smsCode);
      await _loginOrSignup(userId);
    } catch (e) {
      setState(() {
        _validationType = ValidationType.error;
        _nextLoading = false;
      });
      return;
    }
    setState(() => _nextLoading = false);
  }

  void _unsetValidation() {
    if (_validationType != ValidationType.none) {
      setState(() {
        _validationType = ValidationType.none;
      });
    }
  }

  Future<bool> _userExists() async {
    final user = _auth.getCurrentUser();
    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('users').doc(user?.uid).get();
    return doc.exists;
  }

  Future _loginOrSignup(String? userId) async {
    if (await _userExists()) {
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
            userId: userId ?? '',
          ),
        ),
      );
    }
  }

  void _openValidateClose() {
    showDialogPopup(
      context: context,
      title: 'Leave setup',
      message: 'Are you sure you want leave the setup?',
      primaryText: 'Continue',
      primaryPressed: _closePressed,
    );
  }

  void _closePressed() {
    // Validate close
    Navigator.of(context).pushAndRemoveUntil(
      ChildPageTransition(
        child: LoginPage(),
        routeName: LoginPage.routeName,
      ),
      (_) => false,
    );
  }

  void _nextPressed() async {
    await _verifyCode();
  }

  @override
  void initState() {
    _validationType = ValidationType.none;
    _nextLoading = false;
    _isResendingCode = false;
    _showNotification = false;
    _auth = Auth();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: SimpleScrollTemplate(
        pageWidgets: InputTemplate(
          pageWidgets: ActionPageTemplate(
            actionWidget: _showCloseAction(),
            pageWidgets: _showPageWidgets(),
          ),
          bottomWidget: _showBottomWidget(),
        ),
      ),
      overlayWidget: _showNotificationWidget(),
    );
  }

  Widget _showNotificationWidget() {
    return NotificationToast(
      child: ParagraphText(
        text: "Code resent",
        textColor: Colors.white,
      ),
      isShown: _showNotification,
      color: Theme.of(context).colorScheme.darkBackground,
    );
  }

  Widget _showCloseAction() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, right: 25),
        child: SingleIconButton(
          icon: SvgPicture.asset(
            'assets/images/close.svg',
            semanticsLabel: "Close icon",
          ),
          onPressed: _openValidateClose,
        ),
      ),
    );
  }

  Widget _showPageWidgets() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: PageHeadingTemplate(
        title: "Check your messages for a code",
        pageWidgets: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _showInformation(),
            _showCodeField(),
            _showResend(),
          ],
        ),
      ),
    );
  }

  Widget _showInformation() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ParagraphText(
        text:
            'We\'ve sent a 6-digit code to ${widget.number}. The code expires shortly, so please enter it soon.',
        fontSize: 20,
      ),
    );
  }

  Widget _showCodeField() {
    return FormItemSpace(
      child: DataField(
        title: 'Enter code',
        child: TextInput(
          controller: _codeController,
          keyboardType: TextInputType.number,
          validationType: _validationType,
          onChanged: (_) => _unsetValidation(),
        ),
      ),
      validationMessage:
          _validationType == ValidationType.error ? _showErrorMessage() : null,
    );
  }

  Widget _showErrorMessage() {
    return ParagraphText(
      text: 'Code invalid',
      textColor: Theme.of(context).colorScheme.errorColor,
    );
  }

  Widget _showLoading() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 5),
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _showResend() {
    return _isResendingCode
        ? _showLoading()
        : Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: LinkText(
              text: 'Did not get code? Resend',
              onTap: _resendCode,
            ),
          );
  }

  Widget _showBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: PrimaryButton(
        text: "Next",
        onPressed: () {
          if (_validateCode()) _nextPressed();
        },
        isLoading: _nextLoading,
      ),
    );
  }
}
