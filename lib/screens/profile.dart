import 'package:ecobicimobileapp/screens/terminos_y_condiciones.dart';
import 'package:ecobicimobileapp/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecobicimobileapp/screens/signin_screen.dart';
import 'package:ecobicimobileapp/screens/help_support_screen.dart';
import 'package:ecobicimobileapp/services/auth_service.dart';
import 'package:ecobicimobileapp/services/user_service.dart';
import 'package:ecobicimobileapp/models/user_model.dart';

import 'notification_screen.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? userData;
  bool isLoading = true;
  String? error;
  String? accessToken;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final token = await AuthService.getCurrentUserToken();
      final userId = await AuthService.getCurrentUserId();

      if (token == null || userId == null) {
        throw Exception('No authentication data found');
      }

      final user = await UserService.getUserById(userId, token);
      accessToken = token;

      if (user == null) {
        throw Exception('No user data found');
      }

      setState(() {
        userData = user;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(child: Text('Error: $error')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF325D67),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: Color(0xFF325D67)),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadUserData,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFFE6E1F4),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF325D67).withOpacity(0.1),
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: userData?.imageData != null &&
                            userData!.imageData!.isNotEmpty
                            ? Image.network(
                          userData!.imageData!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print(
                                'Error loading image: $error'); // Para debugging
                            return Icon(
                              Icons.person_outline,
                              size: 40,
                              color: Color(0xFF325D67),
                            );
                          },
                          loadingBuilder:
                              (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                loadingProgress.expectedTotalBytes !=
                                    null
                                    ? loadingProgress
                                    .cumulativeBytesLoaded /
                                    loadingProgress
                                        .expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        )
                            : Icon(
                          Icons.person_outline,
                          size: 40,
                          color: Color(0xFF325D67),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userData?.firstName} ${userData?.lastName}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF325D67),
                            ),
                          ),
                          Text(
                            userData?.email ?? '',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          if (userData?.phone != null)
                            Text(
                              userData!.phone!,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Stats Section
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                        'Total de bicicletas', '${userData?.bicycles.length ?? 0}'),
                    _buildStatItem(
                        'Desde', userData?.birthDate.split('T')[0] ?? 'N/A'),
                  ],
                ),
              ),

              // Menu Options
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Configuración',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF325D67),
                  ),
                ),
              ),

              _buildMenuItem(
                  context, Icons.person_outline, 'información personal',
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfileScreen()));
                  }
              ),
              _buildMenuItem(
                  context, Icons.notifications_outlined, 'Notificationes',
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen(
                              userId: userData?.id ?? 0,
                              accessToken: accessToken ?? '',
                            ))
                    );
                  }
              ),
              _buildMenuItem(
                  context, Icons.security_outlined, 'Términos y condiciones',
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TermsAndConditionsScreen()));
                  }
              ),
              _buildMenuItem(context, Icons.help_outline, 'Contáctanos',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HelpSupportScreen(
                          userName: '${userData?.firstName} ${userData?.lastName}',
                          userEmail: userData?.email ?? '',
                        ),
                      ),
                    );
                  }),

              // Logout Button
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _handleLogout(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF325D67),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Cerrar sesión',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('user_id');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SigninScreen()),
          (Route<dynamic> route) => false,
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF325D67),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title,
      {VoidCallback? onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF325D67)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF325D67),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFF325D67),
        ),
        onTap: onTap,
      ),
    );
  }
}
