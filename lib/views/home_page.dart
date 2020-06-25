import 'package:flutter/material.dart';
import 'package:weather_built_by_flutter/views/home_page_view.dart';
import 'package:weather_built_by_flutter/views/more_page.dart';

class AppHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<AppHome> {
  int _curIndex = 0;
  List<Widget> _widgets = List();

  @override
  void initState() {
    super.initState();
    _widgets..add(HomePageView())..add(MorePage());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: IndexedStack(
        index: _curIndex,
        children: _widgets,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            title: Text("天气"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            title: Text("更多"),
          ),
        ],
        currentIndex: _curIndex,
        onTap: _itemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff212121),
        selectedItemColor: Color(0xff3d93ee),
        unselectedItemColor: Color(0xff8e8e8e),
        iconSize: 25,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }

  void _itemTapped(int index) {
    setState(() {
      _curIndex = index;
    });
  }
}
