import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/slide_right_transition.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/pages/all_set_up_page.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

class CreateOrganisationPage extends StatefulWidget {
  @override
  _CreateOrganisationPageState createState() => _CreateOrganisationPageState();
}

class _CreateOrganisationPageState extends State<CreateOrganisationPage> {
  final _organisationController = TextEditingController();
  ValidationType _validationType;
  String _message;

  bool _validateCode() {
    if (_organisationController.text.isEmpty) {
      setState(() {
        _message = 'Name is taken';
        _validationType = ValidationType.error;
      });
      return false;
    }
    return true;
  }

  void _unsetValidation() {
    if (_validationType != ValidationType.success) {
      setState(() {
        _message = 'Name is available';
        _validationType = ValidationType.success;
      });
    }
  }

  void _backPressed() {
    Navigator.pop(context);
    // Hide keyboard
    FocusScope.of(context).unfocus();
  }

  void _createPressed() {
    var nextPage = AllSetUpPage();
    Navigator.of(context)
        .pushAndRemoveUntil(SlideRightTransition(nextPage), (_) => false);
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
            actionWidget: _showBackAction(),
            pageWidgets: _showPageWidgets(),
          ),
          bottomWidget: _showBottomWidget(),
        ),
      ),
    );
  }

  Widget _showBackAction() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15),
        child: SingleIconButton(
          icon: SvgPicture.asset(
            'assets/images/back.svg',
            semanticsLabel: "Back icon",
          ),
          onPressed: _backPressed,
        ),
      ),
    );
  }

  Widget _showPageWidgets() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: PageHeadingTemplate(
        title: 'Create an organisation',
        pageWidgets: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _showInformation(),
            _showOrganisationField(),
            if (_validationType != ValidationType.none) _showErrorMessage(),
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
            'This will be the name of your wofroho workspace - choose something that your team will recognize.',
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
          keyboardType: TextInputType.number,
          validationType: _validationType,
          onChanged: (_) => _unsetValidation(),
        ),
      ),
    );
  }

  Widget _showErrorMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ParagraphText(
        text: _message,
        textColor: Theme.of(context).colorScheme.disabledText,
      ),
    );
  }

  Widget _showBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: PrimaryButton(
        text: 'Create',
        onPressed: () {
          if (_validateCode()) _createPressed();
        },
      ),
    );
  }
}