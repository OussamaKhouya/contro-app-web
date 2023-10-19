
import 'package:flutter/material.dart';
import 'package:flutter_web/pages/authentication/core/authentication_manager.dart';
import 'package:flutter_web/pages/authentication/model/login_request_model.dart';
import 'package:flutter_web/pages/authentication/service/login_service.dart';
import 'package:flutter_web/routing/routes.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authManager = Get.find();
  }

  Future<void> loginUser(String email, String password) async {
    final response = await _loginService
        .fetchLogin(LoginRequestModel(username: email, password: password));

    if (response != null) {
      /// Set isLogin to true
      _authManager.login(response.token);
      Get.offAllNamed(RootRoute);
    } else {
      /// Show user a dialog about the error response
      Get.defaultDialog(
          middleText: 'Identifiant ou mdf incorrect!',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }

}