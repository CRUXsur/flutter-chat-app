import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environment.dart';

//import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  //Usuario? usuario;

  Future login(String email, String password) async {
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
    print(resp.body);
  }
}
