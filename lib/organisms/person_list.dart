import 'package:flutter/material.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/molecules/person_list_item.dart';

class PersonList extends StatelessWidget {
  PersonList({
    @required this.people,
  });

  final List<Person> people;

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
      image: NetworkImage(person.imageUrl),
      name: person.name,
      role: person.role,
      dates: person.datesFromHome,
      personOutlined: person.isUser,
    );
  }
}
