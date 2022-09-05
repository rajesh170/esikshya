class OTPResponse {
  String? message;
  int? status;
  String? error;
  List<String>? causes;

  OTPResponse({this.message, this.status, this.error, this.causes});

  OTPResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    error = json['error'];
    causes = json['causes'].cast<String>();
  }
}
