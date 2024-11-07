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
  bool _termsAccepted = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  void _togglePasswordVisibility(bool repeat) {
    setState(() {
      if (repeat) {
        _obscureTextRepeatPassword = !_obscureTextRepeatPassword;
      } else {
        _obscureTextPassword = !_obscureTextPassword;
      }
    });
  }

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Términos y Condiciones"),
          content: SingleChildScrollView(
            child: Text(
                "Bienvenido a EcoBici. Estos Términos y Condiciones de Uso regulan el acceso y el uso de la aplicación móvil EcoBici, diseñada para el alquiler de bicicletas en Lima, Perú. Al utilizar nuestra aplicación, aceptas cumplir con estos Términos y Condiciones. Si no estás de acuerdo con estos términos, no podrás usar nuestros servicios.\n\n"
                "1. Definiciones\n\n"
                "EcoBici: La aplicación móvil de alquiler de bicicletas, propiedad de [Nombre de la Empresa/Desarrollador].\n"
                "Usuario: Toda persona que accede o utiliza la aplicación.\n"
                "Bicicleta: Cualquier bicicleta alquilada a través de la aplicación EcoBici.\n"
                "Cuenta: El perfil creado por el Usuario en la aplicación para utilizar los servicios.\n\n"
                "2. Registro y Cuenta de Usuario\n\n"
                "Para utilizar EcoBici, debes registrarte y crear una cuenta. Solo los mayores de 18 años pueden registrarse y utilizar el servicio.\n"
                "Toda la información proporcionada durante el registro debe ser veraz, completa y actualizada.\n"
                "Eres responsable de mantener la confidencialidad de tus credenciales de acceso y de todas las actividades realizadas desde tu cuenta.\n\n"
                "3. Uso del Servicio\n\n"
                "EcoBici ofrece la opción de alquilar bicicletas, realizar pagos y gestionar reservas a través de la aplicación.\n"
                "El Usuario se compromete a utilizar la bicicleta de forma adecuada, siguiendo las normas de tránsito y cuidando la seguridad tanto propia como de terceros.\n"
                "El Usuario es responsable de devolver la bicicleta en el estado en el que fue entregada. Cualquier daño o pérdida de la bicicleta será responsabilidad del Usuario, quien deberá cubrir los costos de reparación o reposición.\n\n"
                "4. Reservas y Cancelaciones\n\n"
                "Puedes reservar una bicicleta a través de la aplicación. Las reservas deben confirmarse dentro de los [número de horas] antes de la hora de uso programada.\n"
                "Las cancelaciones de reservas deben realizarse con [número de horas] de antelación. EcoBici se reserva el derecho de cobrar una tarifa de cancelación en caso de no cumplir con este plazo.\n\n"
                "5. Tarifas y Pagos\n\n"
                "Las tarifas de alquiler y cualquier otro cargo aplicable se mostrarán en la aplicación antes de que confirmes tu reserva.\n"
                "Todos los pagos deben realizarse a través de los métodos de pago proporcionados en la aplicación.\n"
                "EcoBici se reserva el derecho de modificar las tarifas y cargos en cualquier momento. Cualquier cambio se notificará a los usuarios a través de la aplicación.\n\n"
                "6. Responsabilidad del Usuario\n\n"
                "El Usuario se compromete a utilizar la bicicleta de forma segura y a devolverla en el mismo estado en que fue recibida.\n"
                "El Usuario es el único responsable de cualquier daño causado a la bicicleta, así como de cualquier lesión o daño a terceros durante el uso de la bicicleta.\n"
                "EcoBici no se hace responsable de lesiones, accidentes, daños a la propiedad o pérdidas resultantes del uso de las bicicletas.\n\n"
                "7. Limitación de Responsabilidad\n\n"
                "EcoBici no garantiza la disponibilidad ininterrumpida del servicio ni que la aplicación esté libre de errores.\n"
                "En ningún caso EcoBici será responsable de daños directos, indirectos, incidentales, especiales o consecuenciales que resulten del uso o de la imposibilidad de uso de la aplicación o del servicio.\n\n"
                "8. Modificaciones a los Términos y Condiciones\n\n"
                "EcoBici se reserva el derecho de modificar estos Términos y Condiciones en cualquier momento. Las modificaciones serán notificadas a los usuarios a través de la aplicación.\n"
                "Al continuar utilizando el servicio después de la modificación de los Términos y Condiciones, el Usuario acepta los cambios.\n\n"
                "9. Suspensión y Terminación de la Cuenta\n\n"
                "EcoBici se reserva el derecho de suspender o cancelar la cuenta de cualquier Usuario que incumpla estos Términos y Condiciones o haga un uso indebido de la aplicación o de los servicios.\n"
                "En caso de cancelación de la cuenta, el Usuario no tendrá derecho a reembolso de ninguna tarifa pagada previamente.\n\n"
                "10. Protección de Datos\n\n"
                "La privacidad de los usuarios es una prioridad para EcoBici. Toda la información personal recopilada se manejará de acuerdo con nuestra [Política de Privacidad].\n"
                "EcoBici se compromete a proteger los datos personales del Usuario y a no compartirlos con terceros, excepto en los casos autorizados por el Usuario o requeridos por la ley.\n\n"
                "11. Ley Aplicable y Jurisdicción\n\n"
                "Estos Términos y Condiciones se regirán por las leyes de la República del Perú.\n"
                "En caso de conflicto, el Usuario y EcoBici se someten a la jurisdicción exclusiva de los tribunales de [Ciudad].\n\n"
                "12. Contacto\n\n"
                "Para cualquier consulta sobre estos Términos y Condiciones, puedes contactarnos en [correo electrónico de contacto] o a través del formulario de contacto en la aplicación."),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          const Text(
            "Crear cuenta",
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Color(0xFF325D67)),
          ),
          const Text(
            "Crea tu usuario y contraseña para\nuna máxima seguridad",
            style: TextStyle(fontSize: 15, color: Color(0xFF818181)),
          ),
          SizedBox(
            height: 80,
          ),
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
                        borderSide:
                            BorderSide(color: Color(0xFFC6C6C6), width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Color(0xFFC6C6C6), width: 1)),
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureTextPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
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
                        borderSide:
                            BorderSide(color: Color(0xFFC6C6C6), width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Color(0xFFC6C6C6), width: 1)),
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureTextRepeatPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _togglePasswordVisibility(true);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: _termsAccepted,
                    onChanged: (bool? value) {
                      setState(() {
                        _termsAccepted = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: _showTermsAndConditions,
                      child: const Text(
                        "Acepto los términos y condiciones",
                        style: TextStyle(
                          color: Color(0xFF325D67),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: _termsAccepted
                      ? () => {
                            AuthService.register(
                              _nameController.text,
                              _lastnameController.text,
                              _emailController.text,
                              _passwordController.text,
                              _repeatPasswordController.text,
                              phone: "1234567890",
                              birthDate: DateTime.now(),
                              imageData: "base64string",
                            )
                                .then((_) => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Cuenta creada con éxito"))),
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                        (Route<dynamic> route) => false,
                                      ),
                                    })
                                .catchError((error) => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(error.toString())))
                                    })
                          }
                      : null,
                  child: Text(
                    "Crear cuenta",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        _termsAccepted ? Color(0xFF325D67) : Colors.grey),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ya tienes una cuenta?",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Inicia sesión aquí",
                      style: TextStyle(
                        color: Color(0xFF325D67),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
