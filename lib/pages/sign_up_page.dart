import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/animations/next_page_transition.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/atoms/user_image.dart';
import 'package:wofroho_mobile/helpers/image_picker_helper.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/molecules/dialog_popup.dart';
import 'package:wofroho_mobile/molecules/link_text.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/organisms/pick_image_bottom_sheet.dart';
import 'package:wofroho_mobile/pages/join_organisation_page.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({
    required this.userId,
  });

  final String userId;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  ValidationType? _nameValidationType;
  ValidationType? _roleValidationType;
  late bool _nextLoading;
  File? _image;

  @override
  void initState() {
    super.initState();

    _nextLoading = false;
    _nameValidationType = ValidationType.none;
    _roleValidationType = ValidationType.none;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: SimpleScrollTemplate(
        pageWidgets: InputTemplate(
          pageWidgets: ActionPageTemplate(
            actionWidget: _showCloseAction(),
            pageWidgets: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: PageHeadingTemplate(
                title: 'Create account',
                pageWidgets: _showPageWidgets(),
              ),
            ),
          ),
          bottomWidget: _showBottomWidget(),
        ),
      ),
    );
  }

  bool _validateInputs() {
    var error = false;
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameValidationType = ValidationType.error;
      });
      error = true;
    }
    if (_roleController.text.isEmpty) {
      setState(() {
        _roleValidationType = ValidationType.error;
      });
      error = true;
    }

    return !error;
  }

  Future _addUserToFirestore() async {
    final person = Person(
      name: _nameController.text,
      role: _roleController.text,
      image: _image,
    );
    await person.addToFirebase();
  }

  void _nextPressed() async {
    setState(() {
      _nextLoading = true;
    });

    try {
      await _addUserToFirestore();
    } on Exception catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        _nextLoading = false;
      });
    }

    Navigator.of(context).push(
      NextPageTransition(
        child: JoinOrganisationPage(),
      ),
    );
  }

  void _goBackToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      FadePageTransition(
        child: LoginPage(),
        routeName: LoginPage.routeName,
      ),
      (_) => false,
    );
  }

  void _openValidateClose() {
    showDialogPopup(
      context: context,
      title: 'Leave setup',
      message: 'Are you sure you want leave the setup?',
      primaryText: 'Continue',
      primaryPressed: _goBackToLogin,
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
            semanticsLabel: 'Close icon',
          ),
          onPressed: _openValidateClose,
        ),
      ),
    );
  }

  Widget _showPageWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _showProfileImage(),
        _showNameField(),
        _showRoleField(),
      ],
    );
  }

  void _editPhoto() {
    pickImageBottomSheet(
      context: context,
      imgFromGallery: () async {
        var newImage = await ImagePickerHelper.imgFromGallery();
        setState(() => _image = newImage);
      },
      imgFromCamera: () async {
        var newImage = await ImagePickerHelper.imgFromCamera();
        setState(() => _image = newImage);
      },
    );
  }

  Widget _showProfileImage() {
    return FormItemSpace(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          UserImage(
            height: 100,
            width: 100,
            image: _image == null ? null : FileImage(_image!),
            borderRadius: 4,
            onTap: _editPhoto,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: LinkText(
              text: _image == null ? 'Add photo' : 'Edit photo',
              onTap: _editPhoto,
            ),
          ),
        ],
      ),
    );
  }

  Widget _showNameField() {
    return FormItemSpace(
      child: DataField(
        title: 'Name',
        child: TextInput(
          controller: _nameController,
          validationType: _nameValidationType,
          onChanged: (_) => _unsetNameValidation(),
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
        ),
      ),
      validationMessage: _nameValidationType == ValidationType.error
          ? _showNameErrorMessage()
          : null,
    );
  }

  Widget _showNameErrorMessage() {
    return ParagraphText(
      text: 'Name is required',
      textColor: Theme.of(context).colorScheme.errorColor,
    );
  }

  void _unsetNameValidation() {
    if (_nameValidationType != ValidationType.none) {
      setState(() {
        _nameValidationType = ValidationType.none;
      });
    }
  }

  Widget _showRoleField() {
    return FormItemSpace(
      child: DataField(
        title: 'Role',
        child: TextInput(
          controller: _roleController,
          validationType: _roleValidationType,
          onChanged: (_) => _unsetRoleValidation(),
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
        ),
      ),
      validationMessage: _roleValidationType == ValidationType.error
          ? _showRoleErrorMessage()
          : null,
    );
  }

  Widget _showRoleErrorMessage() {
    return ParagraphText(
      text: 'Role is required',
      textColor: Theme.of(context).colorScheme.errorColor,
    );
  }

  void _unsetRoleValidation() {
    if (_roleValidationType != ValidationType.none) {
      setState(() {
        _roleValidationType = ValidationType.none;
      });
    }
  }

  Widget _showBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: PrimaryButton(
        text: 'Next',
        onPressed: () {
          if (_validateInputs()) _nextPressed();
        },
        isLoading: _nextLoading,
      ),
    );
  }
}
