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

Future<Map<String, String>> addFoodToCart(int idFood, int cuantity) async {
  const String url = '$_url/api/orders/';
  final prefs = await SharedPreferences.getInstance();
  final int idUser = prefs.getInt('idUser') ?? 0;
  final int idRestaurant = prefs.getInt('idRestaurant') ?? 0;

  if(cuantity == 0){
    cuantity = 1;
  }

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
    'status': 'Pendiente a pagar',
  };

  final responseAdd = await http.post(
    Uri.parse(url),
    headers: header,
    body: jsonEncode(body),
  );

  if (responseAdd.statusCode == 201) {
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

  await Future.delayed(const Duration(milliseconds: 200));

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

    for(int i = data.length - 1; i >= 0; i--) {
      final String urlRestaurant = '$_url/api/restaurants/${data[i]['restaurant']}';
      final http.Response responseRestaurant = await http.get(
        Uri.parse(urlRestaurant),
        headers: header,
      );

      final Map<String, dynamic> dataRestaurant = jsonDecode(utf8.decode(responseRestaurant.bodyBytes));
      final String restaurant = dataRestaurant['name'];
      data[i]['restaurant'] = restaurant;
    }

    for(int i = data.length - 1; i >= 0; i--) {
      final String urlFood = '$_url/api/foods/${data[i]['dish']}';
      final http.Response responseFood = await http.get(
        Uri.parse(urlFood),
        headers: header,
      );

      final Map<String, dynamic> dataFood = jsonDecode(responseFood.body);
      final String food = dataFood['name'];
      data[i]['dish'] = food;
      data[i]['photoDish'] = dataFood['photo'];
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

Future<void> deleteCartFood(int id) async{
  final String url = '$_url/api/orders/$id/';
  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  await http.delete(
    Uri.parse(url),
    headers: header,
  );
}

Future<Map<String, String>> updateCart(int id, int cuantity) async{
  final String url = '$_url/api/orders/$id/';
  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  final gerResponse = await http.get(
    Uri.parse(url),
    headers: header,
  );

  final Map<String, dynamic> data = jsonDecode(gerResponse.body);
  final double price = data['total'] / data['quantity'];
  final double total = price * cuantity;

  final Map<String, dynamic> body = {
    'quantity': cuantity,
    'total': total,
  };

  final response = await http.patch(
    Uri.parse(url),
    headers: header,
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    return {
      'result': 'success',
      'message': 'Producto actualizado',
    };
  } else {
    return {
      'result': 'error',
      'message': 'Error al actualizar el producto',
    };
  }
}

Future<Map<String,dynamic>> getTotalCart() async{
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

  double total = 0;

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i]['user'] != idUser) {
        data.removeAt(i);
      }
    }

    final List<int> productsid = [];

    for(int i = data.length - 1; i >= 0; i--) {
      total += data[i]['total'];
      productsid.add(data[i]['id']);
    }
    return {
      'products': productsid,
      'message': 'Total obtenido',
      'total': total,
    };
  } else {
    return {
      'products': 'No hay productos',
      'message': 'Error al obtener el total',
      'total': 0,
    };
  }
}