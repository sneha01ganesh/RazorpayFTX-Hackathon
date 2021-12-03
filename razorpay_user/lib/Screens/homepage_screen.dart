import 'package:flutter/material.dart';
import 'package:razorpay_user/Helpers/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        ListView(),
        Column(
          children: [
            Text(
              'Gowthama Home Food',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkGreen,
                fontSize: width * 0.05,
              ),
            ),
            Text(
              'Since 2001',
              style: TextStyle(
                color: darkGreen,
                fontSize: width * 0.043,
              ),
            ),
            SizedBox(height: width * 0.05),
            // Expanded(
            //   child: HomeTabs(),
            // ),
          ],
        ),
      ],
    );
  }
}
