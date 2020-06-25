import 'package:flutter/material.dart';
import 'package:weather_built_by_flutter/api/api.dart';
import 'package:weather_built_by_flutter/model/weather_bean.dart';
import 'package:weather_built_by_flutter/model/page_event.dart';
import 'package:weather_built_by_flutter/routers/application.dart';
import 'package:weather_built_by_flutter/routers/routers.dart';
import 'package:weather_built_by_flutter/utilitys/shared_preferences_utility.dart';
import 'package:weather_built_by_flutter/views/first_page_view.dart';
import 'package:weather_built_by_flutter/views/second_page_view.dart';
import 'package:weather_built_by_flutter/widgets/process_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePageView extends StatefulWidget {
  HomePageView();

  @override
  State<StatefulWidget> createState() {
    return _PageState();
  }
}

class _PageState extends State<HomePageView> {
  String city = "";
  String jsondata = "";
  WeatherResult weatherResult;
  int loadState = 2; //0:failed; 1:succeed; 2:loading
  PageController _pageController = new PageController();

  @override
  void initState() {
    super.initState();
    loadWeatherData();
    _pageController.addListener(() {
      if (_pageController.position.pixels ==
          _pageController.position.extentInside) {
        eventBus.fire(PageEvent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (jsondata.isNotEmpty) {
      WeatherBean weatherBean = WeatherBean.fromJson(json.decode(jsondata));
      if (weatherBean.succeed()) {
        loadState = 1;
        weatherResult = weatherBean.result;
      } else {
        loadState = 0;
      }
    }

    return Material(
      child: Column(
        children: <Widget>[
          buildBar(context),
          Expanded(child: _buildPageView())
        ],
      ),
    );
  }

  loadWeatherAssets() async {
    Future<String> future =
        DefaultAssetBundle.of(context).loadString("json/weather_default.json");
    future.then((value) {
      setState(() {
        jsondata = value;
      });
    });
  }

  loadWeatherData() async {
    if (city.isEmpty) {
      await shared_preferences_utility.instance.then((sp) {
        city = sp.get("city");
      });
    }
    if (city == null) city = "杭州";

    final response = await http.get(Api.WEATHER_QUERY + city);
    setState(() {
      jsondata = response.body;
    });
  }

  Widget _buildPageView() {
    if (loadState == 2) {
      return new ProgressView();
    } else if (loadState == 1) {
      return new PageView(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        children: <Widget>[
          FirstPageView(weatherResult),
          SecondPageView(weatherResult)
        ],
      );
    } else {
      return Center(
        child: Column(
          children: <Widget>[
            Icon(Icons.sms_failed),
            SizedBox(height: 10),
            Text("加载失败",
                style: TextStyle(fontSize: 16, color: Color(0xff8a8a8a))),
          ],
        ),
      );
    }
  }

  Widget buildBar(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.only(left: 10, top: MediaQuery.of(context).padding.top),
        height: MediaQuery.of(context).padding.top + 40,
        color: Colors.blueGrey,
        child: GestureDetector(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.edit, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(
                city,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          onTap: () {
            Future future =
                Application.router.navigateTo(context, Routes.cityPage);
            future.then((value) {
              if (value != null) {
                setState(() {
                  loadState = 2;
                });
                city = value.toString();
                loadWeatherData();
                shared_preferences_utility.instance.then((sp) {
                  sp.putString("city", value.toString());
                });
              }
            });
          },
        ));
  }
}
