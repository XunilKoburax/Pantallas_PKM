import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api/pokemon/name';

  Future<Map<String, dynamic>?> getPokemonByName(String name) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$name'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
