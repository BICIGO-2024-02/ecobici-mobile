import 'package:ecobicimobileapp/screens/results_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/widgets/bottomFilterSheet.dart';

class BicycleSearchScreen extends StatefulWidget {
  @override
  _BicycleSearchScreenState createState() => _BicycleSearchScreenState();
}

class _BicycleSearchScreenState extends State<BicycleSearchScreen> {
  double _selectedBudget = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Esto agrega la flecha de regreso
        iconTheme: IconThemeData(color: Color(0xFF325D67)),
        title: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0), // Añadido padding lateral
          child: Text(
            'Conduce con estilo',
            style: TextStyle(
              color: Color(0xFF325D67),
              fontWeight: FontWeight.bold,
              fontSize:
                  45, // Cambia este valor para ajustar el tamaño del texto
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de búqueda
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left:
                            40), // Usamos margin en lugar de padding para las sombras
                    decoration: BoxDecoration(
                      color: Colors.white, // Color de fondo del input
                      borderRadius:
                          BorderRadius.circular(30), // Bordes redondeados
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF325D67)
                              .withOpacity(0.1), // Color de la sombra
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 4), // Posición de la sombra
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Buscar:",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none, // Sin borde exterior
                        ),
                        fillColor: Colors.white, // Fondo del input
                        filled: true, // Llenar el color de fondo
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40),
              ],
            ),
            SizedBox(height: 30),

            // Título de marcas populares
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 40), // Mantén el padding para el texto
              child: Text(
                "Marcas populares",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF325D67),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Marcas populares
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40), // Mantén el padding para el contenido
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBrandIcon("https://cdn.worldvectorlogo.com/logos/monark.svg"),
                  _buildBrandIcon("https://cdn.worldvectorlogo.com/logos/monark.svg"),
                  _buildBrandIcon("https://cdn.worldvectorlogo.com/logos/monark.svg"),
                  GestureDetector(
                    onTap: () {
                      // Acción de "View All"
                    },
                    child: Text(
                      "Ver todo",
                      style: TextStyle(
                        color: Color(0xFF325D67),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Presupuesto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40), // Mantén el padding
              child: Text(
                "Presupuesto",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF325D67),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBudgetButton("S/ 30", 30),
                  _buildBudgetButton("S/ 60", 60),
                  _buildBudgetButton("S/ 100", 100),
                ],
              ),
            ),

            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsScreen(budget: _selectedBudget),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF325D67),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Buscar', style: TextStyle(fontSize: 18)),
              ),

            ),

            // Imagen de bicicleta (puedes ajustarlo a una imagen real o dejarlo así)
            SizedBox(
              height: 100,
            ),
            Center(
              child: Opacity(
                opacity:
                    0.2, // Controla el nivel de opacidad (0.0 completamente transparente, 1.0 completamente opaco)
                child: Image.asset(
                  'assets/images/bg_bici.jpg',
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para construir los íconos de las marcas
  Widget _buildBrandIcon(String assetPath) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF325D67).withOpacity(0.1), // Color de la sombra
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 4), // Posición de la sombra
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(assetPath),
      ),
    );
  }

  Widget _buildBudgetButton(String label, double budget) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedBudget = budget;
        });
        _filterBicyclesByBudget(_selectedBudget);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: _selectedBudget == budget
            ? Colors.white
            : Color(0xFF325D67),
        backgroundColor: _selectedBudget == budget
            ? Color(0xFF325D67)
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: _selectedBudget == budget
                ? Color(0xFF325D67)
                : Color(0xFF325D67).withOpacity(0.5),
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _filterBicyclesByBudget(double budget) {
    print('Filtrar bicicletas por presupuesto: S/ $budget');
  }
}
