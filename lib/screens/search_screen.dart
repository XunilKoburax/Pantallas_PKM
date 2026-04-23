import 'package:flutter/material.dart';
import '../services/pokemon_service.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final PokemonService _pokemonService = PokemonService();

  Future<void> _searchPokemon() async {
    final name = _controller.text.trim();
    
    // Validación simple: Si el campo está vacío, no hacemos nada
    if (name.isEmpty) return;

    // Se realiza la petición al servidor a través de nuestro servicio
    final data = await _pokemonService.getPokemonByName(name);
    
    // Si la petición trajo datos y seguimos en la pantalla, saltamos al detalle
    if (mounted && data != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PokemonDetailScreen(pokemonData: data),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Pokémon'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Nombre del Pokémon',
                hintText: 'Ej. Pikachu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchPokemon,
              child: const Text('Buscar'),
            ),
          ],
        ),
      ),
    );
  }
}
