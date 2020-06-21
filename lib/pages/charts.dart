import 'dart:math';

import 'package:evs_app/pages/magnet.dart';
import 'package:evs_app/pages/request.dart';
import 'package:flutter/material.dart';

import 'package:flutter_circular_chart/flutter_circular_chart.dart';

var v1 = 10.0;
var v2 = 10.0;
var v3 = 10.0;
var v4 = 10.0;

final GlobalKey<AnimatedCircularChartState> _chartKey =
    GlobalKey<AnimatedCircularChartState>();
List<CircularStackEntry> data = <CircularStackEntry>[
  CircularStackEntry(
    <CircularSegmentEntry>[
      CircularSegmentEntry(v1, Colors.red, rankKey: 'Q1'),
      CircularSegmentEntry(v2, Colors.green, rankKey: 'Q2'),
      CircularSegmentEntry(v3, Colors.blue, rankKey: 'Q3'),
      CircularSegmentEntry(v4, Colors.yellow, rankKey: 'Q4'),
    ],
    rankKey: 'Quarterly Profits',
  ),
];

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  Future<List<CircularStackEntry>> getChartData() async {
    Map<String,List<Map<String,dynamic>>> response = await makeRequest('/get', {});
    var avgData = 0.0;
    var len = response['CountriesData'].length ;
    response['CountriesData'].forEach((element) {
      avgData = 0 ;
      element['avg'].forEach((value){
        avgData += 1 ;
      }) ;
      avgData = avgData/len ;
      data[0]
          .entries
          .add(CircularSegmentEntry(avgData, Colors.red[normalise(avgData.floor())]));
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: getChartData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return AnimatedCircularChart(
                      key: _chartKey,
                      size: const Size(400.0, 400.0),
                      initialChartData: snapshot.data,
                      chartType: CircularChartType.Radial,
                      startAngle: 0,
                      duration: Duration(seconds: 1),
                    );
                  else
                    return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
