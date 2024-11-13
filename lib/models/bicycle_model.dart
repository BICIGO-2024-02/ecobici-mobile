class BicycleModel {
  final int id;
  final String bicycleName;
  final String bicycleDescription;
  final double bicyclePrice;
  final String bicycleSize;
  final String bicycleModel;
  final String imageData;

  BicycleModel({
    required this.id,
    required this.bicycleName,
    required this.bicycleDescription,
    required this.bicyclePrice,
    required this.bicycleSize,
    required this.bicycleModel,
    required this.imageData,
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
    };
  }
}