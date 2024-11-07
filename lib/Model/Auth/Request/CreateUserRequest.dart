class CreateUserRequest {
  late String id;
  final String name;
  final String surname;
  final String email;
  final String password;
  final DateTime birthOfDate;
  final String biography;

  CreateUserRequest({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.birthOfDate,
    required this.biography,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name.toLowerCase().trim(),
        'surname': surname.toLowerCase().trim(),
        'email': email.toLowerCase().trim(),
        'birthOfDate': birthOfDate.millisecondsSinceEpoch,
        'biography': biography,
        'hobbies': [],
      };
}
