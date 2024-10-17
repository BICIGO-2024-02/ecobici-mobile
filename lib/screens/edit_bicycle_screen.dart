import 'package:flutter/material.dart';

class EditBikeScreen extends StatefulWidget {
  final Map<String, dynamic> bike;

  EditBikeScreen({required this.bike});

  @override
  _EditBikeScreenState createState() => _EditBikeScreenState();
}

class _EditBikeScreenState extends State<EditBikeScreen> {
  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _priceController;
  late TextEditingController _technicalInfoController;
  late String _status;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.bike['name']);
    _typeController = TextEditingController(text: widget.bike['type']);
    _priceController =
        TextEditingController(text: widget.bike['pricePerHour'].toString());
    _technicalInfoController =
        TextEditingController(text: widget.bike['technicalInfo']);
    _status = widget.bike['status'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _priceController.dispose();
    _technicalInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Bike', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(_nameController, 'Bike Name'),
            SizedBox(height: 16),
            _buildTextField(_typeController, 'Bike Type'),
            SizedBox(height: 16),
            _buildTextField(_priceController, 'Price per Hour',
                keyboardType: TextInputType.number),
            SizedBox(height: 16),
            _buildDropdown(),
            SizedBox(height: 16),
            _buildTextField(_technicalInfoController, 'Technical Information',
                maxLines: 3),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('Save Changes'),
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF325D67),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1, TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: _status,
        decoration: InputDecoration(
          labelText: 'Status',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        items: ['Available', 'Rented', 'Maintenance'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _status = newValue;
            });
          }
        },
      ),
    );
  }

  void _saveChanges() {
    final updatedBike = {
      ...widget.bike,
      'name': _nameController.text,
      'type': _typeController.text,
      'pricePerHour':
          double.tryParse(_priceController.text) ?? widget.bike['pricePerHour'],
      'status': _status,
      'technicalInfo': _technicalInfoController.text,
    };

    print('Updated Bike: $updatedBike');
    Navigator.of(context).pop(updatedBike);
  }
}
