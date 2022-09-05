// class ParentLoginResponse {
//   String? accessToken;
//   ParentDetails? parentDetails;

//   ParentLoginResponse({this.accessToken, this.parentDetails});

//   ParentLoginResponse.fromJson(Map<String, dynamic> json) {
//     accessToken = json['access_token'];
//     parentDetails = json['parent_details'] != null
//         ? ParentDetails.fromJson(json['parent_details'])
//         : null;
//   }

// }

// class ParentDetails {
//   String? phone;
//   int? parentId;
//   String? fullName;

//   ParentDetails({this.phone, this.parentId, this.fullName});

//   ParentDetails.fromJson(Map<String, dynamic> json) {
//     phone = json['phone'];
//     parentId = json['parent_id'];
//     fullName = json['full_name'];
//   }
// }


// To parse this JSON data, do
//
//     final parentLoginResponse = parentLoginResponseFromJson(jsonString);

import 'dart:convert';

ParentLoginResponse parentLoginResponseFromJson(String str) =>
    ParentLoginResponse.fromJson(json.decode(str));

String parentLoginResponseToJson(ParentLoginResponse data) =>
    json.encode(data.toJson());

class ParentLoginResponse {
  ParentLoginResponse({
    this.accessToken,
    this.parentDetails,
  });

  String? accessToken;
  ParentDetails? parentDetails;

  factory ParentLoginResponse.fromJson(Map<String, dynamic> json) =>
      ParentLoginResponse(
        accessToken: json["access_token"],
        parentDetails: ParentDetails.fromJson(json["parent_details"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "parent_details": parentDetails!.toJson(),
      };
}

class ParentDetails {
  ParentDetails({
    this.phone,
    this.parentId,
    this.fullName,
  });

  String? phone;
  int? parentId;
  String? fullName;

  factory ParentDetails.fromJson(Map<String, dynamic> json) => ParentDetails(
        phone: json["phone"],
        parentId: json["parent_id"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "parent_id": parentId,
        "full_name": fullName,
      };
}

