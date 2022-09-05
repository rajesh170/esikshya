class EditParentDetailsRequest {
  String? fullName;
  String? address;

  EditParentDetailsRequest({this.fullName, this.address});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['address'] = address;
    return data;
  }
}
