import 'package:flutter/material.dart';

class AdditionalDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Additional Details'),
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Frame Size',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Wheel Size',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Number of Gears',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Brake Type',
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