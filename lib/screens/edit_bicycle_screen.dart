import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/services/bicycle_service.dart';
import 'package:ecobicimobileapp/models/bicycle_model.dart';
import 'package:ecobicimobileapp/models/bicycle_update_dto.dart';
import 'package:ecobicimobileapp/services/auth_service.dart';

class EditBikeScreen extends StatefulWidget {
  final BicycleModel bicycle;

  const EditBikeScreen({Key? key, required this.bicycle}) : super(key: key);

  @override
  _EditBikeScreenState createState() => _EditBikeScreenState();
}

class _EditBikeScreenState extends State<EditBikeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _sizeController;
  late final TextEditingController _modelController;
  late final TextEditingController _imageUrlController;
  late final TextEditingController _pickUpLocationController;
  late final TextEditingController _deliveryLocationController;

  @override
  void initState() {
    super.initState();
    // Inicializar controllers con los valores existentes
    _nameController = TextEditingController(text: widget.bicycle.bicycleName);
    _descriptionController =
        TextEditingController(text: widget.bicycle.bicycleDescription);
    _priceController =
        TextEditingController(text: widget.bicycle.bicyclePrice.toString());
    _sizeController = TextEditingController(text: widget.bicycle.bicycleSize);
    _modelController = TextEditingController(text: widget.bicycle.bicycleModel);
    _imageUrlController = TextEditingController(text: widget.bicycle.imageData);
    _pickUpLocationController = TextEditingController(text: widget.bicycle.pickUpLocation);
    _deliveryLocationController = TextEditingController(text: widget.bicycle.deliveryLocation);
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final token = await AuthService.getCurrentUserToken();
        final userId = await AuthService.getCurrentUserId();

        if (token == null || userId == null) {
          throw Exception('No authentication token found');
        }

        final bicycleService = BicycleService(
          accessToken: token,
          userId: userId.toString(),
        );

        final updateDto = BicycleUpdateDto(
          bicycleName: _nameController.text.trim(),
          bicycleDescription: _descriptionController.text.trim(),
          bicyclePrice: double.parse(_priceController.text.trim()),
          bicycleSize: _sizeController.text.trim(),
          bicycleModel: _modelController.text.trim(),
          imageData: _imageUrlController.text.trim().isEmpty
              ? null
              : _imageUrlController.text.trim(),
          pickUpLocation: _pickUpLocationController.text.trim(),
          deliveryLocation: _deliveryLocationController.text.trim(),
        );

        final updatedBicycle = await bicycleService.updateBicycle(
          widget.bicycle.id,
          updateDto,
        );

        _nameController.text = updatedBicycle.bicycleName;
        _descriptionController.text = updatedBicycle.bicycleDescription;
        _priceController.text = updatedBicycle.bicyclePrice.toString();
        _sizeController.text = updatedBicycle.bicycleSize;
        _modelController.text = updatedBicycle.bicycleModel;
        _imageUrlController.text = updatedBicycle.imageData ?? '';
        _pickUpLocationController.text = updatedBicycle.pickUpLocation;
        _deliveryLocationController.text = updatedBicycle.deliveryLocation;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('¡Bicicleta actualizada con éxito!')),
        );

        Navigator.pop(context, updatedBicycle);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            duration: Duration(seconds: 4),
          ),
        );
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Editar bicicleta',
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
                'Editar detalles de la bicicleta',
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
                validator: (value) =>
                value?.isEmpty ?? true ? 'Por favor ingresa el nombre de una bicicleta' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                'Descripcion',
                Icons.description,
                _descriptionController,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Por favor ingresa una descripción'
                    : null,
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
                validator: (value) =>
                value?.isEmpty ?? true ? 'Por favor introduce una talla' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                'Modelo',
                Icons.category,
                _modelController,
                validator: (value) =>
                value?.isEmpty ?? true ? 'Por favor introduce un modelo' : null,
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
                'URL de la imagen (opcional)',
                Icons.link,
                _imageUrlController,
              ),
              SizedBox(height: 16),
              if (_imageUrlController.text.isNotEmpty)
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
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Text('Error al cargar la imagen',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Guardar cambios', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF325D67),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(double.infinity, 50),
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
    super.dispose();
  }
}