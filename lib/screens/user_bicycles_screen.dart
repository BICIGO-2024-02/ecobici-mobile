import 'package:ecobicimobileapp/screens/edit_bicycle_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/screens/add_bicycle_screen.dart';

class MyListedBikesScreen extends StatefulWidget {
  @override
  _MyListedBikesScreenState createState() => _MyListedBikesScreenState();
}

class _MyListedBikesScreenState extends State<MyListedBikesScreen> {
  final List<Map<String, dynamic>> listedBikes = [
    {
      'id': '1',
      'name': 'Mountain Explorer',
      'type': 'Mountain Bike',
      'pricePerHour': 15,
      'status': 'Available',
      'rating': 4.8,
      'totalRents': 12,
      'earnings': 'S/ 450.00',
      'isExpanded': false,
      'technicalInfo': 'Frame: Aluminum, Gears: 21-speed, Weight: 13.5 kg',
    },
    {
      'id': '2',
      'name': 'City Cruiser Pro',
      'type': 'City Bike',
      'pricePerHour': 12,
      'status': 'Rented',
      'rating': 4.5,
      'totalRents': 8,
      'earnings': 'S/ 320.00',
      'isExpanded': false,
      'technicalInfo': 'Frame: Steel, Gears: 7-speed, Weight: 14.2 kg',
    },
    {
      'id': '3',
      'name': 'Road Master Elite',
      'type': 'Road Bike',
      'pricePerHour': 18,
      'status': 'Maintenance',
      'rating': 4.9,
      'totalRents': 15,
      'earnings': 'S/ 580.00',
      'isExpanded': false,
      'technicalInfo': 'Frame: Carbon Fiber, Gears: 22-speed, Weight: 8.1 kg',
    },
  ];

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
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.sort, color: Color(0xFF325D67)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Card
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF325D67), Color(0xFF3E707C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF325D67).withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Earnings',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'This Month',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'S/ 1,350.00',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '+12.5%',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quick Stats
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickStat(
                    'Active Bikes',
                    '2',
                    Icons.pedal_bike,
                    Color(0xFF325D67),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildQuickStat(
                    'Total Rentals',
                    '35',
                    Icons.assignment_turned_in,
                    Color(0xFF325D67),
                  ),
                ),
              ],
            ),
          ),

          // Bikes List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: listedBikes.length,
              itemBuilder: (context, index) {
                final bike = listedBikes[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      bike['isExpanded'] = !bike['isExpanded'];
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE6E1F4),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.pedal_bike,
                                      color: Color(0xFF325D67),
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bike['name'],
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF325D67),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          bike['type'],
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _buildStatusBadge(bike['status']),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Price per hour',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        'S/ ${bike['pricePerHour']}.00',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF325D67),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.amber,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '${bike['rating']}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF325D67),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${bike['totalRents']} rentals',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (bike['isExpanded'])
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16),
                                    Text(
                                      'Technical Information:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF325D67),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      bike['technicalInfo'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildActionButton(
                                          icon: Icons.edit,
                                          label: 'Edit',
                                          onPressed: () {
                                            // Implement edit functionality
                                          },
                                        ),
                                        _buildActionButton(
                                          icon: Icons.block,
                                          label: 'Disable',
                                          onPressed: () {
                                            // Implement disable functionality
                                          },
                                        ),
                                        _buildActionButton(
                                          icon: Icons.delete,
                                          label: 'Delete',
                                          onPressed: () {
                                            // Implement delete functionality
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddBikeScreen()),
        ),
        backgroundColor: Color(0xFF325D67),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildQuickStat(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'available':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        break;
      case 'rented':
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        break;
      default:
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 18),
      label: Text(label),
      onPressed: () async {
        final updatedBike = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditBikeScreen(bike: listedBikes[0]),
          ),
        );
        if (updatedBike != null) {
          setState(() {
            // Actualizar la bicicleta en la lista
            final index =
                listedBikes.indexWhere((b) => b['id'] == updatedBike['id']);
            if (index != -1) {
              listedBikes[index] = updatedBike;
            }
          });
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF325D67),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
