import 'package:flutter/material.dart';
import 'package:wofroho_mobile/models/person.dart';
import 'package:wofroho_mobile/molecules/person_list_item.dart';

class PersonList extends StatelessWidget {
  PersonList({
    @required this.people,
    this.personTapped,
  });

  final List<Person> people;
  final void Function(Person) personTapped;

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
      image: NetworkImage(person.imageUrl),
      name: person.name,
      role: person.role,
      dates: person.datesFromHome,
      personOutlined: person.isUser,
      onTap: () => personTapped(person),
    );
  }
}
