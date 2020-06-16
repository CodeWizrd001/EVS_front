import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sim_service/models/sim_data.dart';
import 'package:ussd_service/ussd_service.dart';
import 'package:sim_service/sim_service.dart' ;
import 'package:permission_handler/permission_handler.dart' ;

class USSD extends StatefulWidget {
  @override
  _USSDState createState() => _USSDState();
}

class _USSDState extends State<USSD> {
  makeMyRequest(String code) async {
    SimData data = await SimService.getSimData ;
    print(data.cards) ;
    int subscriptionId = data.cards.first.subscriptionId; // sim card subscription Id
    PermissionStatus perStat = await Permission.phone.status ;
    print(perStat) ;

    if(!(perStat==PermissionStatus.granted))
      perStat = await Permission.phone.request() ;
    print("After Request $perStat") ;
    try {
      String ussdSuccessMessage =
          await UssdService.makeRequest(subscriptionId, code);
      print("succes! message: $ussdSuccessMessage");
    } on PlatformException catch (e) {
      print("error! code: ${e.code} - message: ${e.message}");
    }
    return true ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: makeMyRequest("*#06#"),
        builder: (context, snapshot) {
          print(context);
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData)
            return Text("Hello World");
          else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
