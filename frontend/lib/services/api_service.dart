// lib/services/api_service.dart

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/brew.dart';

class ApiService {
  // Reads the live Render URL from the .env file
  // Fallback string added in case the key isn't found
  final String baseUrl = dotenv.env['BASE_URL'] ?? 'https://coffee-brew-backend-ktmt.onrender.com';

  // GET /api/brews/
  Future<List<Brew>> fetchBrews({String? brewMethod}) async {
    final String endpoint = brewMethod != null && brewMethod.isNotEmpty
        ? '$baseUrl/api/brews/?brew_method=$brewMethod'
        : '$baseUrl/api/brews/';

    final response = await http.get(Uri.parse(endpoint)).timeout(
      const Duration(seconds: 60), // Handles Render free-tier cold starts
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Brew.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load brews (${response.statusCode})');
    }
  }

  // POST /api/brews/
  Future<Brew> createBrew(Map<String, dynamic> brewData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/brews/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(brewData),
    ).timeout(const Duration(seconds: 60));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Brew.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create brew (${response.statusCode})');
    }
  }

  // PATCH /api/brews/{id}/
  Future<Brew> updateBrew(int id, Map<String, dynamic> brewData) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/api/brews/$id/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(brewData),
    ).timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      return Brew.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update brew (${response.statusCode})');
    }
  }

  // DELETE /api/brews/{id}/
  Future<void> deleteBrew(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/brews/$id/'),
    ).timeout(const Duration(seconds: 60));

    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception('Failed to delete brew (${response.statusCode})');
    }
  }
}