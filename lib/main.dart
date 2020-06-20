import 'package:flutter/material.dart';
import 'package:evs_app/pages/magnet.dart';
import 'package:evs_app/pages/globals.dart';

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
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    androidFuture = Info.initInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Get Magnet"),
            onPressed: () => Navigator.pushNamed(context, '/magnet'),
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
      ),
    );
  }
}
