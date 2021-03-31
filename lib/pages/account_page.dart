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
import 'package:image_picker/image_picker.dart';
import '../theme.dart';

class AccountPage extends StatefulWidget {
  AccountPage({
    required this.initialSetup,
    required this.person,
  });

  final bool initialSetup;
  final Person person;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _organisationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _appRoleController = TextEditingController();
  ValidationType? _nameValidationType;
  ValidationType? _roleValidationType;
  ValidationType? _imageValidationType;

  void _unsetNameValidation() {
    if (_nameValidationType != ValidationType.none) {
      setState(() {
        _nameValidationType = ValidationType.none;
      });
    }
  }

  void _unsetRoleValidation() {
    if (_roleValidationType != ValidationType.none) {
      setState(() {
        _roleValidationType = ValidationType.none;
      });
    }
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
    if (_image == null) {
      setState(() {
        _imageValidationType = ValidationType.error;
      });
      error = true;
    }

    return !error;
  }

  void _openValidateSave() {
    // Check if changes have been made
    if (_nameController.text == widget.person.name &&
        _roleController.text == widget.person.role) {
      _backPressed();
      return;
    }

    showDialogPopup(
      context: context,
      title: 'Unsaved changes',
      message: 'Would you like to save the changes you have made?',
      primaryText: 'Leave without saving',
      primaryPressed: () {
        // Drop popup
        Navigator.pop(context);
        _backPressed();
      },
    );
  }

  void _openValidateClose() {
    showDialogPopup(
      context: context,
      title: 'Leave setup',
      message: 'Are you sure you want leave the setup?',
      primaryText: 'Continue',
      primaryPressed: _backPressed,
    );
  }

  void _backPressed() {
    widget.initialSetup
        ? Navigator.of(context).pushAndRemoveUntil(
            FadePageTransition(LoginPage()),
            (_) => false,
          )
        : Navigator.pop(context);
  }

  void _nextPressed() {
    widget.initialSetup
        ? Navigator.of(context).push(
            NextPageTransition(
              JoinOrganisationPage(
                person: widget.person,
                initialSetup: true,
              ),
            ),
          )
        : Navigator.pop(context);
  }

  File? _image;

  _imgFromCamera() async {
    PickedFile? image = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 300,
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);
        _imageValidationType = ValidationType.none;
      });
    }
  }

  _imgFromGallery() async {
    PickedFile? image = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 300,
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);
        _imageValidationType = ValidationType.none;
      });
    }
  }

  void _editPhoto() {
    pickImageBottomSheet(
      context: context,
      imgFromGallery: _imgFromGallery,
      imgFromCamera: _imgFromCamera,
    );
  }

  void _changeOrganisation() {
    var nextPage = JoinOrganisationPage(
      person: widget.person,
      initialSetup: false,
    );
    Navigator.of(context)
        .pushAndRemoveUntil(FadePageTransition(nextPage), (_) => false);
  }

  void _openChangeOrganisation() {
    showDialogPopup(
      context: context,
      title: 'Change organisation',
      message: 'Are you sure you want to change organisation?',
      primaryText: 'Continue',
      primaryPressed: _changeOrganisation,
    );
  }

  @override
  void initState() {
    super.initState();

    if (!widget.initialSetup) {
      _nameController.text = widget.person.name;
      _roleController.text = widget.person.role;
      _organisationController.text = 'Wayne Enterprises';
      _appRoleController.text = 'Admin';
    }

    _phoneController.text = '+64123456789';

    _nameValidationType = ValidationType.none;
    _roleValidationType = ValidationType.none;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: SimpleScrollTemplate(
        pageWidgets: InputTemplate(
          pageWidgets: ActionPageTemplate(
            actionWidget:
                widget.initialSetup ? _showCloseAction() : _showBackAction(),
            pageWidgets: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: PageHeadingTemplate(
                title: widget.initialSetup ? 'Create account' : 'Account',
                pageWidgets: _showPageWidgets(),
              ),
            ),
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
            semanticsLabel: 'Close icon',
          ),
          onPressed: _openValidateClose,
        ),
      ),
    );
  }

  Widget _showBackAction() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10),
        child: SingleIconButton(
          icon: SvgPicture.asset(
            'assets/images/back.svg',
            semanticsLabel: 'Back icon',
          ),
          onPressed: _openValidateSave,
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
        _showNumberField(),
        if (!widget.initialSetup) _showOrganisationField(),
        if (!widget.initialSetup) _showAppRoleField(),
      ],
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
            image: (widget.initialSetup
                    ? _image == null
                        ? null
                        : FileImage(_image!)
                    : NetworkImage(widget.person.imageUrl))
                as ImageProvider<Object>?,
            borderRadius: 4,
            onTap: _editPhoto,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: LinkText(
              text: widget.initialSetup ? 'Add photo' : 'Edit photo',
              onTap: _editPhoto,
            ),
          ),
        ],
      ),
      validationMessage: _imageValidationType == ValidationType.error
          ? _showImageErrorMessage()
          : null,
    );
  }

  Widget _showImageErrorMessage() {
    return ParagraphText(
      text: 'Photo is required',
      textColor: Theme.of(context).colorScheme.errorColor,
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

  Widget _showNumberField() {
    return FormItemSpace(
      child: DataField(
        title: 'Phone number',
        child: TextInput(
          enabled: false,
          controller: _phoneController,
        ),
      ),
    );
  }

  Widget _showOrganisationField() {
    return FormItemSpace(
      child: DataField(
        title: 'Organisation',
        child: TextInput(
          controller: _organisationController,
          onTap: _openChangeOrganisation,
          enabled: false,
        ),
      ),
    );
  }

  Widget _showAppRoleField() {
    return FormItemSpace(
      child: DataField(
        title: 'App role',
        child: TextInput(
          controller: _appRoleController,
          enabled: false,
        ),
      ),
    );
  }

  Widget _showBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: PrimaryButton(
        text: widget.initialSetup ? 'Next' : 'Save',
        onPressed: () {
          if (_validateInputs()) _nextPressed();
        },
      ),
    );
  }
}
