// ignore_for_file: dead_code

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const String _url = 'http://10.0.2.2:8000';

Future<Map<String,dynamic>> makePayment (String cartNumber, String cvv, String expirationDate, String nameCart) async {
  if (cartNumber == ""){
    return {
      'result': 'error',
      'message': 'El número de tarjeta es requerido',
    };
  }
  else if (cartNumber.length != 16){
    return {
      'result': 'error',
      'message': 'El número de tarjeta debe tener 16 dígitos',
    };
  }

  if (cvv == ""){
    return {
      'result': 'error',
      'message': 'El CVV es requerido',
    };
  }
  else if (cvv.length != 3){
    return {
      'result': 'error',
      'message': 'El CVV debe tener 3 dígitos',
    };
  }

  if (expirationDate == ""){
    return {
      'result': 'error',
      'message': 'La fecha de expiración es requerida',
    };
  }
  else if (expirationDate.length > 5){
    return {
      'result': 'error',
      'message': 'La fecha de expiración debe tener el formato MM/AA',
    };
  }

  if (nameCart == ""){
    return {
      'result': 'error',
      'message': 'El nombre del titular es requerido',
    };
  }
  final prefs = await SharedPreferences.getInstance();
  final int idUser = prefs.getInt('idUser') ?? 0;
  // final double total = prefs.getDouble('total') ?? 0;

  const String urlBillHeader = '$_url/api/billHeader/';

  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> dataBillHeader = {
    'user': idUser,
  };

  final http.Response responseBillHeader = await http.post(
    Uri.parse(urlBillHeader),
    headers: header,
    body: json.encode(dataBillHeader),
  );

  if (responseBillHeader.statusCode == 201) {
    final Map<String, dynamic> data = json.decode(utf8.decode(responseBillHeader.bodyBytes));
    final int idBillHeader = data['id'];
    
    // Sacar los orders de la persona
    const String urlOrder = '$_url/api/order/';

    final http.Response responseOrder = await http.get(
      Uri.parse(urlOrder),
      headers: header,
    );

    List<dynamic> dataOrders = json.decode(utf8.decode(responseOrder.bodyBytes));
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i]['user'] != idUser) {
        dataOrders.removeAt(i);
      }
    }

    for(int i = 0; i < dataOrders.length; i++){
      final int idOrder = dataOrders[i]['id'];
      final String urlBillDetail = '$_url/api/orders/$idOrder';

      final Map<String, dynamic> dataBillDetail = {
        'BillHeader': idBillHeader,
        'status': 'Pagado',
      };

      final http.Response responseBillDetail = await http.patch(
        Uri.parse(urlBillDetail),
        headers: header,
        body: json.encode(dataBillDetail),
      );

      if(responseBillDetail.statusCode == 200){
        // Guardar la orden
        return {
          'result': 'success',
          'message': 'Pago realizado con éxito',
        };
      }else{
        return {
          'result': 'error',
          'message': 'Error al realizar el pago',
        };
      }
    }
  }
  return {
    'result': 'error',
    'message': 'Error al obtener los datos',
  };
}

Future<Map<String, String>> makePaymentInCash () async {
  final prefs = await SharedPreferences.getInstance();
  final int idUser = prefs.getInt('idUser') ?? 0;

  const String urlBillHeader = '$_url/api/billHeader/';

  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> dataBillHeader = {
    'user': idUser,
  };

  final http.Response responseBillHeader = await http.post(
    Uri.parse(urlBillHeader),
    headers: header,
    body: jsonEncode(dataBillHeader),
  );

  if (responseBillHeader.statusCode == 201) {
    final Map<String, dynamic> data = jsonDecode(utf8.decode(responseBillHeader.bodyBytes));
    final int idBillHeader = data['id'];
    
    // Sacar los orders de la persona
    const String urlOrder = '$_url/api/orders/';

    final http.Response responseOrder = await http.get(
      Uri.parse(urlOrder),
      headers: header,
    );

    print(responseOrder.statusCode);

    List<dynamic> dataOrders = jsonDecode(utf8.decode(responseOrder.bodyBytes));
    for (int i = dataOrders.length - 1; i >= 0; i--) {
      if (dataOrders[i]['user'] != idUser) {
        dataOrders.removeAt(i);
      }
    }

    for(int i = 0; i < dataOrders.length; i++){
      final int idOrder = dataOrders[i]['id'];
      final String urlBillDetail = '$_url/api/orders/$idOrder/';

      final Map<String, dynamic> dataBillDetail = {
        'BillHeader': idBillHeader,
        'status': 'Pagado',
      };

      await http.patch(
        Uri.parse(urlBillDetail),
        headers: header,
        body: jsonEncode(dataBillDetail),
      );

      // Guardar la orden
      const String urlOrderTable = '$_url/api/tables/';
      final String idOrderTable = '$idOrder$idUser';
      final int idRestaurant = dataOrders[i]['restaurant'];
      final int idOrderToTable = dataOrders[i]['id'];

      print(idOrderTable);
      print(idRestaurant);
      print(idOrderToTable);

      final Map<String, dynamic> dataOrderTable = {
        'number': idOrderTable,
        'restaurant': idRestaurant,
        'order': idOrderToTable,
      };

      await http.post(
        Uri.parse(urlOrderTable),
        headers: header,
        body: jsonEncode(dataOrderTable),
      );
    }
    return {
      'result': 'success',
      'message': 'Pago realizado con éxito',
    };
  }
  return {
    'result': 'error',
    'message': 'Error al obtener los datos',
  };
}