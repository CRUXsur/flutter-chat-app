import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//creamos una funcion
//sin llaves los hago posicionales obligatorios: no es necesario required
//(BuildContext context, String titulo, String subtitulo)
mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(titulo),
              content: Text(subtitulo),
              actions: <Widget>[
                MaterialButton(
                    child: const Text('Ok'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => Navigator.pop(context))
              ],
            ));
  }

  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ),
  );
}
