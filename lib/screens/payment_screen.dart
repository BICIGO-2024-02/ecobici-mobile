import 'dart:convert';
import 'package:ecobicimobileapp/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:ecobicimobileapp/constants/keys.dart';
import '../models/bicycle_model.dart';
import '../models/rent_request_model.dart';
import '../services/auth_service.dart';
import '../services/rent_service.dart';

class PaymentScreen extends StatefulWidget {
  final double totalCost;
  final int rentalDays;
  final BicycleModel bicycle;
  final String startDate;
  final String endDate;

  PaymentScreen({
    required this.totalCost,
    required this.rentalDays,
    required this.bicycle,
    required this.startDate,
    required this.endDate,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? intentPaymentData;

  Future<void> createRentAfterPayment() async {
    try {
      final token = await AuthService.getCurrentUserToken();

      if (token == null) {
        throw Exception('Se requiere autenticación');
      }

      if (widget.bicycle.id == null) {
        throw Exception('ID de bicicleta no válido');
      }

      final userId = await AuthService.getCurrentUserId();
      print('UserId obtenido: $userId');

      if (userId == null || userId == 0) {
        throw Exception('ID de usuario no válido');
      }

      print('BicycleId: ${widget.bicycle.id}');
      print('StartDate: ${widget.startDate}');
      print('EndDate: ${widget.endDate}');
      print('TotalCost: ${widget.totalCost}');

      final rentService = RentService(accessToken: token);

      final rentRequest = RentRequestModel(
        rentStartDate: widget.startDate,
        rentEndDate: widget.endDate,
        rentPrice: widget.totalCost,
        bicycleId: widget.bicycle.id,
        userId: userId,
      );

      print('Datos de la solicitud de renta:');
      print(rentRequest.toJson());

      try {
        await rentService.createRent(rentRequest);
        if (mounted) {
          showConfirmationDialog();
        }
      } catch (e) {
        print('Error específico al crear la renta: $e');
        if (mounted) {
          showConfirmationDialog();
        }
      }

    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error creating rent: $e');
        print('Stack trace: $stackTrace');
      }
      if (mounted) {
        showDialog(
            context: context,
            builder: (c) => AlertDialog(
              title: Text('Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text('Error al crear la reserva:'),
                    Text(e.toString()),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            )
        );
      }
    }
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Color(0xFF325D67),
                size: 50,
              ),
              SizedBox(height: 10),
              Text(
                'Reserva confirmada',
                style: TextStyle(
                  color: Color(0xFF325D67),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.bicycle.bicycleName,
                style: TextStyle(
                  color: Color(0xFF325D67),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.bicycle.imageData ?? 'https://www.brilliant.co/cdn/shop/products/L-Train-Grey-1-correct-angle.jpg?v=1499894699',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150,
                        width: 150,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.directions_bike,
                          size: 50,
                          color: Color(0xFF325D67),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Duración:'),
                        Text(
                          '${widget.rentalDays} día(s)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total:'),
                        Text(
                          'S/.${widget.totalCost}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF325D67),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'Ir al inicio',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF325D67),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'Ver detalles',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceEvenly,
        );
      },
    );
  }

  Future<void> showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        intentPaymentData = null;
        createRentAfterPayment();
      }).onError((error, stackTrace) {
        if(kDebugMode) {
          print('$error\n$stackTrace');
        }
      });
    } on StripeException catch(error) {
      if (kDebugMode) {
        print(error);
      }
      if (mounted) {
        showDialog(
            context: context,
            builder: (c) => const AlertDialog(
              content: Text("Pago cancelado"),
            )
        );
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<Map<String, dynamic>?> makeIntentForPayment(String amount, String currency) async {
    try {
      Map<String, dynamic> paymentInfo = {
        "amount": (int.parse(amount)*100).toString(),
        "currency": currency,
        "payment_method_types[]": "card",
      };

      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: paymentInfo,
          headers: {
            "Authorization": "Bearer $SecretKey",
            "Content-Type": "application/x-www-form-urlencoded"
          }
      );

      print("response from API = ${response.body}");
      return jsonDecode(response.body);
    } catch(error) {
      if(kDebugMode) {
        print(error);
      }
      return null;
    }
  }

  Future<void> paymentSheetInitialization(String amount, String currency) async {
    try {
      intentPaymentData = await makeIntentForPayment(amount, currency);

      if (intentPaymentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                allowsDelayedPaymentMethods: true,
                paymentIntentClientSecret: intentPaymentData!["client_secret"],
                style: ThemeMode.dark,
                merchantDisplayName: "EcoBici"
            )
        );
        showPaymentSheet();
      }
    } catch(error, stackTrace) {
      if (kDebugMode) {
        print('$error\n$stackTrace');
      }
    }
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
        title: Text('Pago', style: TextStyle(color: Color(0xFF325D67))),
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
                    Text('Tu has elegido',
                        style: TextStyle(fontSize: 18, color: Color(0xFF325D67))),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.bicycle.imageData ??
                                'https://www.brilliant.co/cdn/shop/products/L-Train-Grey-1-correct-angle.jpg?v=1499894699',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 80,
                                width: 80,
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.directions_bike,
                                  size: 40,
                                  color: Color(0xFF325D67),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.bicycle.bicycleName,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                widget.bicycle.bicycleDescription,
                                style: TextStyle(color: Colors.grey),
                                softWrap: true,
                              ),
                              Text(
                                'S/.${widget.bicycle.bicyclePrice}/día',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF325D67)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Duración:'),
                        Text(
                          '${widget.rentalDays} día/s',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total:'),
                        Text(
                          'S/.${widget.totalCost}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF325D67),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        paymentSheetInitialization(
                            widget.totalCost.round().toString(), "USD");
                      },
                      child: Text('Pagar ahora S/. ${widget.totalCost}'),
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
            ],
          ),
        ),
      ),
    );
  }
}