import 'package:ecobicimobileapp/screens/booking_screen.dart';
import 'package:flutter/material.dart';

class BikeDetailBottomSheet extends StatelessWidget {
  final String type;          // Tipo de bicicleta (e.g., Montaña, Ruta)
  final String frameSize;     // Tamaño del marco (e.g., 19 pulgadas)
  final String frameMaterial; // Material del marco (e.g., Aluminio)
  final String gears;         // Velocidades (e.g., 21 velocidades)
  final String brakes;        // Tipo de frenos (e.g., Disco)
  final String weight;        // Peso de la bicicleta (e.g., 15 kg)
  final String price;         // Precio por día

  const BikeDetailBottomSheet({
    Key? key,
    required this.type,
    required this.frameSize,
    required this.frameMaterial,
    required this.gears,
    required this.brakes,
    required this.weight,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del BottomSheet al contenido
        children: [
          Text(
            'Bike Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF325D67),
            ),
          ),
          SizedBox(height: 20),
          _buildInfoRow('Type', type),
          _buildInfoRow('Frame Size', frameSize),
          _buildInfoRow('Frame Material', frameMaterial),
          _buildInfoRow('Gears', gears),
          _buildInfoRow('Brakes', brakes),
          _buildInfoRow('Weight', weight),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingScreen()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF325D67),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
              child: Text("Book Today for $price", style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Método para construir cada fila de información
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}