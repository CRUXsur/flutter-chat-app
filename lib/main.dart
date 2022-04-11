import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //creo una instancia global de mi authservice
        //que me sirve para manejarlo como un singleton
        //si no tb va a  notificarle a los widget necesarios
        //cuando yo quiera redibujarlos
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        //en la pantalla de loadingPage, me sirve para determinar si la
        //persona tiene un token valido;
        // funciona    : va a usuarios
        // NO funciona : va a login
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
