import 'package:flutter/material.dart';
import 'package:flutter_web/pages/cmd/cmd.dart';
import 'package:flutter_web/pages/overview/overview.dart';
import 'package:flutter_web/routing/routes.dart';

import 'package:flutter_web/pages/gallery/gallery.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePageRoute:
      return _getPageRoute(OverViewPage());
    case CmdPageRoute:
      return _getPageRoute(CmdPage());
    case GalleryPageRoute:
      return _getPageRoute(GalleryPage());
    default:
      return _getPageRoute(OverViewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}