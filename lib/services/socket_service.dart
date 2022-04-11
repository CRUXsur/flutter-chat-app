import 'package:flutter/material.dart';

import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

//este SocketService lo tenemos que colocar en el modo global de
//nuestra aplicacion
//para que todos los widgets, todas las paginas
//tengan acceso al SocketService!!!!!!!....esto en el main.dart
class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  void connect() {
    // Dart client
    _socket = IO.io(Environment.socketUrl, {
      //Propiedades
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true //forzar a una nueva coneccion
    });

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  //cuando hagamos el logout,
  void disconnect() {
    _socket.disconnect();
  }
}
