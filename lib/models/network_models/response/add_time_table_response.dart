class AddTimeTableResponse {
  int? id;
  int? childrenId;
  int? grade;
  String? section;
  String? description;
  String? day;
  String? startTime;
  String? endTime;

  AddTimeTableResponse(
      {this.id,
      this.childrenId,
      this.grade,
      this.section,
      this.description,
      this.day,
      this.startTime,
      this.endTime});

  AddTimeTableResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    childrenId = json['children_id'];
    grade = json['grade'];
    section = json['section'];
    description = json['description'];
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['children_id'] = childrenId;
    data['grade'] = grade;
    data['section'] = section;
    data['description'] = description;
    data['day'] = day;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}
