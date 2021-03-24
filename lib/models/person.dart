class Person {
  Person({
    this.id,
    required this.imageUrl,
    required this.name,
    required this.role,
    this.datesFromHome,
    this.isUser,
  });

  final String? id;
  final String imageUrl;
  final String name;
  final String role;
  final List<DateTime>? datesFromHome;
  final bool? isUser;
}
