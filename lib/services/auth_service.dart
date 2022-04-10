import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environment.dart';

import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;

  Future<bool> login(String email, String password) async {
    //este es el payload que quiero mandar al backend
    final data = {
      'email': email,
      'password': password,
    };
    //respuesta
    final uri = Uri.parse('${Environment.apiUrl}/login');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    //esta es la respuesta
    //print(resp.body);
    //necesitamos mapear la respuesta a un tipo de modelo propio en
    //nuestra aplicacion
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;

      //await this._guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }
}
