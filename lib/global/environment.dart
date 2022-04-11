import 'dart:io';

//creo una clase que solo va a tener metodos estaticos
//al ser metodos estaticos significa que yo puedo acceder a ellos
//sin necesidad de instanciar la clase

class Environment {
  //servicio REST
  static String apiUrl = Platform.isAndroid
      ? 'http://10.0.2.2:3000/api'
      : 'http://localhost:3000/api';
  //servidor de sockets
  static String socketUrl =
      Platform.isAndroid ? 'http://192.168.1.8:3000' : 'http://localhost:3000';
}
