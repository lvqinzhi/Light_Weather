import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:weather_built_by_flutter/routers/router_handler.dart';

class Routes {
  static String root = '/';
  static String home = "/home";
  static String cityPage = "/city";
  static String morePage = "/more";

  static void configurRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc:
            (BuildContext context, Map<String, List<String>> params) {});
    router.define(home, handler: homeHandler);
    router.define(cityPage, handler: cityHandler);
    router.define(morePage, handler: moreHandler);
  }
}
