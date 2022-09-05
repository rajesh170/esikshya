import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:esikshya/utils/app_exception.dart';

class NetworkBase {
  final String _baseUrl =
      "https://499d-2400-1a00-b050-9112-9892-be0a-8e99-5c0b.ngrok.io/";

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  Map<String, String> _headerAddToken(String token) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
  }

  Future<dynamic> get(String endPoint,
      {required bool needToken, String? token}) async {
    // ignore: prefer_typing_uninitialized_variables
    var _responseJson;
    try {
      if (needToken == true) {
        final _response = await http.get(Uri.parse(_baseUrl + endPoint),
            headers: {'Authorization': "Bearer " + token!});
        _responseJson = _returnResponse(_response);
      } else if (needToken == false) {
        final _response = await http.get(Uri.parse(_baseUrl + endPoint));
        _responseJson = _returnResponse(_response);
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    // on TokenExpireException {
    //   NetworkCalls.silentRefresh();
    // }
    return _responseJson;
  }

  Future<dynamic> post(String endPoint, Map body,
      {bool needToken = false, String? token}) async {
    print('Api Post, url $endPoint');
    var _responseJson;
    try {
      print(json.encode(body));
      final _response = await http.post(Uri.parse(_baseUrl + endPoint),
          body: json.encode(body),
          headers: needToken ? _headerAddToken(token!) : _headers);
      _responseJson = _returnResponse(_response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    //  on TokenExpireException {
    //   NetworkCalls.silentRefresh();
    // }
    return _responseJson;
  }

  Future<dynamic> patch(String endPoint, dynamic body,
      {bool needToken = false, String? token}) async {
    print('Api Patch, url $endPoint');
    var _responseJson;
    try {
      log(json.encode(body).toString());
      log(json.encode(token).toString());
      final _response = await http.patch(Uri.parse(_baseUrl + endPoint),
          body: json.encode(body),
          headers: needToken ? _headerAddToken(token!) : _headers);
      _responseJson = _returnResponse(_response);
      return _responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> put(String endPoint, dynamic body,
      {bool needToken = false, String? token}) async {
    print('Api Put, url $endPoint');
    var _responseJson;
    try {
      final _response = await http.put(Uri.parse(_baseUrl + endPoint),
          body: json.encode(body),
          headers: needToken ? _headerAddToken(token!) : _headers);
      _responseJson = _returnResponse(_response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    //  on TokenExpireException {
    //   NetworkCalls.silentRefresh();
    // }
    return _responseJson;
  }

  Future<dynamic> delete(String endPoint, dynamic body,
      {bool needToken = false, String? token}) async {
    print('Api delete, url $endPoint');
    var apiResponse;
    try {
      final _response = await http.delete(Uri.parse(_baseUrl + endPoint),
          body: json.encode(body),
          headers: needToken ? _headerAddToken(token!) : _headers);

      apiResponse = _returnResponse(_response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    // on TokenExpireException {
    //   NetworkCalls.silentRefresh();
    // }
    return apiResponse;
  }

  jsonEncode(Map body) {}
}

dynamic _returnResponse(http.Response _response) {
  print(_response.request);
  print(_response.statusCode);
  // print(_response.body);
  switch (_response.statusCode) {
    case 200:
      var _responseJson = json.decode(_response.body);
      return _responseJson;
    case 201:
      var _responseJson = json.decode(_response.body);
      return _responseJson;

    case 202:
      var _responseJson = json.decode(_response.body);
      return _responseJson;
    case 204:
      return {"message": "deleted successfully"};

    case 400:
      Map jsonResponse = json.decode(_response.body);
      throw BadRequestException(jsonResponse["message"]);
    case 401:
      Map jsonResponse = json.decode(_response.body);
      throw UnauthorisedException(jsonResponse["message"]);
    case 403:
      Map jsonResponse = json.decode(_response.body);
      throw UnauthorisedException(jsonResponse["error"]);
    case 404:
      Map jsonResponse = json.decode(_response.body);
      throw UserNotFoundException(jsonResponse["error"]);
    case 500:
      Map jsonResponse = json.decode(_response.body);
      throw InternalServerError(jsonResponse["error"]);

    default:
      throw FetchDataException(
          'Error occured with StatusCode : ${_response.statusCode.toString()}');
  }
}
