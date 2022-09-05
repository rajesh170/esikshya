class StudentVerifyParentRequest {
  String phone;
  String otp;

  StudentVerifyParentRequest({required this.phone, required this.otp});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['otp'] = otp;
    return data;
  }
}
