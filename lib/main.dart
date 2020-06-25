import 'package:flutter/material.dart';
import 'package:weather_built_by_flutter/routers/routers.dart';
import 'package:weather_built_by_flutter/routers/application.dart';
import 'package:weather_built_by_flutter/views/welcome_page.dart';
import 'package:fluro/fluro.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp() {
    final router = new Router();
    Routes.configurRoutes(router);
    Application.router = router;
  }

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Light Weather",
      theme: new ThemeData(
          backgroundColor: Color(0xffffffff),
          textTheme: TextTheme(body1: TextStyle(color: Color(0xff333333)))),
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
    );
  }
}
