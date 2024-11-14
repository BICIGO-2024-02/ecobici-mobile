import 'package:ecobicimobileapp/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = true;
  bool _isLoadingSave = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final token = await AuthService.getCurrentUserToken();
    final userId = await AuthService.getCurrentUserId();

    if (token == null || userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se encontró la sesión del usuario'))
      );
      return;
    }

    UserService.getUserById(userId, token).then((user) {
      _nameController.text = user!.firstName;
      _lastnameController.text = user.lastName;
      _emailController.text = user.email;

      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString()))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Información personal',
            style: TextStyle(
              color: Color(0xFF325D67),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: _isLoading ? Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Actualiza tus datos",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF325D67)),
                    ),
                    const Text(
                      "Mantén tu información personal\nconfidencial",
                      style: TextStyle(fontSize: 15, color: Color(0xFF818181)),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Nombre:",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: Color(0xFFC6C6C6), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: Color(0xFFC6C6C6), width: 1)),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _lastnameController,
                        decoration: InputDecoration(
                          hintText: "Apellido:",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: Color(0xFFC6C6C6), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: Color(0xFFC6C6C6), width: 1)),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Correo:",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: Color(0xFFC6C6C6), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: Color(0xFFC6C6C6), width: 1)),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () async {  // Hacemos async el onPressed
                          try {
                            setState(() {
                              _isLoadingSave = true;
                            });

                            // Obtenemos userId y token
                            final token = await AuthService.getCurrentUserToken();
                            final userId = await AuthService.getCurrentUserId();

                            if (token == null || userId == null) {
                              throw Exception('No se encontró la sesión del usuario');
                            }

                            // Llamamos a updateUser con todos los parámetros requeridos
                            await UserService.updateUser(
                                userId,
                                token,
                                _nameController.text,
                                _lastnameController.text,
                                _emailController.text
                            );

                            setState(() {
                              _isLoadingSave = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Cuenta actualizada con éxito"))
                            );

                            Navigator.pop(context);

                          } catch (error) {
                            setState(() {
                              _isLoadingSave = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString()))
                            );
                          }
                        },
                        child: _isLoadingSave
                            ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                            )
                        )
                            : Text(
                          "Guardar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xFF325D67),
                          ),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              )
                          ),
                        ),
                      ),
                    )
                  ]
              ),
            )
        )
    );
  }
}