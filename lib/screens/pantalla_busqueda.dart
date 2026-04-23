import "package:flutter/material.dart";
import '../services/pokemon_service.dart';

class Buscador extends StatefulWidget {
  const Buscador({super.key});

  @override
  State<Buscador> createState() => _BuscadorState();
}

class _BuscadorState extends State<Buscador> {
  final TextEditingController _pokemonBuscado = TextEditingController();
  PokemonService busquedaEnAPI = PokemonService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _pokemonBuscado,
              decoration: InputDecoration(hintText: "Pikachu"),
            ),
            ElevatedButton(onPressed: buscarPokemon, child: Text("Find")),
          ],
        ),
      ),
    );
  }

  void buscarPokemon() async {
    var nombrePokemon = _pokemonBuscado.text.trim();
    var data = await busquedaEnAPI.getPokemonByName(nombrePokemon);
    print(data?['name']);
  }
}
