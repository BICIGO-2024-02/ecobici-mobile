import 'package:flutter/foundation.dart';

import 'bicycle_model.dart';

class BicycleUpdateDto {
  final String bicycleName;
  final String bicycleDescription;
  final double bicyclePrice;
  final String bicycleSize;
  final String bicycleModel;
  final String? imageData;
  final String pickUpLocation;
  final String deliveryLocation;

  BicycleUpdateDto({
    required this.bicycleName,
    required this.bicycleDescription,
    required this.bicyclePrice,
    required this.bicycleSize,
    required this.bicycleModel,
    this.imageData,
    required this.pickUpLocation,
    required this.deliveryLocation
  });

  Map<String, dynamic> toJson() {
    return {
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