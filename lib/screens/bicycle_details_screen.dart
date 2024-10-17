import 'package:flutter/material.dart';
import 'edit_bicycle_screen.dart';

class BicycleDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> bicycle;

  const BicycleDetailsScreen({Key? key, required this.bicycle}) : super(key: key);

  @override
  _BicycleDetailsScreenState createState() => _BicycleDetailsScreenState();
}

class _BicycleDetailsScreenState extends State<BicycleDetailsScreen> {
  late Map<String, dynamic> _bicycle;

  @override
  void initState() {
    super.initState();
    _bicycle = Map.from(widget.bicycle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_bicycle['name']),
        backgroundColor: Color(0xFF325D67),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${_bicycle['type']}'),
            Text('Price per hour: \$${_bicycle['pricePerHour']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditBicycleScreen(bicycle: _bicycle),
                  ),
                );
                if (result != null) {
                  setState(() {
                    _bicycle = result;
                  });
                }
              },
              child: Text('Edit'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement disable functionality
              },
              child: Text('Disable'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement delete functionality
              },
              child: Text('Delete'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}