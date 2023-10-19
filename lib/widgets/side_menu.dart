import 'package:flutter/material.dart';
import 'package:flutter_web/constants/controllers.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/helpers/responsiveness.dart';
import 'package:flutter_web/pages/authentication/core/authentication_manager.dart';
import 'package:flutter_web/routing/routes.dart';
import 'package:flutter_web/widgets/custom_text.dart';
import 'package:flutter_web/widgets/side_menu_item.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  late final AuthenticationManager _authManager = Get.find();
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: light,
      child: ListView(children: [
        if(ResponsiveWidget.isSmallScreen(context))
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 40,),
              Row(
                children: [
                  SizedBox(width: _width / 48),
                  Padding(padding: EdgeInsets.only(right: 12),
                    child: Image.asset("assets/icons/logo.png",width: 28),
                  ),
                  const Flexible(child: CustomText(
                    text: "tableau de bord",
                    size: 20,
                    weight: FontWeight.bold,
                    color: active,
                  )
                  ),

                  SizedBox(width: _width / 48,)
                ],
              ),


            ],
          ),


        Divider(color: lightGrey.withOpacity(.1),),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: sideMenuItems.map((item) => SideMenuItem(
            itemName: item.name,
            onTap: (){
              if(item.route == AuthenticationPageRoute){
                menuController.changeActiveitemTo(HomePageDisplayName);
                _authManager.logOut();
                Get.offAllNamed(AuthenticationPageRoute);
              }


              if(!menuController.isActive(item.name)){
                menuController.changeActiveitemTo(item.name);
                if(ResponsiveWidget.isSmallScreen(context)) {
                  Get.back();
                }
                navigationController.navigateTo(item.route);
              }
            },
          )).toList(),
        )
      ],),

    );
  }
}