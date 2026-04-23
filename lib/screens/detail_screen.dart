import 'package:flutter/material.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Map<String, dynamic> pokemonData;

  const PokemonDetailScreen({super.key, required this.pokemonData});

  String _extractName() {
    var rawName = pokemonData['name'];
    if (rawName is Map) {
      return rawName['english']?.toString() ?? 'Desconocido';
    }
    return rawName?.toString() ?? 'Desconocido';
  }

  String _extractTypes() {
    var types = pokemonData['type'] ?? pokemonData['types'];
    if (types is List) {
      return types.join(', ');
    }
    return types?.toString() ?? 'Desconocido';
  }

  Map<String, dynamic> _extractStats() {
    var stats = pokemonData['base'] ?? pokemonData['stats'];
    if (stats is Map<String, dynamic>) {
      return stats;
    }
    return {};
  }

  String? _extractImage() {
    // Busca posibles llaves de imagen en el json
    var img = pokemonData['image'] ?? pokemonData['thumbnail'] ?? pokemonData['image_url'];
    if (img != null) {
      return img.toString();
    }
    
    // Validar en sprites por si usa la estructura de PokeAPI nativa
    if (pokemonData['sprites'] != null && pokemonData['sprites'] is Map) {
      return pokemonData['sprites']['front_default']?.toString() ?? 
             pokemonData['sprites']['other']?['official-artwork']?['front_default']?.toString();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String name = _extractName();
    String types = _extractTypes();
    Map<String, dynamic> stats = _extractStats();
    String? imageUrl = _extractImage();

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de $name'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (imageUrl != null)
                      Center(
                        child: Image.network(
                          imageUrl,
                          height: 200,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                        ),
                      )
                    else
                      const Center(
                        child: Icon(Icons.pets, size: 100, color: Colors.grey),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(types),
                      backgroundColor: Colors.blue.shade100,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (stats.isNotEmpty)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Estadísticas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...stats.entries.map((stat) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(stat.key, style: const TextStyle(fontWeight: FontWeight.w500)),
                            Text(stat.value.toString()),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              )
            else
              // Respaldo si no hay estadísticas estructuradas, mostraremos todo el json puro como tabla
              Card(
                elevation: 4,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: pokemonData.keys.length,
                  itemBuilder: (context, index) {
                    String key = pokemonData.keys.elementAt(index);
                    String value = pokemonData[key].toString();
                    return ListTile(
                      title: Text(key.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(value),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
