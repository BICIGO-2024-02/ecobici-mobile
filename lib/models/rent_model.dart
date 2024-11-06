import 'bicycle_model.dart';

class RentModel {
  final int id;
  final String rentStartDate;
  final String rentEndDate;
  final double rentPrice;
  final BicycleModel bicycle; // Usamos BicycleModel en lugar de Bicycle

  RentModel({
    required this.id,
    required this.rentStartDate,
    required this.rentEndDate,
    required this.rentPrice,
    required this.bicycle,
  });

  // Método para convertir un JSON a un objeto Rent
  factory RentModel.fromJson(Map<String, dynamic> json) {
    return RentModel(
      id: json['id'],
      rentStartDate: json['rentStartDate'],
      rentEndDate: json['rentEndDate'],
      rentPrice: json['rentPrice'].toDouble(),
      bicycle:
          BicycleModel.fromJson(json['bicycle']), // Usamos BicycleModel aquí
    );
  }

  // Método para convertir un objeto Rent a un JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rentStartDate': rentStartDate,
      'rentEndDate': rentEndDate,
      'rentPrice': rentPrice,
      'bicycle': bicycle.toJson(),
    };
  }
}
