class ParentRegisterRequest {
  String phone;

  ParentRegisterRequest({required this.phone});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    return data;
  }
}
