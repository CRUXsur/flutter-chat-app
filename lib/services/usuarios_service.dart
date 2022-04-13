import 'package:http/http.dart' as http;

import 'package:chat/models/usuario.dart';
import 'package:chat/models/usuarios_response.dart';
import 'package:chat/services/auth_service.dart';

import 'package:chat/global/environment.dart';

class UsuariosService {
  //
  Future<List<Usuario>?> getUsuarios() async {
    //
    //obteniendo el token
    String? token = await AuthService.getToken();
    try {
      final resp = await http.get(
        Uri.parse('${Environment.apiUrl}/usuarios'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token.toString(),
        },
      );
      //mapeamos la respuesta
      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
