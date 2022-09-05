class StudentLoginResponse {
  String? accessToken;
  ChildDetails? childDetails;

  StudentLoginResponse({this.accessToken, this.childDetails});

  StudentLoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    childDetails = json['child_details'] != null
        ? ChildDetails.fromJson(json['child_details'])
        : null;
  }
}

class ChildDetails {
  int? childId;
  String? fullName;
  String? username;
  String? dateOfBirth;
  String? gender;
  int? grade;
  String? school;
  String? country;
  String? state;

  ChildDetails(
      {this.childId,
      this.fullName,
      this.username,
      this.dateOfBirth,
      this.gender,
      this.grade,
      this.school,
      this.country,
      this.state});

  ChildDetails.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    fullName = json['full_name'];
    username = json['username'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    grade = json['grade'];
    school = json['school'];
    country = json['country'];
    state = json['state'];
  }
}
