class ParentSetPasswordResponse {
  String? message;

  ParentSetPasswordResponse({this.message});

  ParentSetPasswordResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
