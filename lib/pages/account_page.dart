import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
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
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import 'package:image_picker/image_picker.dart';
import '../theme.dart';
import 'join_organisation_page.dart';

class AccountPage extends StatefulWidget {
  AccountPage({
    required this.userId,
  });

  final String userId;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _organisationController = TextEditingController();
  late ValidationType _nameValidationType;
  late ValidationType _roleValidationType;
  late bool _nextLoading;
  Person? _savedPerson;
  File? _image;

  @override
  void initState() {
    super.initState();

    _nameValidationType = ValidationType.none;
    _roleValidationType = ValidationType.none;
    _nextLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: SimpleScrollTemplate(
        pageWidgets: InputTemplate(
          pageWidgets: ActionPageTemplate(
            actionWidget: _showBackAction(),
            pageWidgets: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: PageHeadingTemplate(
                title: 'Account',
                pageWidgets: _showPageWidgets(),
              ),
            ),
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

  void _openValidateSave() {
    //Check if changes have been made
    if (_nameController.text == _savedPerson?.name &&
        _roleController.text == _savedPerson?.role) {
      Navigator.pop(context);
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
        Navigator.pop(context);
      },
    );
  }

  Widget _showPageWidgets() {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final futureResult = snapshot.data!;
        final data = futureResult.data();
        _savedPerson = Person.fromFirebase(data ?? {}, widget.userId, true);
        _nameController.text = _savedPerson?.name ?? '';
        _roleController.text = _savedPerson?.role ?? '';
        _organisationController.text = _savedPerson?.organisation ?? '';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _showProfileImage(_savedPerson?.downloadUrl),
            _showNameField(),
            _showRoleField(),
            _showOrganisationField(),
          ],
        );
      },
    );
  }

  Widget _showBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: PrimaryButton(
        text: 'Save',
        onPressed: () {
          if (_validateInputs()) _nextPressed();
        },
        isLoading: _nextLoading,
      ),
    );
  }

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

    return !error;
  }

  void _nextPressed() async {
    setState(() {
      _nextLoading = true;
    });

    try {
      await _updateUserInFirestore();
    } on Exception catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        _nextLoading = false;
      });
    }

    Navigator.pop(context);
  }

  Future _updateUserInFirestore() async {
    if (_savedPerson == null) return;
    _savedPerson!
      ..name = _nameController.text
      ..role = _roleController.text
      ..image = _image;

    await _savedPerson!.editInFirebase();
  }

  _imgFromCamera() async {
    PickedFile? image = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 300,
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);
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
    var nextPage = JoinOrganisationPage(userId: widget.userId);
    Navigator.of(context).pushAndRemoveUntil(
      FadePageTransition(child: nextPage),
      (_) => false,
    );
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

  Widget _showProfileImage(String? imageUrl) {
    return FormItemSpace(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          UserImage(
            height: 100,
            width: 100,
            image: _image != null
                ? FileImage(_image!)
                : NetworkImage(imageUrl ?? '') as ImageProvider<Object>?,
            borderRadius: 4,
            onTap: _editPhoto,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: LinkText(
              text: imageUrl == null ? 'Add photo' : 'Edit photo',
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
}
