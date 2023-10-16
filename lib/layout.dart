import 'package:flutter/material.dart';
import 'package:flutter_web/helpers/responsiveness.dart';
import 'package:flutter_web/widgets/large_screen.dart';
import 'package:flutter_web/widgets/side_menu.dart';
import 'package:flutter_web/widgets/small_screen.dart';
import 'package:flutter_web/widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: const Drawer(child: SideMenu(),),
      body: const ResponsiveWidget( smallScreen: SmallScreen(), mediumScreen: LargeScreen(),largeScreen: LargeScreen(),),

    );
  }
}