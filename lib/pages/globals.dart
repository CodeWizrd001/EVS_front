import 'package:country_code/country_code.dart';
import 'package:device_info/device_info.dart';
import 'package:evs_app/pages/request.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:evs_app/models/models.dart';

// Device Data
DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
AndroidDeviceInfo androidInfo;
Future<AndroidDeviceInfo> androidFuture;
String locale;

// Graph Data
List<Values> graphData = [];

// User Data
List<bool> pages = [];
int coins = 0;
bool premium = false;

// Server Data
var host = "3.16.28.159";
var port = 8000;
var url = "http://$host:$port";

var ads = [true];
var init = false;

getUser() async {
  var response = await makeRequest('/getuser', {'uid': androidInfo.androidId});
  try {
    pages.clear();
    coins = response['uCoins'];
    response['uPurchased'].forEach((element) {
      pages.add(element);
    });
    premium = response['uPremium'];
  } catch (e) {
    print("Error $e");
  }
}

class Info {
  static Future<AndroidDeviceInfo> initInfo() async {
    androidInfo = await deviceInfo.androidInfo;
    locale = await FlutterSimCountryCode.simCountryCode;

    getUser();
    print("Init Done $locale ${CountryCode.parse(locale)}");
    return await deviceInfo.androidInfo;
  }
}
