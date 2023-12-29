// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


const String _url = 'http://10.0.2.2:8000';


Future<int> countCart() async {
  const String url = '$_url/api/orders/';
  final prefs = await SharedPreferences.getInstance();
  final int idUser = prefs.getInt("idUser")!;
  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  await Future.delayed(const Duration(milliseconds: 1000));

  final http.Response response = await http.get(
    Uri.parse(url),
    headers: header,
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    int count = 0;
    for (int i = 0; i < data.length; i++) {
      if (data[i]['user'] == idUser) {
        count++;
      }
    }
    return count;
  } else {
    return 0;
  }
}