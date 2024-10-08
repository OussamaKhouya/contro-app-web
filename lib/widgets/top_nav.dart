import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/helpers/responsiveness.dart';
import 'package:flutter_web/pages/authentication/model/login_response_model.dart';
import 'package:flutter_web/widgets/custom_text.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';


AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key, Rx<LoginResponseModel>? currUser) =>


    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 14),
            child: Image.asset(
              "assets/icons/logo.png",
              width: 28,
            ),
          )
        ],
      )
          : IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          key.currentState?.openDrawer();
        },
      ),
      elevation: 0,
      title: Row(
        children: [
          Visibility(
              child: CustomText(
                text: "Control Pro",
                color: lightGrey,
                size: 20,
                weight: FontWeight.bold,
              )),
          Expanded(child: Container()),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: dark.withOpacity(.7),
            ),
            onPressed: () {},
          ),

          Stack(
            children: [
              IconButton(
                  icon: Icon(Icons.notifications, color: dark.withOpacity(.7)),
                  onPressed: () {}),
              Positioned(
                  top: 7,
                  right: 7,
                  child: Container(
                    width: 12,
                    height: 12,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: active,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: light, width: 2)),
                  ))
            ],
          ),

          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),

          SizedBox(
            width: 24,
          ),

          CustomText(text: currUser?.value.name ?? "User" , color: lightGrey,),

          SizedBox(
            width: 16,
          ),

          Container(
            decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(30)),
            child: Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: light,
                child: Icon(Icons.person_outline, color: dark,),),
            ),
          )
        ],
      ),

      iconTheme: IconThemeData(color: dark),
      backgroundColor: Colors.transparent,
    );