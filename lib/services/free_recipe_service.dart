import 'dart:convert';
import 'package:http/http.dart' as http;

class FreeRecipeService {
  final String jsonUrl;

  FreeRecipeService({required this.jsonUrl});

  Future<List<dynamic>> fetchFreeRecipes() async {
    final resp = await http.get(Uri.parse(jsonUrl));
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body) as List<dynamic>;
    }
    throw Exception('Failed to fetch free recipes: ${resp.statusCode} ${resp.body}');
  }
}
