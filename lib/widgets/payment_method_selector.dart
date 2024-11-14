import 'package:flutter/material.dart';

class PaymentMethodSelector extends StatelessWidget {
  final String selectedPaymentMethod;
  final Function(String) onPaymentMethodSelected;

  PaymentMethodSelector({
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final paymentMethods = [
      {'icon': Icons.add, 'label': 'Add a new card'},
      {'icon': Icons.credit_card, 'label': 'John Doe **** **** **** 1234'},
      {'icon': Icons.apple, 'label': 'Apple Pay'},
      {'icon': Icons.money, 'label': 'Cash'},
    ];

    return Column(
      children: paymentMethods.map((method) {
        return ListTile(
          leading: Icon(method['icon'] as IconData),
          title: Text(method['label'] as String),
          selected: selectedPaymentMethod == method['label'],
          onTap: () {
            onPaymentMethodSelected(method['label'] as String);
          },
        );
      }).toList(),
    );
  }
}
