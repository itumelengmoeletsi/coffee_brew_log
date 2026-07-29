import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/brew.dart';

class ApiService {
  // Your live Render host domain without protocol or trailing slash
  static const String _host = 'coffee-brew-backend-ktmt.onrender.com';
  
  // Base path prefix for all endpoints
  static const String _basePath = '/api/brews';

  // GET /api/brews/
  Future<List<Brew>> fetchBrews({String? brewMethod}) async {
    final Map<String, String> queryParams = {};
    if (brewMethod != null && brewMethod.isNotEmpty) {
      queryParams['brew_method'] = brewMethod;
    }

    // Uri.https automatically handles SSL and builds query parameters cleanly
    final Uri uri = Uri.https(_host, '$_basePath/', queryParams);
    
    final response = await http.get(uri).timeout(
      const Duration(seconds: 60), // Handles Render's cold-start wake-up delay
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
    final Uri uri = Uri.https(_host, '$_basePath/');
    
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(brewData),
    ).timeout(const Duration(seconds: 60));

    // Accepts both 200 OK or 201 Created depending on FastAPI response model
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Brew.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create brew (${response.statusCode})');
    }
  }

  // PATCH /api/brews/{id}/
  Future<Brew> updateBrew(int id, Map<String, dynamic> brewData) async {
    final Uri uri = Uri.https(_host, '$_basePath/$id/');
    
    final response = await http.patch(
      uri,
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
    final Uri uri = Uri.https(_host, '$_basePath/$id/');
    
    final response = await http.delete(uri).timeout(const Duration(seconds: 60));

    // Checks for 204 No Content or 200 OK
    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception('Failed to delete brew (${response.statusCode})');
    }
  }
}