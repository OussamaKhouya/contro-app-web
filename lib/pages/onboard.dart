import 'package:flutter/material.dart';
import 'package:flutter_web/layout.dart';
import 'package:flutter_web/pages/authentication/authentication.dart';
import 'package:flutter_web/pages/authentication/core/authentication_manager.dart';
import 'package:get/get.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager _authManager = Get.find();

    return Obx(() {
      return _authManager.isLogged.value ? SiteLayout() : const AuthenticationPage();
    });
  }
}
