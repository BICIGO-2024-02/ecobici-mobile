import 'package:flutter/material.dart';
import 'form_fields.dart';
import 'additional_details.dart';

class BicycleForm extends StatefulWidget {
  @override
  _BicycleFormState createState() => _BicycleFormState();
}

class _BicycleFormState extends State<BicycleForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BasicFormFields(),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement image upload
            },
            icon: Icon(Icons.upload),
            label: Text('Subir imágenes'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF325D67),
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          SizedBox(height: 16),
          AdditionalDetails(),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isLoading ? null : _submitForm,
            child: _isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text('Publicar bicicleta'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF325D67),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // TODO: Implement bicycle submission
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bicycle published successfully'),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
  }
}