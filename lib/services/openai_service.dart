import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey;

  OpenAIService(this.apiKey);

  /// Ask GPT to convert a free-form recipe into structured JSON:
  /// {
  ///   "ingredients": [{"name":"Banana","image_prompt":"..."}],
  ///   "steps": [{"instruction":"Mash the bananas","image_prompt":"..."}]
  /// }
  Future<Map<String, dynamic>> generateStructuredRecipe(String recipeText) async {
    final uri = Uri.parse('https://api.openai.com/v1/chat/completions');

    final system = 'You are a friendly chef. Convert the following recipe into a JSON object with two keys: "ingredients" and "steps". ' +
        'Ingredients should be a list of objects with "name" and "image_prompt" fields. ' +
        'Steps should be a list of objects with "instruction" and "image_prompt". ' +
        'Keep instructions short and toddler-friendly. Respond with only valid JSON.';

    final body = {
      'model': 'gpt-4o-mini',
      'messages': [
        {'role': 'system', 'content': system},
        {'role': 'user', 'content': recipeText}
      ],
      'temperature': 0.7,
    };

    final resp = await http.post(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    }, body: jsonEncode(body));

    if (resp.statusCode != 200) {
      throw Exception('OpenAI error: ${resp.statusCode} ${resp.body}');
    }

    final decoded = jsonDecode(resp.body);
    final content = decoded['choices'][0]['message']['content'] as String;

    // try to extract JSON substring in case the model wraps it in backticks
    final jsonStr = _extractJson(content);
    final result = jsonDecode(jsonStr) as Map<String, dynamic>;
    return result;
  }

  String _extractJson(String s) {
    final start = s.indexOf('{');
    final end = s.lastIndexOf('}');
    if (start >= 0 && end > start) return s.substring(start, end + 1);
    return s;
  }
}
