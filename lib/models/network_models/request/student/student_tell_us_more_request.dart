class StudentTellUsMoreRequest {
  String fullName;
  String dateOfBirth;
  String gender;
  String school;
  String country;
  int grade;
  String state;

  StudentTellUsMoreRequest({
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.school,
    required this.grade,
    required this.country,
    required this.state,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['grade'] = grade;
    data['school'] = school;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}
