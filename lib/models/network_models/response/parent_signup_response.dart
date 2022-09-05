class ParentSignUpResponse {
  String? message;
  bool? isVerified;

  ParentSignUpResponse({this.message, this.isVerified});

  ParentSignUpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isVerified = json['is_verified'];
  }
}
