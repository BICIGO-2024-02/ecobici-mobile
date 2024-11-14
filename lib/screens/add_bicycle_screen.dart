import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/services/bicycle_service.dart';
import 'package:ecobicimobileapp/models/bicycle_model.dart';
import 'package:ecobicimobileapp/services/auth_service.dart';

class AddBikeScreen extends StatefulWidget {
  @override
  _AddBikeScreenState createState() => _AddBikeScreenState();
}

class _AddBikeScreenState extends State<AddBikeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _sizeController = TextEditingController();
  final _modelController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _pickUpLocationController = TextEditingController();
  final _deliveryLocationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Escuchar cambios en la URL de la imagen para actualizar la vista previa
    _imageUrlController.addListener(() {
      setState(() {}); // Esto actualizará la UI cuando cambie la URL
    });
  }

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return true; // URL vacía es válida
    return url.startsWith('http://') || url.startsWith('https://');
  }

  void _showImageUrlHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ayuda'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Para la URL de la imagen, puede:'),
            SizedBox(height: 8),
            Text('• Utilice cualquier URL de imagen pública que termine en .jpg, .jpeg o .png.'),
            Text('• Asegúrese de que la URL comience con http:// o https://'),
            Text('• Utilice servicios de alojamiento de imágenes como:'),
            Text('  - imgur.com'),
            Text('  - cloudinary.com'),
            Text('  - imgbb.com'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final token = await AuthService.getCurrentUserToken();
        final userId = await AuthService.getCurrentUserId();

        if (token == null || userId == null) {
          throw Exception('No se encontró ningún token de autenticación');
        }

        print('UserID: $userId'); // Debug log
        print('Token: $token'); // Debug log

        final bicycleService = BicycleService(
          accessToken: token,
          userId: userId.toString(),
        );

        final newBicycle = BicycleModel(
          id: 0,
          bicycleName: _nameController.text.trim(),
          bicycleDescription: _descriptionController.text.trim(),
          bicyclePrice: double.parse(_priceController.text.trim()),
          bicycleSize: _sizeController.text.trim(),
          bicycleModel: _modelController.text.trim(),
          imageData: _imageUrlController.text.trim().isEmpty ? "" : _imageUrlController.text.trim(),
          pickUpLocation: _pickUpLocationController.text.trim(),
          deliveryLocation: _deliveryLocationController.text.trim(),
        );

        print('Bicycle data being sent: ${json.encode(newBicycle.toJson())}');

        final addedBicycle = await bicycleService.addBicycleToUser(newBicycle);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('¡Bicicleta agregada exitosamente!')),
        );

        Navigator.pop(context, addedBicycle);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            duration: Duration(seconds: 4),
          ),
        );
        print('Error in _submitForm: $e'); // Debug log
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF325D67)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Agregar nueva bicicleta',
            style: TextStyle(
                color: Color(0xFF325D67), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detalles de la bicicleta',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF325D67)),
              ),
              SizedBox(height: 24),
              _buildTextField(
                'Nombre de la bicicleta',
                Icons.pedal_bike,
                _nameController,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Por favor ingresa el nombre de una bicicleta';
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextField(
                'Descripción',
                Icons.description,
                _descriptionController,
                validator: (value) {
                  if (value?.isEmpty ?? true)
                    return 'Por favor ingresa una descripción';
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextField(
                'Precio por dia',
                Icons.attach_money,
                _priceController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Por favor introduce un precio';
                  if (double.tryParse(value!) == null)
                    return 'Por favor ingresa un número válido';
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextField(
                'Tamaño',
                Icons.straighten,
                _sizeController,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Por favor introduce una talla';
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextField(
                'Lugar de recojo',
                Icons.place,
                _pickUpLocationController,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Por favor introduce el lugar de recojo';
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextField(
                'Lugar de entrega',
                Icons.place,
                _deliveryLocationController,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Por favor introduce el lugar de entrega';
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextField(
                'Modelo',
                Icons.category,
                _modelController,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Por favor introduce un modelo';
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextField(
                'URL de la imagen (opcional)',
                Icons.link,
                _imageUrlController,
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      !_isValidImageUrl(value)) {
                    return 'Introduzca una URL válida que comience con http:// o https://';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () => _showImageUrlHelp(context),
                ),
              ),
              SizedBox(height: 16),
              if (_imageUrlController.text.isNotEmpty &&
                  _isValidImageUrl(_imageUrlController.text))
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      _imageUrlController.text,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text('Error al cargar la imagen',
                              style: TextStyle(color: Colors.red)),
                        );
                      },
                    ),
                  ),
                ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Añadir bicicleta', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF325D67),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(double.infinity, 60),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      IconData icon,
      TextEditingController controller, {
        TextInputType? keyboardType,
        String? Function(String?)? validator,
        Widget? suffixIcon,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF325D67)),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0.8),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _sizeController.dispose();
    _modelController.dispose();
    _imageUrlController.dispose();
    _pickUpLocationController.dispose();
    _deliveryLocationController.dispose();
    super.dispose();
  }
}