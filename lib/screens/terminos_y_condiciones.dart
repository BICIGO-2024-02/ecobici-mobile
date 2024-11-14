import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  final String termsAndConditions = """
Bienvenido a EcoBici. Estos Términos y Condiciones de Uso regulan el acceso y el uso de la aplicación móvil EcoBici, diseñada para el alquiler de bicicletas en Lima, Perú. Al utilizar nuestra aplicación, aceptas cumplir con estos Términos y Condiciones. Si no estás de acuerdo con estos términos, no podrás usar nuestros servicios.

1. Definiciones

EcoBici: La aplicación móvil de alquiler de bicicletas, propiedad de Ecobici.
Usuario: Toda persona que accede o utiliza la aplicación.
Bicicleta: Cualquier bicicleta alquilada a través de la aplicación EcoBici.
Cuenta: El perfil creado por el Usuario en la aplicación para utilizar los servicios.

2. Registro y Cuenta de Usuario

Para utilizar EcoBici, debes registrarte y crear una cuenta. Solo los mayores de 18 años pueden registrarse y utilizar el servicio.
Toda la información proporcionada durante el registro debe ser veraz, completa y actualizada.
Eres responsable de mantener la confidencialidad de tus credenciales de acceso y de todas las actividades realizadas desde tu cuenta.

3. Uso del Servicio

EcoBici ofrece la opción de alquilar bicicletas, realizar pagos y gestionar reservas a través de la aplicación.
El Usuario se compromete a utilizar la bicicleta de forma adecuada, siguiendo las normas de tránsito y cuidando la seguridad tanto propia como de terceros.
El Usuario es responsable de devolver la bicicleta en el estado en el que fue entregada. Cualquier daño o pérdida de la bicicleta será responsabilidad del Usuario, quien deberá cubrir los costos de reparación o reposición.

4. Reservas y Cancelaciones

Puedes reservar una bicicleta a través de la aplicación. Las reservas deben confirmarse dentro de los 24h antes de la hora de uso programada.
Las cancelaciones de reservas deben realizarse con 48h de antelación. EcoBici se reserva el derecho de cobrar una tarifa de cancelación en caso de no cumplir con este plazo.

5. Tarifas y Pagos

Las tarifas de alquiler y cualquier otro cargo aplicable se mostrarán en la aplicación antes de que confirmes tu reserva.
Todos los pagos deben realizarse a través de los métodos de pago proporcionados en la aplicación.
EcoBici se reserva el derecho de modificar las tarifas y cargos en cualquier momento. Cualquier cambio se notificará a los usuarios a través de la aplicación.

6. Responsabilidad del Usuario

El Usuario se compromete a utilizar la bicicleta de forma segura y a devolverla en el mismo estado en que fue recibida.
El Usuario es el único responsable de cualquier daño causado a la bicicleta, así como de cualquier lesión o daño a terceros durante el uso de la bicicleta.
EcoBici no se hace responsable de lesiones, accidentes, daños a la propiedad o pérdidas resultantes del uso de las bicicletas.

7. Limitación de Responsabilidad

EcoBici no garantiza la disponibilidad ininterrumpida del servicio ni que la aplicación esté libre de errores.
En ningún caso EcoBici será responsable de daños directos, indirectos, incidentales, especiales o consecuenciales que resulten del uso o de la imposibilidad de uso de la aplicación o del servicio.

8. Modificaciones a los Términos y Condiciones

EcoBici se reserva el derecho de modificar estos Términos y Condiciones en cualquier momento. Las modificaciones serán notificadas a los usuarios a través de la aplicación.
Al continuar utilizando el servicio después de la modificación de los Términos y Condiciones, el Usuario acepta los cambios.

9. Suspensión y Terminación de la Cuenta

EcoBici se reserva el derecho de suspender o cancelar la cuenta de cualquier Usuario que incumpla estos Términos y Condiciones o haga un uso indebido de la aplicación o de los servicios.
En caso de cancelación de la cuenta, el Usuario no tendrá derecho a reembolso de ninguna tarifa pagada previamente.

10. Protección de Datos

La privacidad de los usuarios es una prioridad para EcoBici. Toda la información personal recopilada se manejará de acuerdo con nuestra Política de Privacidad.
EcoBici se compromete a proteger los datos personales del Usuario y a no compartirlos con terceros, excepto en los casos autorizados por el Usuario o requeridos por la ley.

11. Ley Aplicable y Jurisdicción

Estos Términos y Condiciones se regirán por las leyes de la República del Perú.
En caso de conflicto, el Usuario y EcoBici se someten a la jurisdicción exclusiva de los tribunales de Lima.

12. Contacto

Para cualquier consulta sobre estos Términos y Condiciones, puedes contactarnos en ecobici@gmail.com o a través del formulario de contacto en la aplicación.
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Términos y Condiciones',
          style: TextStyle(color: Color(0xFF325D67), fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            termsAndConditions,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
