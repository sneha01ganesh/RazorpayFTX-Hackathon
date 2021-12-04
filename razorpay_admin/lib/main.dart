import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_admin/Screens/home.dart';
import 'package:razorpay_admin/Screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const MaterialColor kPrimaryColor = MaterialColor(
    0xFF189667,
    <int, Color>{
      50: Color(0xFF189667),
      100: Color(0xFF189667),
      200: Color(0xFF189667),
      300: Color(0xFF189667),
      400: Color(0xFF189667),
      500: Color(0xFF189667),
      600: Color(0xFF189667),
      700: Color(0xFF189667),
      800: Color(0xFF189667),
      900: Color(0xFF189667),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      initialRoute: LandingPage.pg,
      routes: {
        Home.pg: (ctx) => const Home(),
        LandingPage.pg: (ctx) => const LandingPage(),
      },
    );
  }
}
