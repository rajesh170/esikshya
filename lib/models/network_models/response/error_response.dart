class ErrorResponse {
  String? message;
  int? status;
  String? error;
  String? causes;

  ErrorResponse({this.message, this.status, this.error, this.causes});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    error = json['error'];
    causes = json['causes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['error'] = error;
    data['causes'] = causes;
    return data;
  }
}
