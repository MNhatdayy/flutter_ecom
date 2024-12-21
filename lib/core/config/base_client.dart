import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'app_exception.dart';
import 'package:http/http.dart' as http;
class BaseClient {
  static const int TIME_OUT_DURATION = 20;
  //get
  Future<dynamic> get(String baseUrl, String api) async{
    var uri = Uri.parse(baseUrl + api);
    try{
      var response = await http.get(uri).timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }
  //post
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = jsonEncode(payloadObj);
    try {
      var response = await http
          .post(
        uri,
        body: payload,
        headers: {"Content-Type": "application/json"}, // Header JSON
      )
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  Future<dynamic> put(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = jsonEncode(payloadObj); // Sử dụng jsonEncode để serialize payloadObj
    try {
      var response = await http
          .put(uri, body: payload, headers: {"Content-Type": "application/json"})
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }
  Future<dynamic> delete(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http
          .delete(uri)
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }



  dynamic _processResponse(http.Response response){
    switch (response.statusCode){
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 400:
         throw BadRequestException(utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 500:
        throw ApiNotRespondingException(utf8.decode(response.bodyBytes), response.request?.url.toString());
      default:
        FetchDataException(utf8.decode(response.bodyBytes), response.request?.url.toString());
    }
  }
}