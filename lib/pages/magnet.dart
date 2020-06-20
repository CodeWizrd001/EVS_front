import 'dart:async';
import 'dart:math';

import 'package:evs_app/pages/globals.dart';
import 'package:evs_app/pages/request.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_sensors/flutter_sensors.dart';

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

  bool _magAvail = false;
  List<double> _magData;

  void _checkMagStatus() async {
    await manager.isSensorAvailable(Sensors.MAGNETIC_FIELD).then(
      (value) {
        setState(() {
          _magAvail = value;
          print(value);
        });
      },
    );
  }

  int normalise(num value) {
    if (value < 0) return 0;
    if (value > 255) return 255;
    return value;
  }

  double addToAverage(double average, double value) {
    if (size < double.maxFinite - 1) size += 1;
    return ((size - 1) * average + value) / (size);
  }

  Future<void> _startMag() async {
    if (!_magAvail) return;
    final stream = await SensorManager().sensorUpdates(
      sensorId: Sensors.MAGNETIC_FIELD,
      interval: Sensors.SENSOR_DELAY_FASTEST,
    );
    _magSubscription = stream.listen(
      (event) {
        _magData = event.data;
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Start"),
              onPressed: () => _startMag(),
            ),
            SizedBox(
              height: 150,
            ),
            Center(
              child: Text(
                "EMF : ${data.toStringAsPrecision(5)}",
                style: TextStyle(
                  color: Color.fromRGBO(r, g, 0, 1),
                  fontSize: 50,
                ),
              ),
            ),
            Center(
              child: Text(
                "MIN : ${min.toStringAsPrecision(5)}",
                style: TextStyle(
                  color: Color.fromRGBO(rmin, gmin, 0, 1),
                  fontSize: 50,
                ),
              ),
            ),
            Center(
              child: Text(
                "MAX : ${max.toStringAsPrecision(5)}",
                style: TextStyle(
                  color: Color.fromRGBO(rmax, gmax, 0, 1),
                  fontSize: 50,
                ),
              ),
            ),
            Center(
              child: Text(
                "AVG : ${avg.toStringAsPrecision(5)}",
                style: TextStyle(
                  color: Color.fromRGBO(ravg, gavg, 0, 1),
                  fontSize: 50,
                ),
              ),
            ),
            RaisedButton(
              child: Text("Reset Values"),
              onPressed: () {
                _stopMag();
                setState(() {
                  size = 0;
                  data = 0;
                  min = double.maxFinite;
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
            RaisedButton(
              child: Text("Send Data"),
              onPressed: () {
                makeRequest("/data",{
                  "data" : data ,
                  "min" : min ,
                  "max" : max ,
                  "avg" : avg,
                  "id" : androidInfo.androidId ,
                  "locale" : locale, 
                }); 
              },
            )
          ],
        ),
      ),
    );
  }
}
