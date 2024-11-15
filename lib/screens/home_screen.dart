import 'package:ecobicimobileapp/models/update_user_model.dart';
import 'package:ecobicimobileapp/screens/add_bicycle_screen.dart';
import 'package:ecobicimobileapp/screens/profile.dart';
import 'package:ecobicimobileapp/screens/rental_history.dart';
import 'package:ecobicimobileapp/screens/user_bicycles_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/widgets/bottomNavigationBar.dart';
import 'package:ecobicimobileapp/screens/screens.dart';

import '../services/auth_service.dart';
import '../services/user_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late String token;
  late int userId;
  int _selectedIndex = 0;
  String? userImageUrl;
  bool _isLoading = true;
  String? _error;
  late final UserService _userService;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // Fetch token and userId
      final fetchedToken = await AuthService.getCurrentUserToken();
      final fetchedUserId = await AuthService.getCurrentUserId();

      setState(() {
        token = fetchedToken ?? ''; // Handle null token if needed
        userId = fetchedUserId ?? 0;
        _userService = UserService();
      });

      // Load user data and get user image
      final userData = await UserService.getUserById(userId, token); // Supón que este método devuelve un objeto de usuario con `imageData`
      setState(() {
        userImageUrl = userData?.imageData; // Asigna la URL de la foto del usuario
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load user data';
        _isLoading = false;
      });
    }
  }


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
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.menu, color: Color(0xFF325D67), size: 30),
            color: Colors.white,
            onSelected: (item) => selectedItem(context, item),
            itemBuilder: (context) => [
              _buildMenuItem(0, 'Configuración'),
              _buildMenuItem(2, 'Mis bicicletas'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: userImageUrl != null && userImageUrl!.isNotEmpty
                  ? NetworkImage(userImageUrl!) // URL de la imagen
                  : null, // Si no hay URL, usa un ícono predeterminado
              child: userImageUrl == null || userImageUrl!.isEmpty
                  ? Icon(
                Icons.person_outline,
                color: Color(0xFF325D67),
              )
                  : null,
            ),
          ),
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