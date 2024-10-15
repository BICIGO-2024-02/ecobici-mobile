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
    Text('Pantalla de Inicio'),
    BicycleSearchScreen(),
    Text('Pantalla de Alquiler'),
    Text('Pantalla de Perfil'),
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
          IconButton(
            icon: Icon(
              Icons.menu, 
              color:Color(0xFF26348B),
              size: 30,
              ),
            onPressed: () {
              // Acción del botón hamburguesa (desplegar menú o abrir un drawer)
            },
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
}