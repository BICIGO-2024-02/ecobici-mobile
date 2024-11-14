import 'package:flutter/material.dart';

class AddBicycleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddBicycleButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(Icons.add),
        label: Text('Añadir bicicleta'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF325D67),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }
}