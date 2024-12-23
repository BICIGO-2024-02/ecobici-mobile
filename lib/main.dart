import 'package:ecobicimobileapp/screens/signin_screen.dart';
import 'package:ecobicimobileapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecobicimobileapp/screens/screens.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ecobicimobileapp/constants/keys.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = PublishableKey;
  await Stripe.instance.applySettings();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
      routes: {
        'home':       (BuildContext context) => HomeScreen(),
        'register':   (BuildContext context) => RegisterScreen(),
        'signin':     (BuildContext context) => SigninScreen(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
