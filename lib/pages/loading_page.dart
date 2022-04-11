import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';

import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/usuarios_page.dart';

//! ESta pantalla me sirve, para determinar si tienenun logging valido
//! si funciona: lo mado a usuarios
//! si no funciona: lo mando a login

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        //llamamos al Future y le mando el context para hacer la navegacion
        future: checkLoginState(context),
        builder: (context, snapshot) {
          //
          return const Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  // Hacemos la verificacion
  // el BuildContext context lo uso porque necesito mover la pantalla
  Future checkLoginState(BuildContext context) async {
    //instancia del provider para leer mi AuthService
    //listen:false   No necesito que esto se redibuje!
    final authService = Provider.of<AuthService>(context, listen: false);

    // no necesitamos que redibuje nada
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      //llamo el socketService.connect() cuando estoy autenticado
      //conectar al socket server
      socketService.connect();
      // Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const UsuariosPage(),
              transitionDuration: const Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginPage(),
              transitionDuration: const Duration(milliseconds: 0)));
    }
  }
}
