import 'package:flutter/material.dart';
import 'package:weather_built_by_flutter/model/weather_bean.dart';
import 'package:weather_built_by_flutter/model/page_event.dart';
import 'package:weather_built_by_flutter/utilitys/weather_icon_utility.dart';
import 'package:weather_built_by_flutter/widgets/weather_line_widget.dart';
import 'package:weather_built_by_flutter/widgets/process_widget.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';

class SecondPageView extends StatefulWidget {
  final WeatherResult weatherResult;

  SecondPageView(this.weatherResult);

  @override
  State<StatefulWidget> createState() {
    return _PageState();
  }
}

class _PageState extends State<SecondPageView> {
  ScrollController _scrollController = new ScrollController();
  bool top = false;
  StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();
    top = false;
    //滑动属性
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
      } else if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        setState(() {
          top = true;
        });
      } else {
        top = false;
      }
    });
    //滑动事件
    streamSubscription = eventBus.on<PageEvent>().listen((event) {
      setState(() {
        top = false;
      });
    });
    initDayIcon(WeatherIconUtil.getWeatherIconAssetsPath(
        widget.weatherResult.dailys[0].day.img));
    initNightIcon(WeatherIconUtil.getWeatherIconAssetsPath(
        widget.weatherResult.dailys[0].night.img));
  }

  @override
  void dispose() {
    top = false;
    if (streamSubscription != null) {
      streamSubscription.cancel();
    }
    super.dispose();
  }

  bool imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (imageLoaded) {
      return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(image: AssetImage("image/second_page.jpg"),fit: BoxFit.cover,),
          SingleChildScrollView(
            physics: getScrollPhysics(top),
            controller: _scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTitle("24小时预报"),
                _buildLine(),
                _buildHour(widget.weatherResult.hours),
                _buildLine(),
                _buildTitle("7日预报"),
                _buildLine(),
                _buildDaily(
                    widget.weatherResult.dailys, dayImages, nightImages),
                _buildLine(),
                _buildTitle("生活指数"),
                _buildLine(),
                _buildGrid(widget.weatherResult.indexs),
              ],
            ),
          ),
        ],
      );
    } else {
      return ProgressView();
    }
  }

  List<ui.Image> dayImages = [];
  List<ui.Image> nightImages = [];

  Future<Null> initDayIcon(String path) async {
    final ByteData data = await rootBundle.load(path);
    ui.Image image = await loadDayImage(new Uint8List.view(data.buffer));
    dayImages.add(image);
    int length = widget.weatherResult.dailys.length;
    if (dayImages.length < length) {
      var dayNight = widget.weatherResult.dailys[dayImages.length].day;
      initDayIcon(WeatherIconUtil.getWeatherIconAssetsPath(dayNight.img));
    } else {
      if (dayImages.length == length && nightImages.length == length) {
        setState(() {
          imageLoaded = true;
        });
      }
    }
  }

  Future<ui.Image> loadDayImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  initNightIcon(String path) async {
    final ByteData data = await rootBundle.load(path);
    ui.Image image = await loadNightImage(new Uint8List.view(data.buffer));
    nightImages.add(image);
    int length = widget.weatherResult.dailys.length;
    if (nightImages.length < length) {
      var dayNight = widget.weatherResult.dailys[dayImages.length].night;
      initNightIcon(WeatherIconUtil.getWeatherIconAssetsPath(dayNight.img));
    } else {
      if (dayImages.length == length && nightImages.length == length) {
        setState(() {
          imageLoaded = true;
        });
      }
    }
  }

  Future<ui.Image> loadNightImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}

//滑动系数
ScrollPhysics getScrollPhysics(bool top) {
  if (top) {
    return NeverScrollableScrollPhysics();
  } else {
    return BouncingScrollPhysics();
  }
}

Widget _buildTitle(String title) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}

Widget _buildLine({double height, Color color}) {
  return Container(
    height: height == null ? 0.5 : height,
    color: color ?? Colors.white,
  );
}

//24小时预报
Widget _buildHour(List<WeatherHourly> hours) {
  List<Widget> widgets = [];
  for (int i = 0; i < hours.length; i++) {
    widgets.add(_getHourItem(hours[i]));
  }
  return Container(
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widgets,
      ),
    ),
  );
}

Widget _getHourItem(WeatherHourly hourly) {
  return Container(
    height: 110,
    width: 80,
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          hourly.time,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        SizedBox(
          height: 10,
        ),
        Image(
          image:
              AssetImage(WeatherIconUtil.getWeatherIconAssetsPath(hourly.img)),
          height: 30,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          hourly.temp + "℃",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    ),
  );
}

//7日预报
Widget _buildDaily(List<WeatherDaily> dailys, List<ui.Image> dayImages,
    List<ui.Image> nightImages) {
  return Container(
    height: 340,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: WeatherLineWidget(dailys, dayImages, nightImages),
    ),
  );
}

//生活指数
Widget _buildGrid(List<WeatherIndex> indexs) {
  List<Widget> childs = [];
  for (int i = 0; i < indexs.length; i++) {
    childs.add(_getGridItem(indexs[i]));
  }

  return Container(
    child: GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      children: childs,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    ),
  );
}

Widget _getGridItem(WeatherIndex index) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          index.ivalue,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          index.iname,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    ),
  );
}
