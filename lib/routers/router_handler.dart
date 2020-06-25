import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:weather_built_by_flutter/views/city_page.dart';
import 'package:weather_built_by_flutter/views/home_page.dart';
import 'package:weather_built_by_flutter/views/more_page.dart';

var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return AppHome();
});

var cityHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return new CityPage();
});

var moreHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return new MorePage();
});
