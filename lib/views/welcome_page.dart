import 'package:flutter/material.dart';
import 'package:weather_built_by_flutter/views/home_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AppHome()),
          (route) => route == null);
    });

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 200),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Welcome to Light Weather",
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.blue,
                            fontStyle: FontStyle.normal),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
