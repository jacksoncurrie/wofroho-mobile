import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/paragraph_text.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/molecules/badge.dart';
import 'package:wofroho_mobile/molecules/dialog_popup.dart';
import 'package:wofroho_mobile/organisms/person_list.dart';
import 'package:wofroho_mobile/organisms/requests_list.dart';
import 'package:wofroho_mobile/organisms/tab_group.dart';
import 'package:wofroho_mobile/templates/action_page_template.dart';
import 'package:wofroho_mobile/templates/form_item_space.dart';
import 'package:wofroho_mobile/templates/page_heading_template.dart';
import 'package:wofroho_mobile/templates/simple_template.dart';

class ManageOrganisationPage extends StatefulWidget {
  @override
  _ManageOrganisationPageState createState() => _ManageOrganisationPageState();
}

class _ManageOrganisationPageState extends State<ManageOrganisationPage> {
  int? _tabIndex;
  int? _requests;

  void _skipPressed() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    _tabIndex = 0;
    _requests = 2;

    super.initState();
  }

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

  Widget _showPageWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _showOrganisationField(),
        Expanded(child: _showRequestTab()),
      ],
    );
  }

  Widget _showOrganisationField() {
    return FormItemSpace(
      child: DataField(
        title: 'Organisation name',
        child: ParagraphText(text: 'Wayne Enterprises'),
      ),
    );
  }

  Widget _showRequestsTitle() {
    return Row(
      children: [
        ParagraphText(
          text: 'Requests',
          fontSize: 20,
        ),
        if (_requests! > 0)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Badge(number: _requests),
          ),
      ],
    );
  }

  Widget _showEmployeesTitle() {
    return ParagraphText(
      text: 'Employees',
      fontSize: 20,
    );
  }

  void _tabTapped(int tabIndex) {
    if (tabIndex != _tabIndex) {
      setState(() {
        _tabIndex = tabIndex;
      });
    }
  }

  Widget _showRequestTab() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20.0),
      child: TabGroup(
        selectedTab: _tabIndex,
        tabTitles: [_showRequestsTitle(), _showEmployeesTitle()],
        tabPages: [_showRequestsList(), _showPersonList()],
        tabTapped: _tabTapped,
      ),
    );
  }

  Widget _showRequestsList() {
    return RequestsList(
      people: [
        Person(
          id: "3",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/en/thumb/c/c8/News-batbegins2-2.jpg/170px-News-batbegins2-2.jpg",
          name: "Lucius Fox",
          role: "CEO",
          datesFromHome: [
            DateTime.now().add(Duration(days: 5)),
            DateTime.now().add(Duration(days: 6)),
          ],
          isUser: false,
        ),
        Person(
          id: "4",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/en/thumb/1/19/Bruce_Wayne_%28The_Dark_Knight_Trilogy%29.jpg/220px-Bruce_Wayne_%28The_Dark_Knight_Trilogy%29.jpg",
          name: "Bruce Wayne",
          role: "Businessman, entrepreneur, accountant",
          datesFromHome: [
            DateTime.now().add(Duration(days: 2)),
            DateTime.now().add(Duration(days: 3)),
          ],
          isUser: false,
        ),
      ],
    );
  }

  Widget _showRemoveEmployee() {
    return SvgPicture.asset(
      'assets/images/error.svg',
      semanticsLabel: "Error icon",
    );
  }

  void _openChangeOrganisation(Person person) {
    showDialogPopup(
      context: context,
      title: 'Remove employee',
      message: 'Are you sure you want to remove ${person.name}?',
      primaryText: 'Continue',
      primaryPressed: () => _removeEmployee(person),
    );
  }

  void _removeEmployee(Person person) {
    Navigator.pop(context);
  }

  Widget _showPersonList() {
    return PersonList(
      iconButton: _showRemoveEmployee(),
      iconTapped: _openChangeOrganisation,
      people: [
        Person(
          id: "1",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/en/thumb/1/19/Bruce_Wayne_%28The_Dark_Knight_Trilogy%29.jpg/220px-Bruce_Wayne_%28The_Dark_Knight_Trilogy%29.jpg",
          name: "Bruce Wayne",
          role: "Businessman, entrepreneur, accountant",
          datesFromHome: [
            DateTime.now().add(Duration(days: 2)),
            DateTime.now().add(Duration(days: 3)),
          ],
          isUser: true,
        ),
        Person(
          id: "2",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/en/thumb/c/c8/News-batbegins2-2.jpg/170px-News-batbegins2-2.jpg",
          name: "Lucius Fox",
          role: "CEO",
          datesFromHome: [
            DateTime.now().add(Duration(days: 5)),
            DateTime.now().add(Duration(days: 6)),
          ],
          isUser: false,
        ),
      ],
    );
  }
}
