import 'bicycle_model.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? phone;
  final String birthDate;
  final String? imageData;
  final List<BicycleModel> bicycles; // Añadimos la lista de bicicletas

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.phone,
    required this.birthDate,
    this.imageData,
    required this.bicycles, // Hacemos required la lista de bicicletas
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Convertimos el array de bicicletas
    List<BicycleModel> bicyclesList = [];
    if (json['bicycles'] != null) {
      bicyclesList = List<BicycleModel>.from(
          json['bicycles'].map((x) => BicycleModel.fromJson(x)));
    }

    return User(
      id: json['id'],
      firstName: json['userFirstName'],
      lastName: json['userLastName'],
      email: json['userEmail'],
      password: json['userPassword'],
      phone: json['userPhone'],
      birthDate: json['userBirthDate'],
      imageData: json['imageData'],
      bicycles: bicyclesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userFirstName': firstName,
      'userLastName': lastName,
      'userEmail': email,
      'userPassword': password,
      'userPhone': phone,
      'userBirthDate': birthDate,
      'imageData': imageData,
      'bicycles': bicycles.map((bike) => bike.toJson()).toList(),
    };
  }
}
