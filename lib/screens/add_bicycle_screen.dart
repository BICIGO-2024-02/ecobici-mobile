import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/widgets/bicycle_form.dart';

class AddBicycleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Bicycle'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Drive in style',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              BicycleForm(),
            ],
          ),
        ),
      ),
    );
  }
}