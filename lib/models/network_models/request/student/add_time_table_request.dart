// To parse this JSON data, do
//
//     final addTimeTableRequest = addTimeTableRequestFromJson(jsonString);

import 'dart:convert';

AddTimeTableRequest addTimeTableRequestFromJson(String str) =>
    AddTimeTableRequest.fromJson(json.decode(str));

String addTimeTableRequestToJson(AddTimeTableRequest data) =>
    json.encode(data.toJson());

class AddTimeTableRequest {
  AddTimeTableRequest({
    this.grade,
    this.section,
    this.description,
    this.day,
    this.startTime,
    this.endTime,
  });

  int? grade;
  String? section;
  String? description;
  String? day;
  String? startTime;
  String? endTime;

  factory AddTimeTableRequest.fromJson(Map<String, dynamic> json) =>
      AddTimeTableRequest(
        grade: json["grade"],
        section: json["section"],
        description: json["description"],
        day: json["day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "grade": grade,
        "section": section,
        "description": description,
        "day": day,
        "start_time": startTime,
        "end_time": endTime,
      };
}
