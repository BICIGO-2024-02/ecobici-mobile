import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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

  static Future<User> getUserById(int userId, String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/ecobici/v1/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        return Future.error('Error al obtener el usuario: ${response.statusCode}');
      }
    } catch (error) {
      return Future.error('Error de conectividad en getUserById: $error');
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

  static Future<void> updateUser(name, lastname, email) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt('user_id') ?? 0;
    String accessToken = prefs.getString('access_token') ?? '';

    final response = await http.put(
      Uri.parse("$baseUrl/api/ecobici/v1/users/$userId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'userFirstName': name,
        'userLastName': lastname,
        'userEmail': email,
      })
    );

    if (response.statusCode == 200) {
      return;
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
