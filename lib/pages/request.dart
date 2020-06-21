import 'dart:convert';

import 'globals.dart';
import 'package:http/http.dart' as http;

makeRequest(String endpoint, Map<String, dynamic> body) async {
  var response = await http.post(
    url + endpoint,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode( body ),
  );
  print(response.body);
  return jsonDecode(response.body) ;
}
