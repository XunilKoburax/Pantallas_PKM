import 'package:flutter/material.dart';
import '../Modelo/usuario_provider.dart';

class UsuarioProvider extends ChangeNotifier {
  Usuario usuario = Usuario(
    nombre: "Juan",
    email: "juan@mail.com",
  );

  void actualizarUsuario(String nuevoNombre, String nuevoEmail) {
    usuario.nombre = nuevoNombre;
    usuario.email = nuevoEmail;

    notifyListeners(); // actualiza toda la app
  }
}