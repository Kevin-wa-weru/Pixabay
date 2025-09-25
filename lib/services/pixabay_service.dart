import 'dart:convert';
import 'package:http/http.dart' as http;

class PixabayService {
  final String apiKey = "52459238-380dd494e5efb843b4307936f";

  Future<List<dynamic>> fetchTrendingImages() async {
    final url =
        "https://pixabay.com/api/?key=$apiKey&q=popular&image_type=photo&per_page=20";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["hits"] ?? [];
    } else {
      throw Exception("Failed to load images");
    }
  }

  Future<List<dynamic>> searchImages(String query) async {
    final url =
        "https://pixabay.com/api/?key=$apiKey&q=${Uri.encodeQueryComponent(query)}&image_type=photo&per_page=30";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["hits"] ?? [];
    } else {
      throw Exception("Failed to search images");
    }
  }
}