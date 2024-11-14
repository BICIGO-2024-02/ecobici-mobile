import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/widgets/bottomBikeDetailSheet.dart';
import 'package:ecobicimobileapp/services/bicycle_service.dart';
import 'package:ecobicimobileapp/services/auth_service.dart';
import 'package:ecobicimobileapp/models/bicycle_model.dart';

class ResultsScreen extends StatelessWidget {
  final AuthService _authService = AuthService();
  // Removemos el late y hacemos nullable el _bicycleService
  BicycleService? _bicycleService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Resultados',
          style: TextStyle(
            color: Color(0xFF325D67),
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<BicycleModel>>(
              future: _getBicycles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final bicycles = snapshot.data ?? [];

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${bicycles.length} Resultados',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: bicycles.length,
                          itemBuilder: (context, index) {
                            final bicycle = bicycles[index];
                            return _buildResultCard(
                              context,
                              bicycle: bicycle,
                            );
                          },
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Limpiamos el servicio antes de recargar
                            _bicycleService = null;
                            (context as Element).markNeedsBuild();
                          },
                          child: Text(
                            'Recargar',
                            style: TextStyle(
                              color: Color(0xFF325D67),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<BicycleModel>> _getBicycles() async {
    // Si ya existe el servicio, lo usamos directamente
    if (_bicycleService != null) {
      return _bicycleService!.getAllBicycles();
    }

    // Si no existe, lo inicializamos
    final token = await AuthService.getCurrentUserToken();
    final userId = await AuthService.getCurrentUserId();

    if (token == null || userId == null) {
      throw Exception('No se encontró token o userId');
    }

    _bicycleService = BicycleService(
      accessToken: token,
      userId: userId.toString(),
    );

    return _bicycleService!.getAllBicycles();
  }

  Widget _buildResultCard(
      BuildContext context, {
        required BicycleModel bicycle,
      }) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => BikeDetailBottomSheet(
            type: bicycle.bicycleModel,
            frameSize: bicycle.bicycleSize,
            frameMaterial: "Sin especificar",
            gears: "Sin especificar",
            brakes: "Sin especificar",
            weight: "Sin especificar",
            price: "S/ ${bicycle.bicyclePrice}/día",
            bicycle: bicycle, // Añadimos la bicicleta aquí
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        margin: EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.grey[200],
                  height: 80,
                  width: 80,
                  child: Icon(Icons.directions_bike, size: 50),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bicycle.bicycleName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      bicycle.bicycleDescription,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "S/ ${bicycle.bicyclePrice}/día",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF325D67),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}