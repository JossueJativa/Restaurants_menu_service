// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;


const String _url = 'http://10.0.2.2:8000';

Future<List<dynamic>> getRestaurants() async {
  const String url = '$_url/api/restaurants/';
  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  final http.Response response = await http.get(
    Uri.parse(url),
    headers: header,
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    return data;
  } else {
    return [
      {
        'result': 'error',
        'message': 'Error al obtener los restaurantes',
      }
    ];
  }
}

Future<List<dynamic>> getMenusByRestaurant(int id) async {
  const String url = '$_url/api/menus/';
  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  final http.Response response = await http.get(
    Uri.parse(url),
    headers: header,
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    for (int i = 0; i < data.length; i++) {
      if (data[i]['restaurant'] != id) {
        data.removeAt(i);
      }
    }
    return data;
  } else {
    return [
      {
        'result': 'error',
        'message': 'Error al obtener los productos',
      }
    ];
  }
}


Future<List<dynamic>> getFoodsByMenu(int id) async {
  const String url = '$_url/api/foods/';
  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  final http.Response response = await http.get(
    Uri.parse(url),
    headers: header,
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    for (int i = 0; i < data.length; i++) {
      if (data[i]['menu'] != id) {
        data.removeAt(i);
      }
    }
    return data;
  } else {
    return [
      {
        'result': 'error',
        'message': 'Error al obtener los productos',
      }
    ];
  }
}