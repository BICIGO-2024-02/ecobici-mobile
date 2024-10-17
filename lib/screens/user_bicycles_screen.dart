import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/widgets/bicycle_card.dart';
import 'package:ecobicimobileapp/widgets/add_bicycle_button.dart';
import 'add_bicycle_screen.dart';
import 'bicycle_details_screen.dart';

class UserBicyclesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bicycles = [
    {'id': '1', 'name': 'Mountain Bike', 'type': 'Mountain', 'pricePerHour': 15},
    {'id': '2', 'name': 'City Cruiser', 'type': 'City', 'pricePerHour': 10},
    {'id': '3', 'name': 'Road Racer', 'type': 'Road', 'pricePerHour': 20},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bicycles'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          AddBicycleButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBicycleScreen()),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: bicycles.length,
              itemBuilder: (context, index) {
                final bicycle = bicycles[index];
                return BicycleCard(
                  bicycle: bicycle,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BicycleDetailsScreen(bicycle: bicycle),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
