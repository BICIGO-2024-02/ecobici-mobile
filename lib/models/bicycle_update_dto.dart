class BicycleUpdateDto {
  final String bicycleName;
  final String bicycleDescription;
  final double bicyclePrice;
  final String bicycleSize;
  final String bicycleModel;
  final String? imageData;

  BicycleUpdateDto({
    required this.bicycleName,
    required this.bicycleDescription,
    required this.bicyclePrice,
    required this.bicycleSize,
    required this.bicycleModel,
    this.imageData,
  });

  Map<String, dynamic> toJson() {
    return {
      'bicycleName': bicycleName,
      'bicycleDescription': bicycleDescription,
      'bicyclePrice': bicyclePrice,
      'bicycleSize': bicycleSize,
      'bicycleModel': bicycleModel,
      'imageData': imageData,
    };
  }
}