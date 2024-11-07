class HobiUser {
  late String id;
  late String name;
  late String surname;
  late String email;
  late String biography;
  late DateTime birthOfDate;
  late List<String> hobbies;

  HobiUser({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.biography,
    required this.birthOfDate,
    required this.hobbies,
  });

  factory HobiUser.fromJson(Map<String, dynamic> json) {
    return HobiUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      email: json['email'] ?? '',
      biography: json['biography'] ?? '',
      birthOfDate:
          DateTime.fromMillisecondsSinceEpoch(json['birthOfDate'] ?? 0),
      hobbies: List<String>.from(json['hobbies'] ?? []),
    );
  }

  factory HobiUser.withDefault() {
    return HobiUser(
      id: '',
      name: '',
      surname: '',
      email: '',
      biography: '',
      birthOfDate: DateTime(0),
      hobbies: [],
    );
  }
}
