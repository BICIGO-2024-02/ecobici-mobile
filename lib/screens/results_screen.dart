import 'package:flutter/material.dart';

import 'package:ecobicimobileapp/widgets/bottomBikeDetailSheet.dart';

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Results',
          style: TextStyle(
            color: Color(0xFF325D67),
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '15 Results',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildResultCard(
                    context,
                    name: 'Giant ATX 2',
                    type: 'Mountain Bike',
                    price: 'S/ 30/day',
                    frameSize: '19 inches',
                    frameMaterial: 'Aluminium',
                    gears: '21',
                    brakes: 'Disc Brakes',
                    weight: '15 kg',
                  ),
                  _buildResultCard(
                    context,
                    name: 'Trek Marlin 5',
                    type: 'Road Bike',
                    price: 'S/ 25/day',
                    frameSize: '17 inches',
                    frameMaterial: 'Carbon',
                    gears: '24',
                    brakes: 'Rim Brakes',
                    weight: '14 kg',
                  ),
                ],
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  // Acción para mostrar más resultados
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFF325D67),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   // Método para crear la tarjeta de resultados
  Widget _buildResultCard(
    BuildContext context, {
    required String name,
    required String type,
    required String price,
    required String frameSize,
    required String frameMaterial,
    required String gears,
    required String brakes,
    required String weight,
  }) {
    return GestureDetector(
      onTap: () {
        // Muestra el BottomSheet cuando se presiona la tarjeta
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => BikeDetailBottomSheet(
            type: type,
            frameSize: frameSize,
            frameMaterial: frameMaterial,
            gears: gears,
            brakes: brakes,
            weight: weight,
            price: price,
          ),
        );
      },
      child: Card(
        color: Colors.white, // Color blanco para las tarjetas
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        margin: EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.grey[200],
                  height: 80,
                  width: 80,
                  child: Icon(Icons.directions_bike, size: 50), // Placeholder para la imagen
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF325D67),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}