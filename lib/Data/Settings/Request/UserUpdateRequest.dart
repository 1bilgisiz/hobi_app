class UserUpdateRequest {
  final String name;
  final String surname;
  final DateTime birthOfDate;
  final String biography;

  UserUpdateRequest({
    required this.name,
    required this.surname,
    required this.birthOfDate,
    required this.biography,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'birthOfDate': birthOfDate.millisecondsSinceEpoch,
      'biography': biography,
    };
  }
}
