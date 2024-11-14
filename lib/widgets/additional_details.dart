import 'package:flutter/material.dart';

class AdditionalDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Más detalles'),
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Tamaño del marco',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Tamaño de la rueda',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Número de engranajes',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Tipo de freno',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Material',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}