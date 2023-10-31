
import 'dart:io';

import 'package:flutter_web/constants/constants.dart';
import 'package:flutter_web/pages/authentication/model/login_request_model.dart';
import 'package:flutter_web/pages/authentication/model/login_response_model.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

/// LoginService responsible to communicate with web-server
/// via authenticaton related APIs
class LoginService extends GetConnect {
  final String baseurl = kApiBaseUrl;


  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    String loginUrl = '$baseurl/auth/login';
    final response = await post(loginUrl, model.toJson(),headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    });

    if (response.statusCode == HttpStatus.ok) {
      print("response.body");
      print(response.body);
      return LoginResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }

}
