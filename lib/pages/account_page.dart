import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/animations/slide_right_transition.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/atoms/user_image.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/molecules/link_text.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/pages/join_organisation_page.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';
import '../theme.dart';

class AccountPage extends StatefulWidget {
  AccountPage({
    @required this.initialSetup,
    @required this.person,
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
        ? Navigator.of(context).pushAndRemoveUntil(
            FadePageTransition(LoginPage()),
            (_) => false,
          )
        : Navigator.pop(context);
  }

  void _nextPressed() {
    widget.initialSetup
        ? Navigator.of(context).push(
            SlideRightTransition(
              JoinOrganisationPage(
                person: widget.person,
                initialSetup: true,
              ),
            ),
          )
        : Navigator.pop(context);
  }

  void _editPhoto() {}

  void _changeOrganisation() {
    var nextPage = JoinOrganisationPage(
      person: widget.person,
      initialSetup: false,
    );
    Navigator.of(context)
        .pushAndRemoveUntil(FadePageTransition(nextPage), (_) => false);
  }

  void _openChangeOrganisation() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: ParagraphText(
            text: "Are you sure you want to change organisation?"),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('Continue'),
            onPressed: _changeOrganisation,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (!widget.initialSetup) {
      _nameController.text = widget.person.name;
      _roleController.text = widget.person.role;
      _organisationController.text = 'Wayne Enterprises';
    }

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
            semanticsLabel: 'Back icon',
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
            image: widget.initialSetup
                ? null
                : NetworkImage(widget.person.imageUrl),
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
        child: TextInput(
          controller: _organisationController,
          onTap: _openChangeOrganisation,
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
