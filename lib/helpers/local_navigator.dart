import 'package:flutter/widgets.dart';
import 'package:flutter_web/constants/controllers.dart';
import 'package:flutter_web/routing/router.dart';
import 'package:flutter_web/routing/routes.dart';

Navigator localNavigator() => Navigator(
  key: navigationController.navigationKey,
  initialRoute: OverViewPageRoute,
  onGenerateRoute: generateRoute,
);