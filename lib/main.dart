import 'package:flutter/material.dart';
import 'package:flutter_web/controllers/custom_menu_controller.dart';
import 'package:flutter_web/controllers/navigation_controller.dart';
import 'package:flutter_web/layout.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  Get.put(CustomMenuController());
  Get.put(NavigationController());
  runApp( const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dash",
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.mulishTextTheme(
              Theme.of(context).textTheme
          ).apply(
              bodyColor: Colors.black
          ),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
          }),
          primaryColor: Colors.blue
      ),
      home: SiteLayout(),
    );
  }
}