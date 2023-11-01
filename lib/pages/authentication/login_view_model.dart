
import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
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
    final userResponse = await _loginService
        .fetchLogin(LoginRequestModel(username: email, password: password));
    print("userResponse");
    print(userResponse);
    if (userResponse != null) {
      /// Set isLogin to true
      // if(userResponse.role == "ADMIN"){
        _authManager.login(userResponse);
        Get.offAllNamed(RootRoute);
      // }else {
      //   Get.defaultDialog(
      //       backgroundColor: light,
      //       title: "Message",
      //       middleText: 'vous n\'êtes pas autorisé à vous connecter',
      //       textConfirm: 'OK',
      //       confirmTextColor: Colors.white,
      //       onConfirm: () {
      //         Get.back();
      //       });
      // }

    } else {
      /// Show user a dialog about the error response
      Get.defaultDialog(
          middleText: 'Identifiant ou mot de passe incorrect!',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }

}