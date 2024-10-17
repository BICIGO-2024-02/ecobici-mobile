import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/screens/payment_screen.dart';
import 'package:ecobicimobileapp/widgets/custom_calendar.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTimeRange? selectedDateRange;
  int totalCost = 0;
  final int pricePerDay = 175;

  void updateSelectedDateRange(DateTimeRange range) {
    setState(() {
      selectedDateRange = range;
      totalCost = range.duration.inDays * pricePerDay;
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
        title: Text('Booking', style: TextStyle(color: Color(0xFF325D67))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Drive in style',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF325D67)),
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
                      Text('You have chosen', style: TextStyle(fontSize: 18, color: Color(0xFF325D67))),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://www.brilliant.co/cdn/shop/products/L-Train-Grey-1-correct-angle.jpg?v=1499894699',
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Bike Model XYZ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('Manual', style: TextStyle(color: Colors.grey)),
                              Text('£175/day', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF325D67))),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Select dates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF325D67))),
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
                    Text('Length: ${selectedDateRange?.duration.inDays ?? 0} day/s'),
                    Text('Total: £$totalCost', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF325D67))),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PaymentScreen(totalCost: totalCost, rentalDays: selectedDateRange?.duration.inDays ?? 0)),
                  );
                },
                child: Text('Confirm'),
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