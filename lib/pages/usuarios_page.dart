import 'package:flutter/material.dart';

import 'package:chat/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarios = [
    Usuario(uid: '1', nombre: 'María', email: 't1@test.com', online: true),
    Usuario(uid: '2', nombre: 'Melissa', email: 't2@test.com', online: false),
    Usuario(uid: '3', nombre: 'Fernando', email: 't3@test.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'mi nombre',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app, color: Colors.black87),
          //boton para salir! cierra aplicacion
          onPressed: () {},
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue[400]),
            // child: Icon( Icons.offline_bolt, color: Colors.red ),
          )
        ],
      ),
      body: ListView.separated(
        itemBuilder: (_, i) => ListTile(
          title: Text(usuarios[i].nombre),
          leading: CircleAvatar(
            child: Text(usuarios[i].nombre.substring(0, 2)),
            backgroundColor: Colors.blue[100],
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                color: usuarios[i].online ? Colors.green[300] : Colors.red,
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length,
      ),
    );
  }
}
