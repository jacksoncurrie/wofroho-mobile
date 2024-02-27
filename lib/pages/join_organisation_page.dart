import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/animations/next_page_transition.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/molecules/dialog_popup.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/pages/all_set_up_page.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

class JoinOrganisationPage extends StatefulWidget {
  const JoinOrganisationPage({
    required this.userId,
  });

  final String userId;

  @override
  _JoinOrganisationPageState createState() => _JoinOrganisationPageState();
}

class _JoinOrganisationPageState extends State<JoinOrganisationPage> {
  final _organisationController = TextEditingController();
  ValidationType? _validationType;
  late String _validationText;
  late bool _joinLoading;
  late bool _verifyLoading;

  @override
  void initState() {
    _validationType = ValidationType.none;
    _validationText = '';
    _joinLoading = false;
    _verifyLoading = false;
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
        child: LoginPage(),
        routeName: LoginPage.routeName,
      ),
      (_) => false,
    );
  }

  Future _addOrganisationToUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('inOrganisation', true);

    final firestore = FirebaseFirestore.instance;
    final organisationQuery = await firestore
        .collection('organisations')
        .where('nameLower',
            isEqualTo: _organisationController.text.toLowerCase())
        .get();
    final organisation = organisationQuery.docs.first.data()['name'].toString();
    await firestore
        .collection('users')
        .doc(widget.userId)
        .update({'organisation': organisation});
  }

  void _nextPressed() {
    var nextPage = AllSetUpPage();
    Navigator.of(context).pushAndRemoveUntil(
      NextPageTransition(child: nextPage),
      (_) => false,
    );
  }

  // void _createOrganisationPressed() {
  //   var nextPage = CreateOrganisationPage();
  //   Navigator.of(context).push(
  //     FadePageTransition(child: nextPage),
  //   );
  // }

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
            // _showCreateOrganisation(),
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
        _joinLoading = true;
      });

      // Check local data
      if (_organisationController.text.isEmpty) {
        setState(() {
          _validationType = ValidationType.error;
          _validationText = 'Name can\'t be empty';
        });
        return false;
      }

      // Check if exists
      if (!await _nameExists(_organisationController.text.toLowerCase())) {
        setState(() {
          _validationType = ValidationType.error;
          _validationText = 'Organisation not found';
        });
        return false;
      }

      await _addOrganisationToUser();
    } on Exception catch (e) {
      log(e.toString());
      setState(() {
        _validationType = ValidationType.error;
        _validationText = 'Error checking organisation name';
      });
      return false;
    } finally {
      setState(() {
        _joinLoading = false;
      });
    }

    return true;
  }

  void _unsetValidation() async {
    try {
      setState(() {
        _verifyLoading = true;
      });

      final doesExist =
          await _nameExists(_organisationController.text.toLowerCase());
      if (doesExist) {
        setState(() {
          _validationType = ValidationType.success;
        });
      } else {
        setState(() {
          _validationText = 'Organisation not found';
          _validationType = ValidationType.error;
        });
      }
    } on Exception catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        _verifyLoading = false;
      });
    }
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
    if (_verifyLoading) {
      return CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.textOnPrimary,
        ),
      );
    }
    return ParagraphText(
      text: _validationText,
      textColor: Theme.of(context).colorScheme.errorColor,
    );
  }

  // Widget _showCreateOrganisation() {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 20.0),
  //     child: LinkText(
  //       text: 'Organisation not there? Create it',
  //       onTap: _createOrganisationPressed,
  //     ),
  //   );
  // }

  Widget _showBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: PrimaryButton(
        text: 'Join',
        isLoading: _joinLoading,
        onPressed: () async {
          if (await _validateCode()) _nextPressed();
        },
      ),
    );
  }
}
