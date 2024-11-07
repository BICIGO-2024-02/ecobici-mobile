import 'package:ecobicimobileapp/models/bicycle_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constants.dart';
import '../models/user_model.dart';

class UserService {
  static const String baseUrl = Constants.url;

  Future<List<User>> getAllUsers(String accessToken) async {
    final response = await http.get(
      Uri.parse("$baseUrl/users"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((userJson) => User.fromJson(userJson)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }

  static Future<User?> getUserById(int userId, String accessToken) async {
    try {
      print('Requesting user with ID: $userId'); // Debug log

      final response = await http.get(
        Uri.parse('$baseUrl/api/ecobici/v1/users/$userId'), // URL corregida
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      print('Response status code: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = jsonDecode(response.body);

        // Convertir las bicicletas del JSON a una lista de BicycleModel
        List<BicycleModel> bicycles = [];
        if (userData['bicycles'] != null) {
          bicycles = (userData['bicycles'] as List)
              .map((bikeJson) => BicycleModel.fromJson(bikeJson))
              .toList();
        }

        // Crear el usuario con los datos recibidos
        return User(
          id: userId, // Usamos el ID que ya tenemos
          firstName: userData['userFirstName'],
          lastName: userData['userLastName'],
          email: userData['userEmail'],
          phone: userData['userPhone'],
          password: '', // No viene en la respuesta
          birthDate: userData['userBirthDate'],
          imageData: userData['imageData'],
          bicycles: bicycles,
        );
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized access. Please login again.");
      } else if (response.statusCode == 404) {
        throw Exception("User not found");
      } else {
        throw Exception("Failed to load user: Status ${response.statusCode}");
      }
    } catch (error) {
      print('Error in getUserById: $error'); // Debug log
      rethrow;
    }
  }

  Future<User> createUser(User user, String accessToken) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create user");
    }
  }

  Future<User> updateUser(int userId, User user, String accessToken) async {
    final response = await http.put(
      Uri.parse("$baseUrl/users/$userId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update user");
    }
  }

  Future<void> deleteUser(int userId, String accessToken) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/users/$userId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode != 204) {
      throw Exception("Failed to delete user");
    }
  }
}
