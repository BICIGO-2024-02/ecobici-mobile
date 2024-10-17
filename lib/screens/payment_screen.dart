import 'package:ecobicimobileapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/widgets/payment_method_selector.dart';

class PaymentScreen extends StatefulWidget {
  final int totalCost;
  final int rentalDays;

  PaymentScreen({required this.totalCost, required this.rentalDays});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = '';

  void updateSelectedPaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('Booking Confirmed', style: TextStyle(color: Color(0xFF325D67))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Audi A3 Sportsback 2.0l Turbo',
                style: TextStyle(
                  color: Color(0xFF325D67),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://www.brilliant.co/cdn/shop/products/L-Train-Grey-1-correct-angle.jpg?v=1499894699',
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text('Congratulations!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Go to Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF325D67),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        );
      },
    );
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
        title: Text('Payment', style: TextStyle(color: Color(0xFF325D67))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              SizedBox(height: 20),
              Text('Payment Methods', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF325D67))),
              SizedBox(height: 16),
              PaymentMethodSelector(
                selectedPaymentMethod: selectedPaymentMethod,
                onPaymentMethodSelected: updateSelectedPaymentMethod,
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
                    Text('Length: ${widget.rentalDays} day/s'),
                    Text('Total: £${widget.totalCost}', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF325D67))),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedPaymentMethod.isEmpty ? null : showConfirmationDialog,
                child: Text('Pay Now'),
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