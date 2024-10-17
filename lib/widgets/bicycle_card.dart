import 'package:flutter/material.dart';

class BicycleCard extends StatelessWidget {
  final Map<String, dynamic> bicycle;
  final VoidCallback onTap;

  const BicycleCard({Key? key, required this.bicycle, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(bicycle['name']),
        subtitle: Text('${bicycle['type']} - \$${bicycle['pricePerHour']}/hour'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}