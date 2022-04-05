import 'package:flutter/material.dart';

import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/labels.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Logo(titulo: 'Messenger'),
            _Form(),
            const Labels(
              ruta: 'register',
              titulo: '¿No tienes cuenta?',
              subTitulo: 'Crea una ahora!',
            ),
            const Text(
              'Términos y condiciones de uso',
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          //
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          //
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contrasena',
            //borrar para que sea un texto normal
            //keyboardType: TextInputType.emailAddress,
            textController: passCtrl,
            isPassword: true,
          ),
          //
          // TODO: Crear Boton
          ElevatedButton(
            onPressed: () {
              print(emailCtrl.text);
              print(passCtrl.text);
            },
            child: null,
          ),
        ],
      ),
    );
  }
}
