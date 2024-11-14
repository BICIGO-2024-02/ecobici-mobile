class RentRequestModel {
  final String rentStartDate;
  final String rentEndDate;
  final double rentPrice;
  final int bicycleId;

  RentRequestModel({
    required this.rentStartDate,
    required this.rentEndDate,
    required this.rentPrice,
    required this.bicycleId,
  });

  Map<String, dynamic> toJson() {
    return {
      'rentStartDate': rentStartDate,
      'rentEndDate': rentEndDate,
      'rentPrice': rentPrice,
      'bicycleId': bicycleId,
    };
  }
}