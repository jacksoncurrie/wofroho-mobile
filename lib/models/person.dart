import 'package:flutter/foundation.dart';

class Person {
  Person({
    @required this.imageUrl,
    @required this.name,
    @required this.role,
    @required this.datesFromHome,
    @required this.isUser,
  });

  final String imageUrl;
  final String name;
  final String role;
  final List<DateTime> datesFromHome;
  final bool isUser;
}