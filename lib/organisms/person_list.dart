import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wofroho_mobile/atoms/single_icon_button.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/molecules/person_list_item.dart';

class PersonList extends StatelessWidget {
  PersonList({
    required this.people,
    this.personTapped,
    this.iconButton,
    this.iconTapped,
  });

  final List<Person> people;
  final void Function(Person)? personTapped;
  final Widget? iconButton;
  final void Function(Person)? iconTapped;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: people.length,
      itemBuilder: (context, index) {
        final person = people[index];
        return _showPersonListItem(person);
      },
    );
  }

  Widget _showPersonListItem(Person person) {
    return PersonListItem(
      personId: person.id,
      image: NetworkImage(person.imageUrl ?? ''),
      name: person.name ?? '',
      role: person.role ?? '',
      dates: person.datesFromHome,
      endWidget: iconButton == null ? null : _showIconButton(person),
      personOutlined: person.isUser,
      onTap: personTapped == null ? null : () => personTapped!(person),
    );
  }

  Widget _showIconButton(Person person) {
    return SingleIconButton(
      onPressed: () => iconTapped!(person),
      icon: iconButton,
    );
  }
}
