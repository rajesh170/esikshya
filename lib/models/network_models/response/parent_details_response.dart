class ParentDetailsResponse {
  ParentDetail? parentDetail;

  ParentDetailsResponse({this.parentDetail});

  ParentDetailsResponse.fromJson(Map<String, dynamic> json) {
    parentDetail = json['parent_detail'] != null
        ? new ParentDetail.fromJson(json['parent_detail'])
        : null;
  }
}

class ParentDetail {
  String? fullName;
  String? address;
  String? parentsCode;

  ParentDetail({this.fullName, this.address, this.parentsCode});

  ParentDetail.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    address = json['address'];
    parentsCode = json['parents_code'];
  }
}
