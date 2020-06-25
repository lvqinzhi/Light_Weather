import 'package:flutter/material.dart';
import 'package:weather_built_by_flutter/model/city.dart';
import 'dart:convert';

class CityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "选择城市",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageState();
  }
}

class _PageState extends State<_HomePage> {
  List<City> citys = [];
  List<City> searchCitys = [];
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCitys();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _buildSearch(),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _getItem(searchCitys[index].city);
            },
            itemCount: searchCitys.length,
          )
        ],
      ),
    );
  }

  loadCitys() async {
    Future<String> future =
        DefaultAssetBundle.of(context).loadString("json/city.json");
    future.then((value) {
      CityBean cityBean = CityBean.fromJson(json.decode(value));
      citys.addAll(cityBean.result);
    });
  }

  Widget _buildSearch() {
    return Container(
      height: 60,
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Color(0xfff3f3f3),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '请输入城市名称',
                        hintStyle: TextStyle(
                          color: Color(0xffaeaeb0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Color(0xff02a8f1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
            onTap: () {
              searchData(_controller.text);
            },
          ),
        ],
      ),
    );
  }

  Widget _getItem(String city) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.only(left: 20),
          color: Color(0xffE8E8E8),
          alignment: Alignment.centerLeft,
          height: 40,
          child:
              Text(city, style: TextStyle(fontSize: 18, color: Colors.black))),
      onTap: () {
        Navigator.of(context).pop(city);
      },
    );
  }

  void searchData(String text) async {
    if (text.isEmpty) {
      setState(() {
        searchCitys.clear();
      });
    } else {
      searchCitys.clear();
      for (City city in citys) {
        if (city.city.contains(text)) {
          searchCitys.add(city);
        }
      }
      setState(() {});
    }
  }
}
