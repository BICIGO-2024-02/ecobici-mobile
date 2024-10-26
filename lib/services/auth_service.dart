import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';

class AuthService {
  static Future<void> register(String name, String lastname, String email, String password, String repeatPassword) async {
    if (password != repeatPassword) {
      return Future.error('Las contraseñas no coinciden');
    }

    try {
      var url = Uri.parse('${Constants.url}/api/v1/auth/register');

      var response = await http.post(
        url,
        body: jsonEncode({
          'firstName': name,
          'lastName': lastname,
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {

        var responseBody = json.decode(response.body);
        var user_id = responseBody['user_id'];
        var accessToken = responseBody['access_token'];
        var refreshToken = responseBody['refresh_token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('access_token', accessToken);
        await prefs.setString('refresh_token', refreshToken);
        await prefs.setInt('user_id', user_id);

        return Future.value();
      } else if (response.statusCode == 400) {
        var responseBody = json.decode(response.body);
        var message = responseBody['message'];
        return Future.error('$message');
      } else {
        return Future.error('Request error: ${response.statusCode}');
      }
    } catch (error) {
      return Future.error('Error on connectivity: $error');
    }
  }

  static Future<void> login(String email, String password) async {

    try {
      var url = Uri.parse('${Constants.url}/api/v1/auth/login');

      var response = await http.post(
        url,
        body: jsonEncode({
          'userEmail': email,
          'userPassword': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {

        var responseBody = json.decode(response.body);
        var user_id = responseBody['user_id'];
        var accessToken = responseBody['access_token'];
        var refreshToken = responseBody['refresh_token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('access_token', accessToken);
        await prefs.setString('refresh_token', refreshToken);
        await prefs.setInt('user_id', user_id);

        return Future.value();
      } else {
        return Future.error('El email o la contraseña son incorrectos');
      }
    } catch (error) {
      return Future.error('Error on connectivity: $error');
    }
  }
}