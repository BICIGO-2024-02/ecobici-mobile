import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final List<IconData> icons;
  final Function(int) onItemTapped; // Añadimos un callback para manejar los taps
  final int selectedIndex; // Índice seleccionado actual

  const CustomBottomNavigationBar({
    Key? key,
    required this.icons,
    required this.onItemTapped,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60, // Ajusta la altura del BottomNavigationBar
        padding: EdgeInsets.symmetric(horizontal: 30), // Ajusta el padding para que no sea demasiado alto
        margin: EdgeInsets.only(bottom: 10, left: 30, right: 30), 
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            icons.length,
            (index) => GestureDetector(
              onTap: () {
                onItemTapped(index); // Llamamos al callback cuando se toque el ícono
              },
              child: Icon(
                icons[index],
                size: 28, // Ajusta el tamaño del ícono
                color: index == selectedIndex
                    ? Color(0xFF26348B)
                    : Colors.black54, // Cambia el color del ícono cuando está seleccionado
              ),
            ),
          ),
        ),
      ),
    );
  }
}