import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/rent_service.dart';
import '../models/rent_model.dart';
import 'package:intl/intl.dart';

class RentalHistoryScreen extends StatefulWidget {
  @override
  _RentalHistoryScreenState createState() => _RentalHistoryScreenState();
}

class _RentalHistoryScreenState extends State<RentalHistoryScreen> {
  late String token;  // Declare token here as a late variable
  late int userId;    // Declare userId here as a late variable
  late final RentService _rentalService;
  List _rentals = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Fetch the token and userId asynchronously
  Future<void> _loadUserData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // Fetch token and userId
      final fetchedToken = await AuthService.getCurrentUserToken();
      final fetchedUserId = await AuthService.getCurrentUserId();

      setState(() {
        token = fetchedToken ?? ''; // Handle null token if needed
        userId = fetchedUserId ?? 0;     // Handle the userId from AuthService
        _rentalService = RentService(accessToken: token);
        _loadRentals();  // After fetching token and userId, load the rentals
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load user data';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadRentals() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final rentals = await _rentalService.getUserRentals(userId);

      setState(() {
        _rentals = rentals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load rentals: $e';
        _isLoading = false;
      });
    }
  }


  String _calculateDuration(String start, String end) {
    final startDate = DateTime.parse(start);
    final endDate = DateTime.parse(end);
    final difference = endDate.difference(startDate);
    final hours = difference.inHours;
    final minutes = difference.inMinutes.remainder(60);
    return '${hours}h ${minutes}min';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'My Rentals',
          style: TextStyle(
            color: Color(0xFF325D67),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : Column(
        children: [
          // Stats Section
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF325D67),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF325D67).withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Total Rides', _rentals.length.toString(), Colors.white),
                _buildStatItem(
                    'This Month',
                    _rentals.where((rental) {
                      final startDate = DateTime.parse(rental.rentStartDate);
                      return startDate.month == DateTime.now().month &&
                          startDate.year == DateTime.now().year;
                    }).length.toString(),
                    Colors.white
                ),
                _buildStatItem(
                    'Active',
                    _rentals.where((rental) {
                      final endDate = DateTime.parse(rental.rentEndDate);
                      return endDate.isAfter(DateTime.now());
                    }).length.toString(),
                    Colors.white
                ),
              ],
            ),
          ),

          // Filter Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Recent Rentals',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF325D67),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E1F4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.filter_list,
                        size: 18,
                        color: Color(0xFF325D67),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: Color(0xFF325D67),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Rentals List
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadRentals,
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: _rentals.length,
                itemBuilder: (context, index) {
                  final rental = _rentals[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE6E1F4),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: rental.bicycle.imageData.isNotEmpty
                                        ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                    )
                                        : Icon(
                                      Icons.pedal_bike,
                                      color: Color(0xFF325D67),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          rental.bicycle.bicycleName,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF325D67),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          DateFormat('dd MMM yyyy').format(
                                              DateTime.parse(rental.rentStartDate)
                                          ),
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'S/ ${rental.rentPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF325D67),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildInfoChip(
                                    Icons.timer_outlined,
                                    _calculateDuration(
                                        rental.rentStartDate,
                                        rental.rentEndDate
                                    ),
                                  ),
                                  _buildStatusChip(_getRentalStatus(rental)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getRentalStatus(RentModel rental) {
    final now = DateTime.now();
    final endDate = DateTime.parse(rental.rentEndDate);
    if (endDate.isAfter(now)) {
      return 'Active';
    } else {
      return 'Completed';
    }
  }

  Widget _buildStatItem(String label, String value, Color textColor) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: textColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Chip(
      label: Row(
        children: [
          Icon(icon, size: 16, color: Color(0xFF325D67)),
          SizedBox(width: 4),
          Text(label),
        ],
      ),
      backgroundColor: Color(0xFFF2F2F2),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    );
  }

  Widget _buildStatusChip(String status) {
    return Chip(
      label: Text(status),
      backgroundColor: status == 'Active'
          ? Color(0xFF2AB26F)
          : Color(0xFF325D67),
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    );
  }
}
