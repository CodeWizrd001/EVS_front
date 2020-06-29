import 'package:evs_app/pages/compare.dart';
import 'package:evs_app/pages/previous.dart';
import 'package:flutter/material.dart';

import 'package:evs_app/pages/charts.dart';
import 'package:evs_app/pages/magnet.dart';
import 'package:evs_app/pages/globals.dart';
import 'package:evs_app/pages/ads.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
      routes: {
        '/magnet': (context) => Magnet(),
        '/chart': (context) => Chart(),
        '/history': (context) => Previous(),
        '/compare': (context) => Compare(),
        '/ad': (context) => Add(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var homePageCont = PageController(
    initialPage: 1,
  );

  var getAdd = Add();

  @override
  void initState() {
    super.initState();
    androidFuture = Info.initInfo();
    getBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            FlatButton(
              child: Text("About"),
              onPressed: () => null,
            ),
            FlatButton(
              child: Text("View Ad"),
              onPressed: () => Navigator.pushNamed(context, '/ad'),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: PageView(
        controller: homePageCont,
        children: [
          ListView(
            children: <Widget>[
              Center(
                child: RaisedButton(
                  onPressed: () => null,
                ),
              ),
            ],
          ),
          MainPage(),
          ListView(
            children: <Widget>[
              Center(
                child: RaisedButton(
                  onPressed: () => null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            RaisedButton(
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                child: Center(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.width / 4,
                          child: Icon(
                            Icons.explore,
                            size: 75,
                          ),
                        ),
                        Text("Get Magnet"),
                      ],
                    ),
                  ),
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, '/magnet'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3 - 90,
            ),
            RaisedButton(
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                child: Center(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.width / 4,
                          child: Icon(
                            Icons.table_chart,
                            size: 75,
                          ),
                        ),
                        Text("Get Chart"),
                      ],
                    ),
                  ),
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, '/chart'),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            RaisedButton(
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                child: Center(
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 4,
                        child: Icon(
                          Icons.history,
                          size: 75,
                        ),
                      ),
                      Text("Get Previous"),
                    ],
                  )),
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, '/history'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3 - 90,
            ),
            RaisedButton(
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                child: Center(
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 4,
                        child: Icon(
                          Icons.remove_circle,
                          size: 75,
                        ),
                      ),
                      Text("Do Nothing"),
                    ],
                  )),
                ),
              ),
              onPressed: () => null,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Container(
            child: FutureBuilder(
              future: androidFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return Text("${androidInfo.androidId}");
                else
                  return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ],
    );
  }
}
