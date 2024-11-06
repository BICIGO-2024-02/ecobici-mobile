import 'dart:convert';
import 'package:ecobicimobileapp/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../models/auth.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../models/user_model.dart';

class AuthService {
  static const String baseUrl = Constants.url;

  static Future<void> _saveAuthData(AuthModel authModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', authModel.userId);
    await prefs.setString('access_token', authModel.accessToken);
    await prefs.setString('refresh_token', authModel.refreshToken);
  }

  static Future<int?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  static Future<String?> getCurrentUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
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
        //await fetchAndSaveUserData();
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
        //await fetchAndSaveUserData();
      } else {
        throw Exception('El email o la contraseña son incorrectos');
      }
    } catch (error) {
      throw Exception('Error de conectividad: $error');
    }
  }

  static Future<void> fetchAndSaveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final accessToken = prefs.getString('access_token');

    if (userId != null && accessToken != null) {
      try {
        // Llamamos al servicio de usuario para obtener los datos completos del usuario
        final user = await UserService.getUserById(userId, accessToken);

        if (user != null) {
          await _saveUserData(user);
          print('Información completa del usuario guardada.');
        } else {
          throw Exception('No se pudo obtener la información del usuario.');
        }
      } catch (error) {
        throw Exception('Error de conectividad: $error');
      }
    } else {
      print(
          'No se encontró el user_id o el access_token en SharedPreferences.');
    }
  }

  static Future<void> _saveUserData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('user_id', user.id);
    await prefs.setString('user_first_name', user.firstName);
    await prefs.setString('user_last_name', user.lastName);
    await prefs.setString('user_email', user.email);
    await prefs.setString('user_password', user.password);
    await prefs.setString('user_birth_date', user.birthDate);

    if (user.phone != null) {
      await prefs.setString('user_phone', user.phone!);
    }
    if (user.imageData != null) {
      await prefs.setString('user_image_data', user.imageData!);
    }

    print('Datos completos del usuario guardados en SharedPreferences:');
    print('user_id: ${user.id}');
    print('user_first_name: ${user.firstName}');
    print('user_last_name: ${user.lastName}');
    print('user_email: ${user.email}');
    print('user_birth_date: ${user.birthDate}');
  }
}
