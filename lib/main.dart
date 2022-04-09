import 'package:flutter/material.dart';

import 'package:chat/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      //en la pantalla de loadingPage, me sirve para determinar si la
      //persona tiene un token valido;
      // funciona    : va a usuarios
      // NO funciona : va a login
      initialRoute: 'login',
      routes: appRoutes,
    );
  }
}
