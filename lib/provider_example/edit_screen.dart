import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider_implementation_screen.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsuarioProvider>(context);

    final nombreController =
        TextEditingController(text: provider.usuario.nombre);

    final emailController =
        TextEditingController(text: provider.usuario.email);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Usuario"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: "Nombre",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                provider.actualizarUsuario(
                  nombreController.text,
                  emailController.text,
                );

                Navigator.pop(context); // regresar
              },
              child: const Text("Guardar"),
            )
          ],
        ),
      ),
    );
  }
}