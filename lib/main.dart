import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/controllers/commande_controller.dart';
import 'package:flutter_web/controllers/custom_menu_controller.dart';
import 'package:flutter_web/controllers/navigation_controller.dart';
import 'package:flutter_web/layout.dart';
import 'package:flutter_web/pages/404/error_page.dart';
import 'package:flutter_web/pages/authentication/authentication.dart';
import 'package:flutter_web/pages/authentication/core/authentication_manager.dart';
import 'package:flutter_web/pages/splash_view.dart';
import 'package:flutter_web/routing/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await GetStorage.init();
  Get.put(CustomMenuController());
  Get.put(CommandeController());
  Get.put(NavigationController());
  Get.put(AuthenticationManager());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AuthenticationPageRoute,
      unknownRoute: GetPage(name: "/not-found", page: () => const PageNotFound(), transition: Transition.fadeIn),
      getPages: [
        // GetPage(name: RootRoute, page: () => SiteLayout()),
        GetPage(name: RootRoute, page: () => SplashView()),
      ],
      debugShowCheckedModeBanner: false,
      title: "Dash",
      theme: ThemeData(
          scaffoldBackgroundColor: light,
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
      // home: SiteLayout(),
      // home: AuthenticationPage(),
    );
  }
}