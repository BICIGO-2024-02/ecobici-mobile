import 'dart:convert';
import 'package:ecobicimobileapp/models/rent_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/bicycle_model.dart';

class RentService {
  final String accessToken;

  RentService({required this.accessToken});

  static const String baseUrl =
      'https://bicigo-a5evdzeubdgveuau.eastus2-01.azurewebsites.net/api/ecobici/v1/rents';

  // Encabezados comunes para todas las peticiones
  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

  // Crear un alquiler
  Future<RentModel> createRent(RentModel rent) async {
    final url = Uri.parse('$baseUrl');
    final response = await http.post(
      url,
      headers: _headers, // Usamos el encabezado con el token de acceso
      body: json.encode(rent.toJson()),
    );

    if (response.statusCode == 201) {
      return RentModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear el alquiler');
    }
  }

  // Obtener un alquiler por ID
  Future<RentModel> getRent(int rentId) async {
    final url = Uri.parse('$baseUrl/$rentId');
    final response = await http.get(url,
        headers: _headers); // Usamos el encabezado con el token de acceso

    if (response.statusCode == 200) {
      return RentModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener el alquiler');
    }
  }

  // Eliminar un alquiler por ID
  Future<void> deleteRent(int rentId) async {
    final url = Uri.parse('$baseUrl/$rentId');
    final response = await http.delete(url,
        headers: _headers); // Usamos el encabezado con el token de acceso

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el alquiler');
    }
  }

  // Obtener los alquileres de una bicicleta por ID
  Future<List<RentModel>> getRentsByBicycleId(int bicycleId) async {
    final url = Uri.parse('$baseUrl/bicycle/$bicycleId');
    final response = await http.get(url,
        headers: _headers); // Usamos el encabezado con el token de acceso

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((rent) => RentModel.fromJson(rent)).toList();
    } else {
      throw Exception('Error al obtener los alquileres');
    }
  }
}
