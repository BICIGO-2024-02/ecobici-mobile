import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../models/auth.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';

class AuthService {
  static final String baseUrl = Constants.url;

  static Future<void> _saveAuthData(AuthModel authModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', authModel.userId);
    await prefs.setString('access_token', authModel.accessToken);
    await prefs.setString('refresh_token', authModel.refreshToken);
  }

  static Future<void> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String repeatPassword, {
    String? phone,
    DateTime? birthDate,
    String? imageData,
  }) async {
    if (password != repeatPassword) {
      throw Exception('Las contraseñas no coinciden');
    }

    try {
      final registerRequest = RegisterRequest(
        userFirstName: firstName,
        userLastName: lastName,
        userEmail: email,
        userPassword: password,
        userPhone: phone,
        userBirthDate: birthDate,
        imageData: imageData,
      );
      
      var url = Uri.parse('${Constants.url}/api/ecobici/v1/auth/register');

      var response = await http.post(
        url,
        body: jsonEncode(registerRequest.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        var responseBody = json.decode(response.body);
        var authModel = AuthModel.fromJson(responseBody);
        
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', authModel.userId);
        await prefs.setString('access_token', authModel.accessToken);
        await prefs.setString('refresh_token', authModel.refreshToken);

        return Future.value();
      } else if (response.statusCode == 400) {
        var responseBody = json.decode(response.body);
        return Future.error(responseBody['message'] ?? 'Error en el registro');
      } else {
        return Future.error('Error en la petición: ${response.statusCode}');
      }
    } catch (error) {
      return Future.error('Error de conectividad: $error');
    }
  }

  static Future<void> login(String email, String password) async {
    try {
      final loginRequest = LoginRequest(
        userEmail: email,
        userPassword: password,
      );

      final response = await http.post(
        Uri.parse('$baseUrl/api/ecobici/v1/auth/login'),
        body: jsonEncode(loginRequest.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final authModel = AuthModel.fromJson(jsonDecode(response.body));
        await _saveAuthData(authModel);
      } else {
        throw Exception('El email o la contraseña son incorrectos');
      }
    } catch (error) {
      throw Exception('Error de conectividad: $error');
    }
  }
}
