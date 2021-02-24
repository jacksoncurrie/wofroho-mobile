import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/animations/slide_right_transition.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/notification_toast.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/molecules/dialog_popup.dart';
import 'package:wofroho_mobile/molecules/link_text.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/pages/account_page.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

class ValidatePhonePage extends StatefulWidget {
  ValidatePhonePage({
    @required this.number,
  });

  final String number;

  @override
  _ValidatePhonePageState createState() => _ValidatePhonePageState();
}

class _ValidatePhonePageState extends State<ValidatePhonePage> {
  final _codeController = TextEditingController();
  ValidationType _validationType;
  bool _isResendingCode;
  bool _showNotification;

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
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isResendingCode = false;
    });
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

  void _unsetValidation() {
    if (_validationType != ValidationType.none) {
      setState(() {
        _validationType = ValidationType.none;
      });
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
      FadePageTransition(
        LoginPage(),
      ),
      (_) => false,
    );
  }

  void _nextPressed() {
    var nextPage = AccountPage(
      initialSetup: true,
      person: Person(
        name: '',
        role: '',
        imageUrl: '',
      ),
    );
    Navigator.of(context).pushReplacement(SlideRightTransition(nextPage));
  }

  @override
  void initState() {
    _validationType = ValidationType.none;
    _isResendingCode = false;
    _showNotification = false;
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
              onTap: () async {
                await _resendCode();
                await _showNotificationNow();
              },
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
      ),
    );
  }
}
