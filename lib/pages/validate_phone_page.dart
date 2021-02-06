import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/slide_right_transition.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/molecules/link_text.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/pages/account_page.dart';
import 'package:wofroho_mobile/pages/details_page.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

class ValidatePhonePage extends StatefulWidget {
  ValidatePhonePage({
    this.number,
  });

  final String number;

  @override
  _ValidatePhonePageState createState() => _ValidatePhonePageState();
}

class _ValidatePhonePageState extends State<ValidatePhonePage> {
  final codeController = TextEditingController();
  ValidationType validationType;

  bool _validateCode() {
    if (codeController.text.isEmpty) {
      setState(() {
        validationType = ValidationType.error;
      });
      return false;
    }
    return true;
  }

  void _unsetValidation() {
    setState(() {
      validationType = ValidationType.none;
    });
  }

  void _skipPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => DetailsPage(),
      ),
    );
  }

  void _nextPressed() {
    var nextPage = AccountPage();
    Navigator.of(context).pushReplacement(SlideRightTransition(nextPage));
  }

  @override
  void initState() {
    validationType = ValidationType.none;
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
          onPressed: _skipPressed,
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
            if (validationType == ValidationType.error) _showErrorMessage(),
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
          controller: codeController,
          hintText: '123-456',
          keyboardType: TextInputType.number,
          validationType: validationType,
          onChanged: (_) => _unsetValidation(),
        ),
      ),
    );
  }

  Widget _showErrorMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ParagraphText(
        text: 'Code invalid',
        textColor: Theme.of(context).colorScheme.disabledText,
      ),
    );
  }

  Widget _showResend() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: LinkText(
        text: 'Did not get code? Resend.',
        onTap: () {},
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
