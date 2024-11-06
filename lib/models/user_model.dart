// User Model in Dart
class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? phone;
  final String birthDate;
  final String? imageData;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.phone,
    required this.birthDate,
    this.imageData,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['userFirstName'],
      lastName: json['userLastName'],
      email: json['userEmail'],
      password: json['userPassword'],
      phone: json['userPhone'],
      birthDate: json['userBirthDate'],
      imageData: json['imageData'],
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
    };
  }
}