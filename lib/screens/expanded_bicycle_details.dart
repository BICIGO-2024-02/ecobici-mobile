import 'package:flutter/material.dart';

class ExpandedBikeDetailsScreen extends StatefulWidget {
  @override
  _ExpandedBikeDetailsScreenState createState() => _ExpandedBikeDetailsScreenState();
}

class _ExpandedBikeDetailsScreenState extends State<ExpandedBikeDetailsScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Listed Bikes',
          style: TextStyle(
            color: Color(0xFF325D67),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        )
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildEarningsCard(),
          SizedBox(height: 16),
          _buildStatsRow(),
          SizedBox(height: 16),
          _buildExpandableBikeCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF2D4059),
      ),
    );
  }

  Widget _buildEarningsCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF325D67),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Earnings', style: TextStyle(color: Colors.white)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('This Month', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('S/ 500.00', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text('+12.5%', style: TextStyle(color: Colors.greenAccent)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Active since', '10/08/2024', Icons.pedal_bike)),
        SizedBox(width: 16),
        Expanded(child: _buildStatCard('Total Rentals', '10', Icons.checklist)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF2D4059)),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(title, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableBikeCard() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8EAED),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.pedal_bike, color: Color(0xFF2D4059)),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mountain Explorer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Mountain Bike', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('Available', style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
            ),
            if (isExpanded) ...[
              Divider(),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ficha Técnica', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('• Marca: Trek'),
                    Text('• Modelo: X-Caliber 8'),
                    Text('• Año: 2023'),
                    Text('• Talla: M'),
                    SizedBox(height: 16),
                    Text('Estadísticas de Renta', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Cantidad de rentas: 12'),
                    Text('Calificación promedio: 4.8'),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton('Editar', Icons.edit, Colors.blue),
                        _buildActionButton('Deshabilitar', Icons.block, Colors.orange),
                        _buildActionButton('Eliminar', Icons.delete, Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}