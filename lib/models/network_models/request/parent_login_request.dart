class ParentLoginRequest {
  String phone;
  String password;

  ParentLoginRequest({required this.phone, required this.password});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
