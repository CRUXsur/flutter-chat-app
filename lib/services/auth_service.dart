import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environment.dart';

import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  //cuando una persona se concta a nuestra aplicion o cuando hacemos
  //una peticion al server recibimos informacion un objeto que nos
  //responde el backend. "usuario": online/nombre/email/uid
  //la idea es que este usuario tenga la info del usuario logeado!
  //mediante el AuthService

  // Usuario usuario;??
  Usuario? usuario;

  // creo la instancia del Storage
  // privado  porque solo funcionara dentro del AuthService
  //y no se podra poner afuera
  final _storage = new FlutterSecureStorage();

  //bloquear el boton de ingrese p/ k no se pueda hacer doble posteo
  bool _autenticando = false; //propiedad indica cuando se esta autenticando
  //como es privada entonces tengo que hacer con getters y setters;
  //y asi cuando se cambie la propiedad _autenticando a true o false,
  //=> notficara a los listeners es decir que cualquier persona o widget
  //que este escuchando los cambios de mi AuthService va a ser notificado
  //cuando cambie esa propiedad....este es uno de los usos de provider!!!!!
  //con guion bajo es privada solo aqui, y sin guion bajo aparce afuera!!!
  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners(); //notifica a todos los k estan escuchando _autenticando
    //para que se redibuje
  }

  //Metodos estaticos que me sirven para obtener y borrar el token haciendo
  //referencia al AuthService
  //Para poder acceder al token desde afuera => necesito
  //crear getters & setters estaticos
  // Getters del token de forma estática
  static Future<String?> getToken() async {
    //como es estatica yo no tengo acceso a las propiedades de la clase
    //como el _storage..no tengo accaeso a esto!
    //entonces me tengo que crear nuevamente la instancia
    final _storage = new FlutterSecureStorage();
    //y ahora puedo leer el token!
    final token = await _storage.read(key: 'token');
    return token;
  }

  // de la misma manera hacer para borra el tken!
  // podre hacer logout de cualquier parte..
  // no necesariamente con el pprovider
  //solo haciendo referencia al authService....
  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  //tengo que crear un metodo  future recibe email y password
  Future<bool> login(String email, String password) async {
    autenticando = true;

    //var url = Uri.parse('http://10.0.2.2:3000/api/login');
    var urlLogin = Uri.parse('${Environment.apiUrl}/login');

    //payload que mandare al backend
    final data = {'email': email, 'password': password};

    final resp = await http.post(urlLogin,
        body: jsonEncode(data), //convert la data(objeto) a su forma de json
        headers: {'Content-Type': 'application/json'});

    //necesitamos que esta repuesta, mapear a un tipo de modelo
    //propio de nuestra aplicacion! usamos https://quicktype.io
    //print(resp.body);

    // hacemos lo inversa, ya sea que la info sea o no la correcta
    //ppero ya tenemos la informacion, => quitamos el loading!
    autenticando = false;

    //necesito saber si la peticion se hace correctamente?
    //que statusCode me devuelve?400:; 401:;404:no se encontro
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      //GUardo(lo grabo) el token! en el dispositivo (lugar seguro)
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  // Registro----------------
  Future register(String nombre, String email, String password) async {
    var urlRegister = Uri.parse('${Environment.apiUrl}/login/new');
    //
    autenticando = true; //notifica a los listeners

    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    final resp = await http.post(urlRegister,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    print(resp.body);
    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  //  esto sera capaz de verificar el token que esta almacenado en el
  // storage de mi telefono, y verificar si todavia sigue siendo valido
  // contra el backend!
  // el metodo que nos permitira hacer eso es:
  Future<bool> isLoggedIn() async {
    var isLoggedIn = Uri.parse('${Environment.apiUrl}/login/renew');
    final token = await _storage.read(key: 'token') ?? '';
    print(token);

    final resp = await http.get(isLoggedIn,
        // mi header personalizado 'x-token'
        headers: {'Content-Type': 'application/json', 'x-token': token});

    print(resp.body);

    if (resp.statusCode == 200) {
      //lo parseamos
      final loginResponse = loginResponseFromJson(resp.body);
      //establecemos el usuario nuevo
      usuario = loginResponse.usuario;
      //grabamos el nuevo token, nueva vida a ese token
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      //borro el token, ya no sirve!
      logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
