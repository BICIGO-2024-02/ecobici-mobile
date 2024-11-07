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
}
