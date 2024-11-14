import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/screens/booking_screen.dart';
import 'package:ecobicimobileapp/models/bicycle_model.dart';

class BikeDetailBottomSheet extends StatelessWidget {
  final String name;
  final String description;
  final String model;
  final String size;
  final String pickUpLocation;
  final String deliveryLocation;
  final String price;
  final BicycleModel bicycle; // Añadimos la bicicleta como parámetro

  const BikeDetailBottomSheet({
    Key? key,
    required this.name,
    required this.description,
    required this.model,
    required this.size,
    required this.pickUpLocation,
    required this.deliveryLocation,
    required this.price,
    required this.bicycle, // Añadimos el requerimiento de la bicicleta
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Información de bicicleta',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF325D67),
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow('Nombre', name),
          _buildInfoRow('Descripcion', description),
          _buildInfoRow('Modelo', model),
          _buildInfoRow('Tamaño', size),
          _buildInfoRow('Lugar de recojo', pickUpLocation),
          _buildInfoRow('Lugar de entrega', deliveryLocation),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingScreen(bicycle: bicycle),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF325D67),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
              child: Text("Reserva hoy por $price",
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}