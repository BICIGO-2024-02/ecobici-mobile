import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bicycle_model.dart';

class BicycleService {
  final String baseUrl =
      'https://bicigo-a5evdzeubdgveuau.eastus2-01.azurewebsites.net/api/ecobici/v1';
  final String accessToken;
  final String userId;

  BicycleService({required this.accessToken, required this.userId});

  // Headers with authentication
  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

  // Get all bicycles
  Future<List<BicycleModel>> getAllBicycles() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/bicycles'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => BicycleModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load bicycles');
      }
    } catch (e) {
      throw Exception('Error getting bicycles: $e');
    }
  }

  // Get bicycle by ID
  Future<BicycleModel> getBicycleById(int bicycleId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/bicycles/$bicycleId'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return BicycleModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load bicycle');
      }
    } catch (e) {
      throw Exception('Error getting bicycle: $e');
    }
  }

  // Update bicycle
  Future<BicycleModel> updateBicycle(
      int bicycleId, BicycleModel bicycle) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/bicycles/$bicycleId'),
        headers: _headers,
        body: json.encode(bicycle.toJson()),
      );

      if (response.statusCode == 200) {
        return BicycleModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update bicycle');
      }
    } catch (e) {
      throw Exception('Error updating bicycle: $e');
    }
  }

  // Delete bicycle
  Future<String> deleteBicycle(int bicycleId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/bicycles/$bicycleId'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to delete bicycle');
      }
    } catch (e) {
      throw Exception('Error deleting bicycle: $e');
    }
  }

  Future<BicycleModel> addBicycleToUser(BicycleModel bicycle) async {
    try {
      // URL corregida sin duplicar el path
      final response = await http.post(
        Uri.parse('$baseUrl/bicycles/$userId'),
        headers: _headers,
        body: json.encode(bicycle.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return BicycleModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Failed to add bicycle: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error adding bicycle: $e'); // Debug log
      throw Exception('Error adding bicycle: $e');
    }
  }
}
