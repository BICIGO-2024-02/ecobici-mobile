import 'package:flutter/material.dart';
import '../widgets/bicycle_form.dart';

class EditBicycleScreen extends StatelessWidget {
  final Map<String, dynamic> bicycle;

  const EditBicycleScreen({Key? key, required this.bicycle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Bicycle'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BicycleForm(
          ),
        ),
      ),
    );
  }
}
