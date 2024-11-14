import 'dart:convert';
import 'package:ecobicimobileapp/models/rent_request_model.dart';
import 'package:http/http.dart' as http;
import '../models/rent_model.dart';

class RentService {
  final String accessToken;

  RentService({required this.accessToken});

  static const String baseUrl =
      'https://bicigo-a5evdzeubdgveuau.eastus2-01.azurewebsites.net/api/ecobici/v1/rents';

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };

  Future<RentModel> createRent(RentRequestModel rentRequest) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: _headers,
        body: json.encode(rentRequest.toJson()),
      );

      if (response.statusCode == 201) {
        return RentModel.fromJson(json.decode(response.body));
      } else {
        print('Error Response: ${response.body}');
        throw Exception(
            'Failed to create rent. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating rent: $e');
    }
  }

  Future<List<RentModel>> getBicycleRentals(int bicycleId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/bicycle/$bicycleId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Procesar la respuesta si es exitosa
        try {
          final List<dynamic> data = json.decode(response.body);
          print('Decoded data: $data');

          // Mapear los datos a objetos RentModel
          List<RentModel> rentals = data.map((rental) => RentModel.fromJson(rental)).toList();
          return rentals;
        } catch (e) {
          print('Error al decodificar la respuesta: $e');
          throw Exception('Failed to parse response');
        }
      } else {
        print('Error en la respuesta de la API: ${response.statusCode}');
        throw Exception('Failed to load rentals');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error fetching rentals: $e');
    }
  }

  Future<List<RentModel>> getUserRentals(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/$userId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Procesar la respuesta si es exitosa
        try {
          final List<dynamic> data = json.decode(response.body);
          print('Decoded data: $data');

          // Mapear los datos a objetos RentModel
          List<RentModel> rentals = data.map((rental) => RentModel.fromJson(rental)).toList();
          return rentals;
        } catch (e) {
          print('Error al decodificar la respuesta: $e');
          throw Exception('Failed to parse response');
        }
      } else {
        print('Error en la respuesta de la API: ${response.statusCode}');
        throw Exception('Failed to load rentals');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error fetching rentals: $e');
    }
  }

}