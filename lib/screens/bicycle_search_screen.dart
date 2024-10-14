import 'package:flutter/material.dart';

class BicycleSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true, // Esto agrega la flecha de regreso
        iconTheme: IconThemeData(color: Color(0xFF26348B)),
        title: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0), // Añadido padding lateral
          child: Text(
            'Drive in style',
            style: TextStyle(
              color: Color(0xFF26348B),
              fontWeight: FontWeight.bold,
              fontSize:
                  45, // Cambia este valor para ajustar el tamaño del texto
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra de búsqueda
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Color de fondo del input
                        borderRadius:
                            BorderRadius.circular(30), // Bordes redondeados
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF26348B)
                                .withOpacity(0.1), // Color de la sombra
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 4), // Posición de la sombra
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search:",
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
                    decoration: BoxDecoration(
                      color: Color(0xFF26348B), // Color de fondo (azul)
                      shape: BoxShape.circle, // Forma circular
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF26348B)
                                .withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 4), // Sombra debajo del botón
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.filter_list,
                          color: Colors.white), // Ícono de filtro blanco
                      onPressed: () {
                        // Acción del botón de filtro
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),

              // Título de marcas populares
              Text(
                "Popular Brands",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF26348B),
                ),
              ),
              SizedBox(height: 10),

              // Marcas populares
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBrandIcon("assets/audi_logo.png"),
                  _buildBrandIcon("assets/bmw_logo.png"),
                  _buildBrandIcon("assets/hyundai_logo.png"),
                  GestureDetector(
                    onTap: () {
                      // Acción de "View All"
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Color(0xFF26348B),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Presupuesto
              Text(
                "Budget",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF26348B),
                ),
              ),
              SizedBox(height: 10),

              // Filtros de presupuesto
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBudgetButton("S/ 30"),
                  _buildBudgetButton("S/ 70"),
                  _buildBudgetButton("S/ 100"),
                ],
              ),

              // Imagen de bicicleta (puedes ajustarlo a una imagen real o dejarlo así)
              SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/bicycle_image.png', // Asegúrate de tener esta imagen en tu carpeta assets
                  height: 200,
                ),
              ),
            ],
          ),
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
            color: Color(0xFF26348B).withOpacity(0.1), // Color de la sombra
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
            color: Color(0xFF26348B).withOpacity(0.1), // Color de la sombra
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
          side: BorderSide(color: Color(0xFF26348B)),
        ),
        child: Text(
          label,
          style: TextStyle(color: Color(0xFF26348B)),
        ),
      ),
    );
  }
}
