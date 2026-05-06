import 'package:flutter/material.dart';
import 'screens/pantalla_busqueda.dart';
import 'package:provider/provider.dart';
import 'provider_example/user_profile_screen.dart';
import 'provider_example/provider_implementation_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UsuarioProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Finder',
      home: const HomeScreen(),
    );
  }
}
