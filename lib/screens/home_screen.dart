import 'package:ecobicimobileapp/screens/add_bicycle_screen.dart';
import 'package:ecobicimobileapp/screens/profile.dart';
import 'package:ecobicimobileapp/screens/rental_history.dart';
import 'package:ecobicimobileapp/screens/user_bicycles_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/widgets/bottomNavigationBar.dart';
import 'package:ecobicimobileapp/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  // Estado para controlar el índice de la pantalla activa
  int _selectedIndex = 0;

  // Lista de pantallas que se mostrarán según el índice
  static List<Widget> _widgetOptions = <Widget>[
    BicycleSearchScreen(),
    ResultsScreen(),
    RentalHistoryScreen(),
    UserProfileScreen(),
  ];

  // Cuando se selecciona un ítem en la barra de navegación
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cambia el índice seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Barra superior con la foto del usuario y el botón hamburguesa a la derecha
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Esto oculta el ícono de 'back' si no es necesario
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.menu, color: Color(0xFF325D67), size: 30),
            color: Colors.white, // Fondo blanco para el menú
            onSelected: (item) => selectedItem(context, item),
            itemBuilder: (context) => [
              _buildMenuItem(0, 'Account Settings'),
              _buildMenuItem(1, 'Payment Details'),
              _buildMenuItem(2, 'My bikes'),
              _buildMenuItem(3, 'Orders'),
              _buildMenuItem(4, 'Display'),
            ],
          ),
          // Icono de la foto del usuario
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/150', // Aquí puedes poner la URL de la foto del usuario
              ),
            ),
          ),
          // Botón tipo hamburguesa
          
        ],
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex), 
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        icons: [
          Icons.home,
          Icons.directions_bike,
          Icons.shopping_cart,
          Icons.person
        ],
        selectedIndex: _selectedIndex, // Índice seleccionado
        onItemTapped: _onItemTapped, // Función para cambiar de pantalla
      ),
    );
  }
  // Función para construir los items del menú
  PopupMenuItem<int> _buildMenuItem(int value, String text) {
    return PopupMenuItem<int>(
      value: value,
      child: Text(
        text,
        style: TextStyle(color: Colors.black), // Texto negro
      ),
    );
  }
  // Función para construir un divisor entre los items del menú
  PopupMenuItem<int> _buildDivider() {
    return PopupMenuItem<int>(
      enabled: false, // El divider no es seleccionable
      child: Divider(
        color: Colors.grey, // Color de la línea divisoria
        thickness: 1, // Grosor de la línea divisoria
      ),
    );
  }
  void selectedItem(BuildContext context, int item) {
    switch (item) {
      case 0:
        print("Account Settings selected");
        // Aquí puedes redirigir a la pantalla de configuración de cuenta
        break;
      case 1:
        print("Payment Details selected");
        // Aquí puedes redirigir a la pantalla de detalles de pago
        break;
      case 2:
        print("My bikes selected");
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MyListedBikesScreen()),
        );
        break;
      case 3:
        print("Orders selected");
        // Aquí puedes redirigir a la pantalla de pedidos
        break;
      case 4:
        print("Display selected");
        // Aquí puedes redirigir a la pantalla de configuración de pantalla
        break;
    }
  }
}