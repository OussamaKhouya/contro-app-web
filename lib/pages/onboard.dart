import 'package:flutter/material.dart';
import 'package:flutter_web/constants/controllers.dart';
import 'package:flutter_web/layout.dart';
import 'package:flutter_web/pages/authentication/authentication.dart';
import 'package:flutter_web/pages/authentication/core/authentication_manager.dart';
import 'package:get/get.dart';

import '../routing/routes.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager authManager = Get.find();

    return Obx(() {
       if(authManager.isLogged.value ) {
         menuController.changeActiveitemTo(HomePageDisplayName);
         return SiteLayout();
      }else {
         return const AuthenticationPage();
      }

    });
  }
}
