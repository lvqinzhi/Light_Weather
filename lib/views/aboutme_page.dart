import 'package:flutter/material.dart';

class AboutMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String source = "https://github.com/lvqinzhi/Light_Weather-Flutter";
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "关于",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "项目地址:",
                style: TextStyle(color: Color(0xff333333), fontSize: 16),
              ),
              Text(
                source,
                style: TextStyle(color: Color(0xff555555), fontSize: 14),
              ),
              Spacer(flex: 1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Version 1.0.1",
                        style: TextStyle(color: Color(0xff555555), fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "使用",
                        style: TextStyle(color: Color(0xff333333), fontSize: 16),
                      ),
                      Image.asset("image/flutter_logo.png",
                          alignment: Alignment.bottomCenter,
                          width: 80,
                          fit: BoxFit.contain),
                      Text(
                        "技术构建",
                        style: TextStyle(color: Color(0xff333333), fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
