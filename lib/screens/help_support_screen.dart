import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpSupportScreen extends StatelessWidget {
  final String userName;
  final String userEmail;

  HelpSupportScreen({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Contáctanos',
          style: TextStyle(
            color: Color(0xFF325D67),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF325D67)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListTile(
          leading: Icon(Icons.person_outline, color: Color(0xFF325D67), size: 40),
          title: Text(
            userName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF325D67),
            ),
          ),
          subtitle: Text(
            userEmail,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          trailing: IconButton(
            icon: FaIcon(FontAwesomeIcons.whatsapp, color: Color(0xFF25D366), size: 30),
            onPressed: () {
              // Redirigir a la vista de WhatsApp
              // Aquí puedes implementar la lógica para abrir WhatsApp
            },
          ),
        ),
      ),
    );
  }
}
