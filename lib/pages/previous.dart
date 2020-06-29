import 'package:evs_app/pages/globals.dart';
import 'package:evs_app/pages/request.dart';
import 'package:flutter/material.dart';

bool empty = true;

class Previous extends StatefulWidget {
  @override
  _PreviousState createState() => _PreviousState();
}

class _PreviousState extends State<Previous> {
  Future<List<Widget>> getListData() async {
    List<Widget> data = [];
    var response = await makeRequest("/getMy/${androidInfo.androidId}", {});
    print(response);
    var n = response['max'].length;
    for (int i = 0; i < n; i += 1) {
      data.add(
        ListTile(
          title: Text(
              "${i + 1} Min : ${response['min'][i].toStringAsPrecision(4)} Avg : ${response['avg'][i].toStringAsPrecision(4)} Max : ${response['max'][i].toStringAsPrecision(4)}"),
        ),
      );
    }
    empty = false;
    if (data.isEmpty) {
      data.add(ListTile(
        title: Text("No Previous Data"),
      ));
      empty = true;
    }
    return data;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: FutureBuilder(
                future: getListData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData)
                      return ListView(children: snapshot.data);
                    else
                      return Text("Failed To Fetch");
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              child: empty
                  ? RaisedButton(
                      child: Text("Compare With Country"),
                      onPressed: () => null,
                      color: Colors.grey,
                    )
                  : RaisedButton(
                      child: Text("Compare With Country"),
                      onPressed: () => Navigator.pushNamed(context, '/compare'),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
