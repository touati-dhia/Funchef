import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class StabilityService {
  final String apiKey;
  StabilityService(this.apiKey);

  /// Generates an image with Stability and saves it to the app documents directory.
  /// Returns the local file path to the generated PNG.
  Future<String> generateAndSaveImage(String prompt, String filename) async {
    final url = Uri.parse('https://api.stability.ai/v1/generation/stable-diffusion-v1-5/text-to-image');

    final body = {
      'text_prompts': [
        {'text': prompt}
      ],
      'cfg_scale': 7,
      'width': 512,
      'height': 512
    };

    final resp = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(body));

    if (resp.statusCode != 200) {
      throw Exception('Stability API error: ${resp.statusCode} ${resp.body}');
    }

    final decoded = jsonDecode(resp.body);
    if (decoded == null || decoded['artifacts'] == null || decoded['artifacts'].isEmpty) {
      throw Exception('Invalid stability response: ${resp.body}');
    }

    final base64Data = decoded['artifacts'][0]['base64'] as String;
    final bytes = base64Decode(base64Data);

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename.png');
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
