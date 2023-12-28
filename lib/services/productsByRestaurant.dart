// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt("idRestaurant", id);
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
    List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    
    for (int i = data.length - 1; i >= 0; i--) {
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

Future<Map<String, String>> addFoodToCart(int idFood, int idRestaurant, int cuantity) async {
  const String url = '$_url/api/orders/';
  final prefs = await SharedPreferences.getInstance();
  final int idUser = prefs.getInt('idUser') ?? 0;
  final int idRestaurant = prefs.getInt('idRestaurant') ?? 0;

  final String urlFoodPrices = '$_url/api/foods/$idFood';
  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  final http.Response response = await http.get(
    Uri.parse(urlFoodPrices),
    headers: header,
  );

  final Map<String, dynamic> data = jsonDecode(response.body);
  final double price = data['price'];
  final double total = price * cuantity;

  final Map<String, dynamic> body = {
    'user': idUser,
    'restaurant': idRestaurant,
    'food': idFood,
    'quantity': cuantity,
    'total': total,
    'dish': idFood,
  };

  final responseAdd = await http.post(
    Uri.parse(url),
    headers: header,
    body: jsonEncode(body),
  );

  if (responseAdd.statusCode == 200) {
    return {
      'result': 'success',
      'message': 'Producto agregado al carrito',
    };
  } else {
    return {
      'result': 'error',
      'message': 'Error al agregar el producto al carrito',
    };
  }
}

Future<List<dynamic>> getCart() async {
  const String url = '$_url/api/orders/';
  final prefs = await SharedPreferences.getInstance();
  final int idUser = prefs.getInt('idUser') ?? 0;
  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  final http.Response response = await http.get(
    Uri.parse(url),
    headers: header,
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i]['user'] != idUser) {
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