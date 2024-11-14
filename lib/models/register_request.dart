class RegisterRequest {
  final String userFirstName;
  final String userLastName;
  final String userEmail;
  final String userPassword;
  final String? userPhone;
  final DateTime? userBirthDate;
  final String? imageData;
  final String role;

  RegisterRequest({
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    required this.userPassword,
    this.userPhone,
    this.userBirthDate,
    this.imageData,
    this.role = 'USER',
  });

  Map<String, dynamic> toJson() {
    return {
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'userEmail': userEmail,
      'userPassword': userPassword,
      'userPhone': userPhone,
      'userBirthDate': userBirthDate?.toIso8601String().split('T')[0], // Formato YYYY-MM-DD si existe
      'imageData': imageData,
      'role': role,
    };
  }
}