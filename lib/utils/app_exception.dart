class AppException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class InternalServerError extends AppException {
  InternalServerError([String? message]) : super(message, "Error: ");
}

class UserNotFoundException extends AppException {
  UserNotFoundException([String? message]) : super(message, "user not found: ");
}

class TokenExpireException extends AppException {
  TokenExpireException([String? message]) : super(message, "Unauthorized: ");
}
