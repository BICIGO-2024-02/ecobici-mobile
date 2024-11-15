import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/widgets/bottomBikeDetailSheet.dart';
import 'package:ecobicimobileapp/services/bicycle_service.dart';
import 'package:ecobicimobileapp/services/auth_service.dart';
import 'package:ecobicimobileapp/models/bicycle_model.dart';

class ResultsScreen extends StatefulWidget {
  final double? budget;

  ResultsScreen({this.budget});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final AuthService _authService = AuthService();
  BicycleService? _bicycleService;
  int _currentPage = 0;
  static const int _itemsPerPage = 3;

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
                final pageCount = (bicycles.length / _itemsPerPage).ceil();

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
                          itemCount: _getPageItemsCount(bicycles),
                          itemBuilder: (context, index) {
                            final bicycleIndex = _currentPage * _itemsPerPage + index;
                            final bicycle = bicycles[bicycleIndex];
                            return _buildResultCard(
                              context,
                              bicycle: bicycle,
                            );
                          },
                        ),
                      ),
                      _buildPaginatorControls(pageCount),
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
    if (_bicycleService == null) {
      final token = await AuthService.getCurrentUserToken();
      final userId = await AuthService.getCurrentUserId();
      if (token == null || userId == null) throw Exception('No se encontró token o userId');

      _bicycleService = BicycleService(accessToken: token, userId: userId.toString());
    }

    final allBicycles = await _bicycleService!.getAllBicycles();

    // Filtrar por presupuesto si se especifica
    if (widget.budget != null) {
      return allBicycles.where((bicycle) => bicycle.bicyclePrice <= widget.budget!).toList();
    }

    return allBicycles;
  }


  int _getPageItemsCount(List<BicycleModel> bicycles) {
    final start = _currentPage * _itemsPerPage;
    final end = start + _itemsPerPage;
    return (end > bicycles.length) ? bicycles.length - start : _itemsPerPage;
  }

  Widget _buildPaginatorControls(int pageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _currentPage > 0
              ? () {
            setState(() {
              _currentPage--;
            });
          }
              : null,
        ),
        Text(
          'Página ${_currentPage + 1} de $pageCount',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: _currentPage < pageCount - 1
              ? () {
            setState(() {
              _currentPage++;
            });
          }
              : null,
        ),
      ],
    );
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
            name: bicycle.bicycleName,
            description: bicycle.bicycleDescription,
            model: bicycle.bicycleModel,
            size: bicycle.bicycleSize,
            pickUpLocation: bicycle.pickUpLocation,
            deliveryLocation: bicycle.deliveryLocation,
            price: "S/ ${bicycle.bicyclePrice}/día",
            bicycle: bicycle,
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
                  child: bicycle.imageData.isNotEmpty
                      ? Image.network(
                    bicycle.imageData,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error_outline, size: 50, color: Colors.red);
                    },
                  )
                      : Icon(Icons.directions_bike, size: 50),
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
