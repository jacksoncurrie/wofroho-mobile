import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/animations/next_page_transition.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/molecules/dialog_popup.dart';
import 'package:wofroho_mobile/molecules/link_text.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/organisms/button_pair.dart';
import 'package:wofroho_mobile/pages/all_set_up_page.dart';
import 'package:wofroho_mobile/pages/create_organisation_page.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

class JoinOrganisationPage extends StatefulWidget {
  JoinOrganisationPage({
    required this.person,
    required this.initialSetup,
  });

  final bool initialSetup;
  final Person person;

  @override
  _JoinOrganisationPageState createState() => _JoinOrganisationPageState();
}

class _JoinOrganisationPageState extends State<JoinOrganisationPage> {
  final _organisationController = TextEditingController();
  ValidationType? _validationType;

  bool _validateCode() {
    if (_organisationController.text.isEmpty) {
      setState(() {
        _validationType = ValidationType.error;
      });
      return false;
    }
    return true;
  }

  void _unsetValidation() {
    if (_validationType != ValidationType.success) {
      setState(() {
        _validationType = ValidationType.success;
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
    Navigator.of(context).pushAndRemoveUntil(
      FadePageTransition(
        LoginPage(),
      ),
      (_) => false,
    );
  }

  void _previousPressed() {
    Navigator.pop(context);
    // Hide keyboard
    FocusScope.of(context).unfocus();
  }

  void _nextPressed() {
    var nextPage = AllSetUpPage();
    Navigator.of(context)
        .pushAndRemoveUntil(NextPageTransition(nextPage), (_) => false);
  }

  void _createOrganisationPressed() {
    var nextPage = CreateOrganisationPage();
    Navigator.of(context).push(FadePageTransition(nextPage));
  }

  @override
  void initState() {
    _validationType = ValidationType.none;
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
          onPressed: _openValidateClose,
        ),
      ),
    );
  }

  Widget _showPageWidgets() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: PageHeadingTemplate(
        title: 'Join an organisation',
        pageWidgets: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _showInformation(),
            _showOrganisationField(),
            _showCreateOrganisation(),
          ],
        ),
      ),
    );
  }

  Widget _showInformation() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ParagraphText(
        text: 'Enter the name of your organisation, or create a new one.',
        fontSize: 20,
      ),
    );
  }

  Widget _showOrganisationField() {
    return FormItemSpace(
      child: DataField(
        title: 'Organisation name',
        child: TextInput(
          controller: _organisationController,
          hintText: 'Please enter organisation name',
          keyboardType: TextInputType.name,
          validationType: _validationType,
          onChanged: (_) => _unsetValidation(),
          textCapitalization: TextCapitalization.words,
        ),
      ),
      validationMessage:
          _validationType == ValidationType.error ? _showErrorMessage() : null,
    );
  }

  Widget _showErrorMessage() {
    return ParagraphText(
      text: 'Organisation not found',
      textColor: Theme.of(context).colorScheme.errorColor,
    );
  }

  Widget _showCreateOrganisation() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: LinkText(
        text: 'Organisation not there? Create it',
        onTap: _createOrganisationPressed,
      ),
    );
  }

  Widget _showBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: widget.initialSetup
          ? ButtonPair(
              primaryText: 'Join',
              primaryOnPressed: () {
                if (_validateCode()) _nextPressed();
              },
              secondaryText: 'Previous',
              secondaryOnPressed: _previousPressed,
            )
          : PrimaryButton(
              text: 'Join',
              onPressed: () {
                if (_validateCode()) _nextPressed();
              },
            ),
    );
  }
}
