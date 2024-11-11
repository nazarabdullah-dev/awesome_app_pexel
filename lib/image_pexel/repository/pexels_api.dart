import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_app/image_pexel/models/image_data.dart'; // Import the new models file
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv package

class PexelsApi {
  static const String _baseUrl = 'https://api.pexels.com/v1/curated';

  final http.Client httpClient;

  PexelsApi({http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<List<ImageData>> fetchImages({int page = 1, int perPage = 16}) async {
    final String apiKey = dotenv.env['PEXELS_API_KEY'] ?? '';
    final response = await httpClient.get(
      Uri.parse('$_baseUrl?page=$page&per_page=$perPage'),
      headers: {'Authorization': apiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List images = data['photos'];
      return images.map((json) => ImageData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
