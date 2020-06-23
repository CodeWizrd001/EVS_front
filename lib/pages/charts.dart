import 'package:charts_flutter/flutter.dart' as chart;
import 'package:evs_app/models/models.dart';
import 'package:evs_app/pages/request.dart';
import 'package:flutter/material.dart';

import 'package:random_color/random_color.dart';

var v1 = 10.0;
var v2 = 10.0;
var v3 = 10.0;
var v4 = 10.0;

Color getRandomColor() {
  return RandomColor().randomColor();
}

List<Values> graphData = [];
chart.Series minSeries;
chart.Series avgSeries;
chart.Series maxSeries;

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  Future<List<Values>> getChartData() async {
    Map<String, dynamic> response = await makeRequest('/get', {});
    List<Values> retData = [];
    var len = response['CountriesData'].length;
    response['CountriesData'].forEach((element) {
      retData.add(Values.fromJson(element));
    });
    return retData;
  }

  Future<List<Values>> getGraphData() async {
    graphData = await getChartData();
    minSeries = chart.Series<Values, String>(
      id: "Min",
      domainFn: (Values val, _) => val.country,
      measureFn: (Values val, _) => val.min,
      colorFn: (_, __) => chart.MaterialPalette.green.shadeDefault,
      data: graphData,
    );
    avgSeries = chart.Series<Values, String>(
      id: "Avg",
      domainFn: (Values val, _) => val.country,
      measureFn: (Values val, _) => val.avg,
      colorFn: (_, __) => chart.MaterialPalette.yellow.shadeDefault,
      data: graphData,
    );
    maxSeries = chart.Series<Values, String>(
      id: "Max",
      domainFn: (Values val, _) => val.country,
      measureFn: (Values val, _) => val.max,
      colorFn: (_, __) => chart.MaterialPalette.red.shadeDefault,
      data: graphData,
    );
    return graphData;
  }

  @override
  void dispose(){
    super.dispose() ;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Analysis"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: getGraphData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      height: MediaQuery.of(context).size.height - 100,
                      child: chart.BarChart(
                        [
                          minSeries,
                          avgSeries,
                          maxSeries,
                        ],
                        barGroupingType: chart.BarGroupingType.grouped,
                        behaviors: [
                          chart.SlidingViewport(),
                          chart.PanAndZoomBehavior(),
                          chart.SeriesLegend(),
                        ],
                      ),
                    );
                  } else
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
