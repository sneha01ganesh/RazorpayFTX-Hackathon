import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_admin/Providers/delivery_orders.dart';
import 'package:razorpay_admin/Providers/food_items.dart';
import 'package:razorpay_admin/Screens/DeliveryPartner/delivery_details_page.dart';
import 'package:razorpay_admin/Screens/DeliveryPartner/delivery_home.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DeliveryOrders(),
        ),
        ChangeNotifierProvider(
          create: (context) => FoodItems(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: kPrimaryColor,
        ),
        initialRoute: LandingPage.pg,
        routes: {
          Home.pg: (ctx) => const Home(),
          LandingPage.pg: (ctx) => const LandingPage(),
          DeliveryHome.pg: (ctx) => const DeliveryHome(),
          DeliveryOrderPage.pg: (ctx) => const DeliveryOrderPage(),
        },
      ),
    );
  }
}
