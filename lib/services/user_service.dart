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
      final response = await http.get(
        Uri.parse('$baseUrl/api/ecobici/v1/user/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        print('Error al obtener el usuario: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error de conectividad en getUserById: $error');
      return null;
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
