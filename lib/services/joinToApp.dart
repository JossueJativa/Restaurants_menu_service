// ignore_for_file: file_names, non_constant_identifier_names, unused_local_variable
import 'dart:convert';

import 'package:flutter_demo_restaurant/services/encription.dart';
import 'package:http/http.dart' as http;


const String _url = 'http://10.0.2.2:8000';


Future<Map<String, String>> Register_user(String username, String email, String phone, String password, String confirmPassword, String address) async {
  const String urlCreateUser = '$_url/api/users/';
  late String password_encrypt;

  if (password != confirmPassword) {
    return {
      'result': 'error',
      'message': 'Las contraseñas no coinciden',
    };
  } else {
    // Comprobacion de nulos
    if(email == ""){
      return {
        'result': 'error',
        'message': 'El email no puede estar vacio',
      };
    }
    if(phone == ""){
      return {
        'result': 'error',
        'message': 'El telefono no puede estar vacio',
      };
    }
    if(username == ""){
      return {
        'result': 'error',
        'message': 'El nombre de usuario no puede estar vacio',
      };
    }
    if(password == ""){
      return {
        'result': 'error',
        'message': 'La contraseña no puede estar vacia',
      };
    }
    if(address == ""){
      return {
        'result': 'error',
        'message': 'La direccion no puede estar vacia',
      };
    }

    // Verificar si tiene mas de 10 num
    if(phone.length < 10){
      return {
        'result': 'error',
        'message': 'El telefono debe tener mas de 10 numeros',
      };
    }

    password_encrypt = encryptPassword(password);

    final Map<String, String> header = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> body = {
      'username': username,
      'email': email,
      'phone': phone,
      'password': password_encrypt,
      'address': address,
    };

    // Creacion de usuario
    final response = await http.post(
      Uri.parse(urlCreateUser),
      headers: header,
      body: jsonEncode(body),
    );

    if (response.statusCode != 201) {
      return {
        'result': 'error',
        'message': 'Error al crear el usuario',
      };
    }
    return {
      'result': 'success',
      'message': 'Usuario creado correctamente',
    };
  }
}

Future<Map<String, String>> Login_user(String email, String password) async {
  const String urlLoginUser = '$_url/api/users/login/';
  late String password_encrypt;

  // Check for nulls
  if (email == "") {
    return {
      'result': 'error',
      'message': 'El email de usuario no puede estar vacio',
    };
  }
  if (password == "") {
    return {
      'result': 'error',
      'message': 'La contraseña no puede estar vacia',
    };
  }

  password_encrypt = encryptPassword(password);

  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  final Map<String, String> body = {
    'email': email,
    'password': password_encrypt,
  };

  // Login de usuario
  final response = await http.post(
    Uri.parse(urlLoginUser),
    headers: header,
    body: jsonEncode(body),
  );

  if (response.statusCode != 200) {
    return {
      'result': 'error',
      'message': 'Error al iniciar sesion',
    };
  }

  final Map<String, dynamic> data = jsonDecode(response.body);
  if (data.containsKey('error')) {
    return {
      'result': 'error',
      'message': data['error'],
    };
  } else {
    return {
      'result': 'success',
      'message': 'Inicio de sesion correcto',
    };
  }
}