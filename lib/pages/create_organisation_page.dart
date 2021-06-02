import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/rich_text_paragraph.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/pages/details_page.dart';
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
  ValidationType? _validationType;
  String? _message;
  late bool _createLoading;
  late bool _verifyingLoading;

  @override
  void initState() {
    _validationType = ValidationType.none;
    _createLoading = false;
    _verifyingLoading = false;
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

  Future<bool> _nameExists(String nameLower) async {
    // Check if exists
    final organisation = await FirebaseFirestore.instance
        .collection('organisations')
        .where('nameLower', isEqualTo: nameLower)
        .get();
    return organisation.size != 0;
  }

  Future<bool> _validateCode() async {
    try {
      setState(() {
        _createLoading = true;
      });

      // Test local validation
      if (_organisationController.text.isEmpty) {
        setState(() {
          _message = 'Name can\'t be empty';
          _validationType = ValidationType.error;
        });
        return false;
      }

      if (await _nameExists(_organisationController.text.toLowerCase())) {
        setState(() {
          _message = 'Name already exists';
          _validationType = ValidationType.error;
        });
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      setState(() {
        _message = 'Error checking organisation name';
        _validationType = ValidationType.error;
      });
      return false;
    } finally {
      setState(() {
        _createLoading = false;
      });
    }

    return false;
  }

  void _unsetValidation(String value) async {
    try {
      setState(() {
        _verifyingLoading = true;
      });

      final doesExist =
          await _nameExists(_organisationController.text.toLowerCase());
      if (doesExist) {
        setState(() {
          _message = 'Name already exists';
          _validationType = ValidationType.error;
        });
      } else {
        setState(() {
          _message = 'Name is available';
          _validationType = ValidationType.success;
        });
      }
    } on Exception catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        _verifyingLoading = false;
      });
    }
  }

  void _backPressed() {
    Navigator.pop(context);
    // Hide keyboard
    FocusScope.of(context).unfocus();
  }

  void _createPressed() {
    var nextPage = DetailsPage();
    Navigator.of(context).pushAndRemoveUntil(
      FadePageTransition(
        child: nextPage,
        routeName: DetailsPage.routeName,
      ),
      (_) => false,
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
          ],
        ),
      ),
    );
  }

  Widget _showInformation() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: RichTextParagraph(
        textSpanItems: [
          TextSpanItem(text: 'This will be the name of your '),
          TextSpanItem(text: 'wofroho', fontWeight: FontWeight.bold),
          TextSpanItem(
              text:
                  ' workspace - choose something that your team will recognize.'),
        ],
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
          onChanged: (value) => _unsetValidation(value),
          textCapitalization: TextCapitalization.words,
        ),
      ),
      validationMessage:
          _validationType != ValidationType.none ? _showErrorMessage() : null,
    );
  }

  Widget _showErrorMessage() {
    if (_verifyingLoading) {
      return CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.textOnPrimary,
        ),
      );
    }
    return ParagraphText(
      text: _message,
      textColor: Theme.of(context).colorScheme.disabledText,
    );
  }

  Widget _showBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: PrimaryButton(
        text: 'Create',
        isLoading: _createLoading,
        onPressed: () async {
          if (await _validateCode()) _createPressed();
        },
      ),
    );
  }
}
