import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import '../Widget/jwtkeySecurity.dart';
import 'Constant.dart';

class ApiException implements Exception {
  ApiException(this.errorMessage);

  String errorMessage;
//
  @override
  String toString() {
    return errorMessage;
  }
}

class ApiBaseHelper {
  Future<dynamic> postAPICall(Uri url, Map parameter) async {
    var responseJson;
    print("parameter : $parameter");
    print("url : $url");
    try {
       print("In try Phase");
      final response = await post(
        url,
        body: parameter,
        headers: headers,
      ).timeout(
        const Duration(
          seconds: timeOut,
        ),
      );
      print("status code");
      print(response.statusCode);
      print("response : ${response.body.toString()}");

      print(
          "Parameter = $parameter , API = $url,response : ${response.body.toString()}");
      responseJson = _response(response);
    }catch(e){
      print("catch error");
      print(e.toString());
    }
    // on SocketException {
    //   throw FetchDataException('No Internet connection');
    // } on TimeoutException {
    //   throw FetchDataException('Something went wrong, try again later');
    // }
    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}
