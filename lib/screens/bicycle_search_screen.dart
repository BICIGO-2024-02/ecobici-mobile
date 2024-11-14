import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/widgets/bottomFilterSheet.dart';

class BicycleSearchScreen extends StatelessWidget {
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
                SizedBox(width: 10),
                Container(
                  margin: EdgeInsets.only(
                      right:
                          40), // Usamos margin en lugar de padding para las sombras
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF325D67), // Color de fondo (azul)
                    shape: BoxShape.rectangle, // Cambiar a rectángulo
                    borderRadius:
                        BorderRadius.circular(30), // Bordes redondeados
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF325D67).withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 4), // Sombra debajo del botón
                      ),
                    ],
                  ),
                  child: IconButton(
                    iconSize: 24, // Tamaño del ícono
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(Colors.white,
                          BlendMode.srcIn), // Convierte el ícono en blanco
                      child: Image.asset(
                        'assets/icons/filtrar.png', // Ruta de la imagen del ícono
                        width: 24, // Ajusta el tamaño del ícono
                        height: 24,
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                  20)), // Bordes redondeados en la parte superior
                        ),
                        builder: (BuildContext context) {
                          return FilterBottomSheet(); // Muestra el widget con los filtros
                        },
                      );
                    },
                  ),
                )
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

            // Filtros de presupuesto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40), // Mantén el padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBudgetButton("S/ 30"),
                  _buildBudgetButton("S/ 70"),
                  _buildBudgetButton("S/ 100"),
                ],
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

  // Función para construir los botones de presupuesto
  Widget _buildBudgetButton(String label) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF325D67).withOpacity(0.1), 
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 4), // Posición de la sombra
          ),
        ],
      ),
      child: OutlinedButton(
        onPressed: () {
          // Acción cuando se selecciona un presupuesto
        },
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          side: BorderSide(color: Color(0xFF325D67)),
        ),
        child: Text(
          label,
          style: TextStyle(color: Color(0xFF325D67)),
        ),
      ),
    );
  }
}
