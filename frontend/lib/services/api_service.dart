import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/brew.dart';

class ApiService {
  // Use 10.0.2.2 for Android Emulator, localhost for Windows/Web app
  static const String baseUrl = 'http://localhost:8000';

  // GET api/brews/
  Future<List<Brew>> fetchBrews() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Brew.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load brews');
    }
  }

  // POST /api/brews/
  Future<Brew> createBrew(Map<String, dynamic> brewData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(brewData),
    );

    if (response.statusCode == 201) {
      return Brew.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create brew');
    }
  }

  // DELETE /api/brews/{id}
  Future<void> deleteBrew(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete brew');
    }
  }
}
