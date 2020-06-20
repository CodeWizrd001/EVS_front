import 'package:country_code/country_code.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin() ;
AndroidDeviceInfo androidInfo  ;
Future<AndroidDeviceInfo> androidFuture ;

var host = "192.168.1.33" ;
var port = 8000 ;
var url = "http://$host:$port" ;
String locale ;

class Info {
  static Future<AndroidDeviceInfo> initInfo() async {
    androidInfo = await deviceInfo.androidInfo ;
    locale = await FlutterSimCountryCode.simCountryCode ;
    var country = CountryCode.IN ;
    print("Init Done $locale ${CountryCode.parse(locale)}") ;
    return await deviceInfo.androidInfo ;
  }
}