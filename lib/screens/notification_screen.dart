import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/rent_model.dart';

class NotificationScreen extends StatefulWidget {
  final int userId;
  final String accessToken;

  NotificationScreen({required this.userId, required this.accessToken});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<RentModel>> rentalsFuture;
  final Color primaryColor = Color(0xFF325D67);

  @override
  void initState() {
    super.initState();
    rentalsFuture = getUserRentals(widget.userId);
  }

  Future<List<RentModel>> getUserRentals(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('https://bicigo-a5evdzeubdgveuau.eastus2-01.azurewebsites.net/api/ecobici/v1/rents/user/$userId'),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<RentModel> rentals = data.map((rental) => RentModel.fromJson(rental)).toList();
        return rentals;
      } else {
        throw Exception('Failed to load rentals');
      }
    } catch (e) {
      throw Exception('Error fetching rentals: $e');
    }
  }

  void deleteNotification(int index, List<RentModel> rentals) {
    setState(() {
      rentals.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notificación eliminada'),
        backgroundColor: primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  int calculateDaysLeft(String rentEndDate) {
    final endDate = DateTime.parse(rentEndDate);
    final currentDate = DateTime.now();
    final difference = endDate.difference(currentDate).inDays;
    return difference;
  }

  Color getStatusColor(int daysLeft) {
    if (daysLeft < 0) return Colors.red;
    if (daysLeft <= 3) return Colors.orange;
    return primaryColor;
  }

  int calculateDaysUntilStart(String rentStartDate) {
    final startDate = DateTime.parse(rentStartDate);
    final currentDate = DateTime.now();
    final difference = startDate.difference(currentDate).inDays;
    return difference;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notificaciones',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<RentModel>>(
        future: rentalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Error al cargar las notificaciones',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_outlined, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No tienes notificaciones',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final rental = snapshot.data![index];
                final daysUntilStart = calculateDaysUntilStart(rental.rentStartDate);
                final daysLeft = calculateDaysLeft(rental.rentEndDate);

                String statusMessage;
                if (daysUntilStart > 0) {
                  statusMessage = 'Faltan $daysUntilStart días para que empiece tu renta';
                } else if (daysUntilStart == 0) {
                  statusMessage = 'Hoy empieza tu renta';
                } else if (daysLeft > 0) {
                  statusMessage = 'Quedan $daysLeft días para finalizar la renta';
                } else {
                  statusMessage = 'La renta ha finalizado';
                }

                return Card(
                  elevation: 4,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: getStatusColor(daysLeft),
                          width: 4,
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: primaryColor.withOpacity(0.1),
                        child: Icon(
                          Icons.pedal_bike,
                          color: primaryColor,
                        ),
                      ),
                      title: Text(
                        rental.bicycle.bicycleName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            statusMessage,
                            style: TextStyle(
                              color: getStatusColor(daysLeft),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Fecha fin: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(rental.rentEndDate))}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => deleteNotification(index, snapshot.data!),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}