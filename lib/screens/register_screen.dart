import 'package:ecobicimobileapp/screens/home_screen.dart';
import 'package:ecobicimobileapp/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureTextPassword = true;
  bool _obscureTextRepeatPassword = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();


  void _togglePasswordVisibility(bool repeat) {
    setState(() {
      if (repeat) {
        _obscureTextRepeatPassword = !_obscureTextRepeatPassword;
      } else {
        _obscureTextPassword = !_obscureTextPassword;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            const Text("Crear cuenta", style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Color(0xFF325D67)),),
            const Text("Crea tu usuario y contraseña para\nuna máxima seguridad", style: TextStyle(
                fontSize: 15,
                color: Color(0xFF818181)),
            ),
            SizedBox(height: 80,),
            Column(
              children: [
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
                          borderSide: BorderSide(
                              color: Color(0xFFC6C6C6),
                              width: 1
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color(0xFFC6C6C6),
                              width: 1
                          )
                      ),
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
                          borderSide: BorderSide(
                              color: Color(0xFFC6C6C6),
                              width: 1
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color(0xFFC6C6C6),
                              width: 1
                          )
                      ),
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
                          borderSide: BorderSide(
                              color: Color(0xFFC6C6C6),
                              width: 1
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color(0xFFC6C6C6),
                              width: 1
                          )
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    keyboardType: TextInputType.emailAddress,
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
                    controller: _passwordController,
                    obscureText: _obscureTextPassword,
                    decoration: InputDecoration(
                      hintText: "Contraseña:",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color(0xFFC6C6C6),
                              width: 1
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color(0xFFC6C6C6),
                              width: 1
                          )
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureTextPassword ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed:() {
                          _togglePasswordVisibility(false);
                        },
                      ),
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
                    controller: _repeatPasswordController,
                    obscureText: _obscureTextRepeatPassword,
                    decoration: InputDecoration(
                      hintText: "Repite la contraseña:",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color(0xFFC6C6C6),
                          width: 1
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Color(0xFFC6C6C6),
                              width: 1
                          )
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureTextRepeatPassword ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed:() {
                          _togglePasswordVisibility(true);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    onPressed: () => {
                      AuthService.register(_nameController.text, _lastnameController.text, _emailController.text, _passwordController.text, _repeatPasswordController.text).then((_) => {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cuenta creada con éxito"))),
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false,
                        ),
                      }).catchError((error) => {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())))
                      })
                    },
                     child: Text("Crear cuenta", style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                  ),), style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xFF325D67)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  ),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ya tienes una cuenta?", style: TextStyle(
                      color: Colors.black,
                    ),),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text("Inicia sesión aquí", style: TextStyle(
                      color: Color(0xFF325D67),
                    ),),),
                  ],
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
