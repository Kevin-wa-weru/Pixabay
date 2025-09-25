import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileService {
  final String _baseUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<int> saveProfile(Map<String, dynamic> profileData) async {
    final url = Uri.parse(_baseUrl);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(profileData),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['id'];
    } else {
      throw Exception("Failed to save profile: ${response.statusCode}");
    }
  }
}
