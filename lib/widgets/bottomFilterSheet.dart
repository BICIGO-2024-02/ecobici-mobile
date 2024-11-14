import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/screens/screens.dart';
import 'package:ecobicimobileapp/screens/results_screen.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // Definimos los valores iniciales del rango del slider
  double _minValue = 200;
  double _maxValue = 500;

    // Lista para almacenar las marcas seleccionadas
  List<String> selectedBrands = [];


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *
          1, // Ajusta la altura del BottomSheet
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 4), // sombra en la parte inferior del BottomSheet
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, left: 40, right: 40), // Margin para crear espacio en los laterales
              child: Text(
                'Rango de precios',
                style: TextStyle(
                  color: Color(0xFF325D67),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Slider personalizado
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'S/ ${_minValue.toInt()}',
                    style: TextStyle(
                      color: Color(0xFF325D67),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Expanded(
                    child: RangeSlider(
                      min: 0,
                      max: 500,
                      divisions: 20, // Divisiones del slider
                      values: RangeValues(_minValue, _maxValue),
                      activeColor: Color(0xFF325D67), // Color del slider cuando está activo
                      inactiveColor: Colors.grey, // Color del slider cuando está inactivo
                      onChanged: (RangeValues values) {
                        setState(() {
                          _minValue = values.start;
                          _maxValue = values.end;
                        });
                      },
                    ),
                  ),
                  Text(
                    'S/ ${_maxValue.toInt()}',
                    style: TextStyle(
                      color: Color(0xFF325D67),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            // Filtros de marcas
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40), // Aplicamos margin en lugar de padding
              child: Text(
                "Marcas",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF325D67),
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40), // Aplicamos margin a las marcas
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBrandIcon("assets/giant_logo.png", "Giant"),
                  _buildBrandIcon("assets/trek_logo.png", "Trek"),
                  _buildBrandIcon("assets/specialized_logo.png", "Specialized"),
                  _buildBrandIcon("assets/cannondale_logo.png", "Cannondale"),
                ],
              ),
            ),
            SizedBox(height: 40),

            // Filtros de tipo de coche
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40), // Aplicamos margin en lugar de padding
              child: Text(
                "Tipo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF325D67),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40), // Aplicamos margin a las opciones de filtro
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterOption("Montaña", true),
                  _buildFilterOption("Camino", false),
                  _buildFilterOption("Eléctrica", false),
                ],
              ),
            ),
            SizedBox(height: 40),

            // Filtros de transmisión
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40), // Aplicamos margin en lugar de padding
              child: Text(
                "Caja de cambios",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF325D67),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40), // Aplicamos margin a las opciones de filtro
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterOption("Aluminio", true),
                  _buildFilterOption("Carbon", false),
                  _buildFilterOption("Acero", false),
                ],
              ),
            ),
            SizedBox(height: 40),

            // Botón de aplicar filtros
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40), // Margin en el botón para espacio
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsScreen(), // Lleva a la pantalla de resultados
                    ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF325D67), // Color azul
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40), // Bordes redondeados
                    ),
                    shadowColor: Colors.black.withOpacity(0.2), // Sombra para el botón
                    elevation: 10, // Añadir elevación para mostrar la sombra
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    child: Text("Aplicar", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Método para construir los botones de presupuesto
  Widget _buildPriceRangeButton(String label) {
    return OutlinedButton(
      onPressed: () {
        // Acción al seleccionar presupuesto
      },
      child: Text(label),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(color: Color(0xFF325D67)),
      ),
    );
  }

  // Método para construir los íconos de las marcas con sombra
  Widget _buildBrandIcon(String assetPath, String brandName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedBrands.contains(brandName)) {
            selectedBrands.remove(brandName);
          } else {
            selectedBrands.add(brandName);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(assetPath),
          backgroundColor:
              selectedBrands.contains(brandName) ? Color(0xFF325D67) : null,
        ),
      ),
    );
  }

  // Método para construir los filtros de tipo de bicicleta y material del marco con sombra
  Widget _buildFilterOption(String label, bool selected) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Color(0xFF325D67) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF325D67)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Color(0xFF325D67),
        ),
      ),
    );
  }
}
