import 'dart:async';
import 'dart:math';

import 'package:evs_app/pages/globals.dart';
import 'package:evs_app/pages/request.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_sensors/flutter_sensors.dart';

int normalise(num value) {
  if (value < 0) return 0;
  if (value > 255) return 255;
  return value;
}

class Magnet extends StatefulWidget {
  @override
  _MagnetState createState() => _MagnetState();
}

class _MagnetState extends State<Magnet> {
  double data = 1;
  double min = 1000;
  double max = -1;
  double avg = 0;
  int r = 0;
  int g = 0;
  int rmin = 0;
  int rmax = 0;
  int gmin = 0;
  int gmax = 0;
  int ravg = 0;
  int gavg = 0;
  double size = 0;

  StreamSubscription _magSubscription;
  SensorManager manager = SensorManager();
  PageController magnetPageController = PageController();

  bool _magAvail = false;
  List<double> _magData;

  TextStyle thStyle = TextStyle(
    color: Colors.white,
    fontSize: 30,
  );

  void _checkMagStatus() async {
    await manager.isSensorAvailable(Sensors.MAGNETIC_FIELD).then(
      (value) {
        if (!mounted) return;
        setState(() {
          _magAvail = value;
          print(value);
        });
      },
    );
  }

  double addToAverage(double average, double value) {
    if (size < double.maxFinite - 1) size += 1;
    return ((size - 1) * average + value) / (size);
  }

  Future<void> _startMag() async {
    if (!_magAvail) return;
    if (r != 0) return;
    final stream = await SensorManager().sensorUpdates(
      sensorId: Sensors.MAGNETIC_FIELD,
      interval: Sensors.SENSOR_DELAY_FASTEST,
    );
    _magSubscription = stream.listen(
      (event) {
        _magData = event.data;
        if (!mounted) return;
        setState(() {
          var sq = _magData[0] * _magData[0] +
              _magData[1] * _magData[1] +
              _magData[2] * _magData[2];

          data = sqrt(sq);
          if (min > data) min = data;
          if (max < data) max = data;
          avg = addToAverage(avg, data);

          r = normalise(data.floor());
          g = normalise(300 - data.floor());

          rmin = normalise(min.floor());
          gmin = normalise(300 - min.floor());

          rmax = normalise(max.floor());
          gmax = normalise(300 - max.floor());

          ravg = normalise(avg.floor());
          gavg = normalise(300 - avg.floor());
        });
      },
    );
  }

  void _stopMag() {
    _magSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    _checkMagStatus();
    print(double.maxFinite);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: PageView(
          controller: magnetPageController,
          children: <Widget>[
            getNormalMaget(),
            Container(
              color: Colors.white,
            ),
            Container(
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }

  getNormalMaget() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.teal, width: 5),
            ),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(r, g, 0, 1),
                  blurRadius: 16.0,
                  spreadRadius: 15.0,
                  offset: Offset(
                    0.0,
                    3.0,
                  ),
                ),
              ]),
              child: Text(
                "EMF : ${data.toStringAsPrecision(5)}",
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5)),
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: Text(
                  "MIN",
                  style: thStyle,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5)),
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: Text(
                  "AVG",
                  style: thStyle,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5)),
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: Text(
                  "MAX",
                  style: thStyle,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(rmin, gmin, 0, 1),
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
              ),
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: Text(
                  "${min.toStringAsPrecision(5)}",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(ravg, gavg, 0, 1),
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
              ),
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: Text(
                  "${avg.toStringAsPrecision(5)}",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(rmax, gmax, 0, 1),
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
              ),
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: Text(
                  "${max.toStringAsPrecision(5)}",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            RaisedButton(
              color: Color.fromRGBO(0, 255, 0, 1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width / 2 - 50,
                height: MediaQuery.of(context).size.width / 2 - 50,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.play_circle_filled,
                        size: MediaQuery.of(context).size.width / 2 - 75,
                      ),
                      Text("Start"),
                    ],
                  ),
                ),
              ),
              onPressed: () => _startMag(),
            ),
            SizedBox(
              width: 10,
            ),
            RaisedButton(
              color: Color.fromRGBO(255, 30, 30, 1),
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 50,
                height: MediaQuery.of(context).size.width / 2 - 50,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.pause_circle_filled,
                        size: MediaQuery.of(context).size.width / 2 - 75,
                      ),
                      Text("Reset Values"),
                    ],
                  ),
                ),
              ),
              onPressed: () {
                _stopMag();
                if (!mounted) return;
                setState(() {
                  size = 0;
                  data = 0;
                  min = 10000;
                  max = 0;
                  avg = 0;
                  r = 0;
                  g = 0;
                  rmin = 0;
                  rmax = 0;
                  gmin = 0;
                  gmax = 0;
                  ravg = 0;
                  gavg = 0;
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          child: Text("Send Data"),
          onPressed: () async {
            if (min > max)
              return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Text("Invalid Data"),
                    ),
                    actions: [
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            await makeRequest("/add", {
              "data": data,
              "min": min,
              "max": max,
              "avg": avg,
              "id": androidInfo.androidId,
              "locale": locale,
            });
            return showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Container(
                    child: Text("Data Sent"),
                  ),
                  actions: [
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
