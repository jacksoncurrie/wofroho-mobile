import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/atoms/user_image.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/molecules/link_text.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

import 'details_page.dart';

class AccountPage extends StatefulWidget {
  AccountPage({
    @required this.initialSetup,
  });

  final bool initialSetup;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _person = Person(
    id: "1",
    imageUrl: "http://placekitten.com/300/300",
    name: "Bruce Wayne",
    role: "Businessman, entrepreneur, accountant",
  );

  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _organisationController = TextEditingController();
  ValidationType _nameValidationType;
  ValidationType _roleValidationType;

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

    if (error) {
      return false;
    }
    return true;
  }

  void _skipPressed() {
    widget.initialSetup
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => LoginPage(),
            ),
          )
        : Navigator.pop(context);
  }

  void _nextPressed() {
    widget.initialSetup
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => DetailsPage(),
            ),
          )
        : Navigator.pop(context);
  }

  void _editPhoto() {}

  @override
  void initState() {
    if (!widget.initialSetup) {
      _nameController.text = _person.name;
      _roleController.text = _person.role;
      _organisationController.text = 'Wayne Enterprises';
    }

    _nameValidationType = ValidationType.none;
    _roleValidationType = ValidationType.none;

    super.initState();
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
            semanticsLabel: "Close icon",
          ),
          onPressed: _skipPressed,
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
            semanticsLabel: "Back icon",
          ),
          onPressed: _skipPressed,
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
        if (_nameValidationType == ValidationType.error)
          _showNameErrorMessage(),
        _showRoleField(),
        if (_roleValidationType == ValidationType.error)
          _showRoleErrorMessage(),
        if (!widget.initialSetup) _showOrganisationField(),
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
            image: widget.initialSetup ? null : NetworkImage(_person.imageUrl),
            borderRadius: 4,
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
        ),
      ),
    );
  }

  Widget _showNameErrorMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ParagraphText(
        text: 'Name is required',
        textColor: Theme.of(context).colorScheme.disabledText,
      ),
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
        ),
      ),
    );
  }

  Widget _showRoleErrorMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ParagraphText(
        text: 'Role is required',
        textColor: Theme.of(context).colorScheme.disabledText,
      ),
    );
  }

  Widget _showOrganisationField() {
    return FormItemSpace(
      child: DataField(
        title: 'Organisation',
        child: TextInput(controller: _organisationController),
      ),
    );
  }

  Widget _showBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: PrimaryButton(
        text: widget.initialSetup ? "Next" : "Save",
        onPressed: () {
          if (_validateInputs()) _nextPressed();
        },
      ),
    );
  }
}
