import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/atoms/user_image.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/padded_scroll_page_template.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    required this.person,
  });

  final Person person;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _closePressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PaddedScrollPageTemplate(
      pageWidgets: ActionPageTemplate(
        actionWidget: _showCloseAction(),
        pageWidgets: _showPageWidgets(),
      ),
    );
  }

  Widget _showCloseAction() {
    return Align(
      alignment: Alignment.centerRight,
      child: SingleIconButton(
        icon: SvgPicture.asset(
          'assets/images/close.svg',
          semanticsLabel: "Close icon",
        ),
        onPressed: _closePressed,
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
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Hero(
          tag: "${widget.person.id}_image",
          child: UserImage(
            height: 100,
            width: 100,
            image: widget.person.imageUrl == null
                ? null
                : NetworkImage(widget.person.imageUrl!),
            borderRadius: 4,
          ),
        ),
      ),
    );
  }

  Widget _showNameField() {
    return FormItemSpace(
      child: DataField(
        title: 'Name',
        child: Hero(
          tag: "${widget.person.id}_name",
          child: ParagraphText(text: widget.person.name),
        ),
      ),
    );
  }

  Widget _showRoleField() {
    return FormItemSpace(
      child: DataField(
        title: 'Role',
        child: Hero(
          tag: "${widget.person.id}_role",
          child: ParagraphText(text: widget.person.role),
        ),
      ),
    );
  }

  Widget _showOrganisationField() {
    return FormItemSpace(
      child: DataField(
        title: 'Organisation',
        child: ParagraphText(text: 'Wayne Enterprises'),
      ),
    );
  }
}
