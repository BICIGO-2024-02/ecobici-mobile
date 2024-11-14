class BicycleModel {
  final int id;
  final String bicycleName;
  final String bicycleDescription;
  final double bicyclePrice;
  final String bicycleSize;
  final String bicycleModel;
  final String imageData;
  final String pickUpLocation;
  final String deliveryLocation;

  BicycleModel({
    required this.id,
    required this.bicycleName,
    required this.bicycleDescription,
    required this.bicyclePrice,
    required this.bicycleSize,
    required this.bicycleModel,
    required this.imageData,
    required this.pickUpLocation,
    required this.deliveryLocation
  });

  factory BicycleModel.fromJson(Map<String, dynamic> json) {
    return BicycleModel(
      id: json['id'],
      bicycleName: json['bicycleName'],
      bicycleDescription: json['bicycleDescription'],
      bicyclePrice: json['bicyclePrice'].toDouble(),
      bicycleSize: json['bicycleSize'],
      bicycleModel: json['bicycleModel'],
      imageData: json['imageData'],
      pickUpLocation: json['pickUpLocation'],
      deliveryLocation: json['deliveryLocation']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bicycleName': bicycleName,
      'bicycleDescription': bicycleDescription,
      'bicyclePrice': bicyclePrice,
      'bicycleSize': bicycleSize,
      'bicycleModel': bicycleModel,
      'imageData': imageData,
      'pickUpLocation': pickUpLocation,
      'deliveryLocation': deliveryLocation
    };
  }
}