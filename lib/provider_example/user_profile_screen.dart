import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider_implementation_screen.dart';
import 'edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pantalla 1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "Nombre: ${usuarioProvider.usuario.nombre}",
              style: const TextStyle(fontSize: 18),
            ),

            Text(
              "Email: ${usuarioProvider.usuario.email}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditScreen(),
                  ),
                );
              },
              child: const Text("Editar usuario"),
            )
          ],
        ),
      ),
    );
  }
}