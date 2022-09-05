const String tableName = 'childdetails';

class ChildrenDetailsField {
  static const childId = 'child_id';
  static const fullName = 'full_name';
  static const username = 'username';
  static const dateOfBirth = 'date_of_birth';
  static const grade = 'grade';
  static const gender = 'gender';
  static const school = 'school';
  static const country = 'country';
  static const state = 'state';
}

class ChildrenDetailsResponse {
  late int childId;
  late String fullName;
  late String username;
  late String dateOfBirth;
  late int grade;
  late String gender;
  late String school;
  late String country;
  late String state;

  ChildrenDetailsResponse(
      {required this.childId,
      required this.fullName,
      required this.username,
      required this.dateOfBirth,
      required this.grade,
      required this.gender,
      required this.school,
      required this.country,
      required this.state});

  ChildrenDetailsResponse.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    fullName = json['full_name'];
    username = json['username'];
    dateOfBirth = json['date_of_birth'];
    grade = json['grade'];
    gender = json['gender'];
    school = json['school'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['full_name'] = this.fullName;
    data['username'] = this.username;
    data['date_of_birth'] = this.dateOfBirth;
    data['grade'] = this.grade;
    data['gender'] = this.gender;
    data['school'] = this.school;
    data['country'] = this.country;
    data['state'] = this.state;
    return data;
  }
}
