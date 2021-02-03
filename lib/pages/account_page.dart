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
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_scroll_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final person = Person(
    id: "1",
    imageUrl: "http://placekitten.com/300/300",
    name: "Bruce Wayne",
    role: "Businessman, entrepreneur, accountant",
  );

  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final organisationController = TextEditingController();

  void _skipPressed() {
    Navigator.pop(context);
  }

  void _savePressed() {
    Navigator.pop(context);
  }

  void _editPhoto() {}

  @override
  void initState() {
    nameController.text = person.name;
    roleController.text = person.role;
    organisationController.text = 'Wayne Enterprises';

    super.initState();
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
        _showRoleField(),
        _showOrganisationField(),
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
            image: NetworkImage(person.imageUrl),
            borderRadius: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: LinkText(
              text: 'Edit photo',
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
        child: TextInput(controller: nameController),
      ),
    );
  }

  Widget _showRoleField() {
    return FormItemSpace(
      child: DataField(
        title: 'Role',
        child: TextInput(controller: roleController),
      ),
    );
  }

  Widget _showOrganisationField() {
    return FormItemSpace(
      child: DataField(
        title: 'Organisation',
        child: TextInput(controller: organisationController),
      ),
    );
  }

  Widget _showBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: PrimaryButton(
        text: 'Save',
        onPressed: _savePressed,
      ),
    );
  }
}
