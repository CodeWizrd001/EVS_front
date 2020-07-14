import 'package:charts_flutter/flutter.dart';
import 'package:evs_app/models/models.dart';
import 'package:evs_app/pages/globals.dart';
import 'package:evs_app/pages/request.dart';

import 'package:flutter/material.dart';

class Compare extends StatefulWidget {
  @override
  _CompareState createState() => _CompareState();
}

class _CompareState extends State<Compare> {
  Future<List<Series<dynamic, String>>> getData() async {
    List<Values> data = [];

    var response = await makeRequest("/getMy/${androidInfo.androidId}", {});
    print(response);
    int n = response['max'].length;
    double min = 0;
    double avg = 0;
    double max = 0;
    for (int i = 0; i < n; i += 1) {
      min += response['min'][i];
      avg += response['avg'][i];
      max += response['max'][i];
    }
    min = min / n;
    avg = avg / n;
    max = max / n;
    data.add(Values("Current", min, avg, max));

    response = await makeRequest("/get/$locale", {});
    print(response);
    n = response['max'].length;
    min = 0;
    avg = 0;
    max = 0;
    for (int i = 0; i < n; i += 1) {
      min += response['min'][i];
      avg += response['avg'][i];
      max += response['max'][i];
    }
    min = min / n;
    avg = avg / n;
    max = max / n;
    data.add(Values(response['Country'], min, avg, max));

    var minSeries = Series<Values, String>(
      id: "Min",
      domainFn: (Values val, _) => val.country,
      measureFn: (Values val, _) => val.min,
      colorFn: (_, __) => MaterialPalette.green.shadeDefault,
      data: data,
    );
    var avgSeries = Series<Values, String>(
      id: "Avg",
      domainFn: (Values val, _) => val.country,
      measureFn: (Values val, _) => val.avg,
      colorFn: (_, __) => MaterialPalette.yellow.shadeDefault,
      data: data,
    );
    var maxSeries = Series<Values, String>(
      id: "Max",
      domainFn: (Values val, _) => val.country,
      measureFn: (Values val, _) => val.max,
      colorFn: (_, __) => MaterialPalette.red.shadeDefault,
      data: data,
    );

    return [
      minSeries,
      avgSeries,
      maxSeries,
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comparison"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 100,
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData)
                return BarChart(
                  snapshot.data,
                  barGroupingType: BarGroupingType.grouped,
                  behaviors: [
                    SlidingViewport(),
                    PanAndZoomBehavior(),
                    SeriesLegend(),
                  ],
                );
              else
                return Text("Fetch Failed");
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
