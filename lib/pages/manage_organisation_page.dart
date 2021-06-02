import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/organisms/person_list.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';

class ManageOrganisationPage extends StatefulWidget {
  ManageOrganisationPage({
    required this.userId,
  });

  final String userId;

  @override
  _ManageOrganisationPageState createState() => _ManageOrganisationPageState();
}

class _ManageOrganisationPageState extends State<ManageOrganisationPage> {
  @override
  Widget build(BuildContext context) {
    return SimpleTemplate(
      pageWidgets: ActionPageTemplate(
        actionWidget: _showBackAction(),
        pageWidgets: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: PageHeadingTemplate(
            title: 'Organisation',
            pageWidgets: _showPageWidgets(),
          ),
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

  void _skipPressed() {
    Navigator.pop(context);
  }

  Widget _showPageWidgets() {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final futureResult = snapshot.data as DocumentSnapshot;
        final data = futureResult.data();
        final organisation = data?['organisation'] ?? '';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _showOrganisationField(organisation),
            Expanded(child: _showRequestTab(organisation)),
          ],
        );
      },
    );
  }

  Widget _showOrganisationField(String organisation) {
    return FormItemSpace(
      child: DataField(
        title: 'Organisation name',
        child: ParagraphText(text: organisation),
      ),
    );
  }

  Widget _showRequestTab(String organisation) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20.0),
      child: _showPersonList(organisation),
    );
  }

  Widget _showPersonList(String organisation) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('organisation', isEqualTo: organisation)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data as QuerySnapshot;
        final people = data.docs
            .map((i) =>
                Person.fromFirebase(i.data(), i.id, widget.userId == i.id))
            .toList();

        return PersonList(
          people: people,
          iconButton: SizedBox.shrink(),
        );
      },
    );
  }
}
