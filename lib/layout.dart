import 'package:flutter/material.dart';
import 'package:flutter_web/helpers/responsiveness.dart';
import 'package:flutter_web/pages/authentication/core/authentication_manager.dart';
import 'package:flutter_web/widgets/large_screen.dart';
import 'package:flutter_web/widgets/side_menu.dart';
import 'package:flutter_web/widgets/small_screen.dart';
import 'package:flutter_web/widgets/top_nav.dart';
import 'package:get/get.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late final AuthenticationManager _authManager = Get.find();

  SiteLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldKey,_authManager.currUser),
      drawer: Drawer(child: SideMenu(),),
      body: const ResponsiveWidget( smallScreen: SmallScreen(), mediumScreen: LargeScreen(),largeScreen: LargeScreen(),),
    );
  }
}