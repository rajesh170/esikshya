class ChildDetailRequest {
  ChildDetail? childDetail;

  ChildDetailRequest({this.childDetail});

  ChildDetailRequest.fromJson(Map<String, dynamic> json) {
    childDetail = json['child_detail'] != null
        ? new ChildDetail.fromJson(json['child_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.childDetail != null) {
      data['child_detail'] = this.childDetail!.toJson();
    }
    return data;
  }
}

class ChildDetail {
  String? fullName;
  String? dateOfBirth;
  int? grade;
  String? gender;
  String? school;
  String? country;
  String? state;

  ChildDetail(
      {this.fullName,
      this.dateOfBirth,
      this.grade,
      this.gender,
      this.school,
      this.country,
      this.state});

  ChildDetail.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    dateOfBirth = json['date_of_birth'];
    grade = json['grade'];
    gender = json['gender'];
    school = json['school'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = this.fullName;
    data['date_of_birth'] = this.dateOfBirth;
    data['grade'] = this.grade;
    data['gender'] = this.gender;
    data['school'] = this.school;
    data['country'] = this.country;
    data['state'] = this.state;
    return data;
  }
}
