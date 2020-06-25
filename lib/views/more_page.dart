import 'package:flutter/material.dart';
import 'package:weather_built_by_flutter/views/aboutme_page.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('更多', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('设置'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('开发中，敬请期待')));
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('关于'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutMePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
