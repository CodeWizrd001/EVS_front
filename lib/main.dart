import 'package:evs_app/pages/about.dart';
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
      title: 'Radiation Detector',
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
        '/about': (context) => About(),
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

  @override
  void initState() {
    super.initState();
    if (!init) {
      androidFuture = Info.initInfo();
      init = true;
    }
    getBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getId() {
    if (androidInfo == null) return "id";
    return androidInfo.androidId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 35,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 18.5,
                        ),
                        Text("Coins : $coins"),
                        FlatButton(
                          child: Icon(Icons.refresh),
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Text("Unique ID : ${getId()}")
                  ],
                ),
              ),
              FlatButton(
                child: Text("About"),
                onPressed: () => Navigator.pushNamed(context, '/about'),
              ),
              FlatButton(
                child: Text("View Ad"),
                onPressed: () => Navigator.pushNamed(context, '/ad'),
              )
            ],
          ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Container(
              child: RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
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
                              color: Colors.white,
                              size: 75,
                            ),
                          ),
                          Text("Get Magnet",style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, '/magnet'),
              ),
            ),
            SizedBox(
              // width: MediaQuery.of(context).size.width / 3 - 90,
              width: 10,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
                  color: Colors.blue,
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
                            color: Colors.white,
                          ),
                        ),
                        Text("Get Chart",style: TextStyle(color: Colors.white)),
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
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
                  color: Colors.blue,
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
                          color: Colors.white,
                        ),
                      ),
                      Text("Get Previous",style: TextStyle(color: Colors.white)),
                    ],
                  )),
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, '/history'),
            ),
            SizedBox(
              width: 10,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
                color: Colors.blue,
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
                          color: Colors.white,
                        ),
                      ),
                      Text("Do Nothing",style: TextStyle(color: Colors.white)),
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
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text("${androidInfo.androidId}");
                } else
                  return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ],
    );
  }
}
