class ParentChildDetailsResponse {
  int? childId;
  String? fullName;
  String? username;
  String? dateOfBirth;
  int? grade;
  String? gender;
  String? school;
  String? country;
  String? state;

  ParentChildDetailsResponse(
      { this.childId,
      this.fullName,
      this.username,
      this.dateOfBirth,
      this.grade,
      this.gender,
      this.school,
      this.country,
      this.state});

  ParentChildDetailsResponse.fromJson(Map<String, dynamic> json) {
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
}
