import 'package:ecobicimobileapp/models/rent_request_model.dart';
import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/screens/payment_screen.dart';
import 'package:ecobicimobileapp/widgets/custom_calendar.dart';
import 'package:ecobicimobileapp/services/rent_service.dart';
import 'package:ecobicimobileapp/services/auth_service.dart';
import 'package:ecobicimobileapp/models/bicycle_model.dart';
import 'package:ecobicimobileapp/models/rent_model.dart';

class BookingScreen extends StatefulWidget {
  final BicycleModel bicycle;

  const BookingScreen({Key? key, required this.bicycle}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTimeRange? selectedDateRange;
  double totalCost = 0.0;
  bool isLoading = false;
  List<DateTimeRange> bookedDates = [];

  @override
  void initState() {
    super.initState();
    _fetchBookedDates();
  }

  void _fetchBookedDates() async {
    final token = await AuthService.getCurrentUserToken();

    if (token == null) {
      throw Exception('Se requiere autenticación');
    }

    final rentService = RentService(accessToken: token);
    final rents = await rentService.getBicycleRentals(widget.bicycle.id); // Llamar al método de instancia
    setState(() {
      bookedDates = rents.map((rent) {
        return DateTimeRange(
          start: DateTime.parse(rent.rentStartDate),
          end: DateTime.parse(rent.rentEndDate),
        );
      }).toList();
    });
  }


  void updateSelectedDateRange(DateTimeRange range) {
    setState(() {
      selectedDateRange = range;
      totalCost = range.duration.inDays * widget.bicycle.bicyclePrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF325D67)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Reserva', style: TextStyle(color: Color(0xFF325D67))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Conduce con estilo',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF325D67)),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tu has elegido',
                          style: TextStyle(
                              fontSize: 18, color: Color(0xFF325D67))),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 80,
                              width: 80,
                              color: Colors.grey[200],
                              child: Icon(Icons.directions_bike, size: 50),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.bicycle.bicycleName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.bicycle.bicycleModel,
                                    style: TextStyle(color: Colors.grey)),
                                Text('S/ ${widget.bicycle.bicyclePrice}/day',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF325D67))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Seleccionar fechas',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF325D67))),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CustomCalendar(
                  onDateRangeSelected: updateSelectedDateRange,
                  disabledDates: bookedDates,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Duración: ${selectedDateRange?.duration.inDays ?? 0} día/s'),
                    Text('Total: S/ $totalCost',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF325D67))),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (selectedDateRange == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor seleccione las fechas primero')),
                    );
                    return;
                  }

                  // Formatear las fechas al formato requerido "YYYY-MM-DD"
                  String startDate =
                      "${selectedDateRange!.start.year}-${selectedDateRange!.start.month.toString().padLeft(2, '0')}-${selectedDateRange!.start.day.toString().padLeft(2, '0')}";
                  String endDate =
                      "${selectedDateRange!.end.year}-${selectedDateRange!.end.month.toString().padLeft(2, '0')}-${selectedDateRange!.end.day.toString().padLeft(2, '0')}";

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        totalCost: totalCost,
                        rentalDays: selectedDateRange?.duration.inDays ?? 0,
                        bicycle: widget.bicycle,
                        startDate: startDate,
                        endDate: endDate,
                      ),
                    ),
                  );
                },
                child: Text('Confirmar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF325D67),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}