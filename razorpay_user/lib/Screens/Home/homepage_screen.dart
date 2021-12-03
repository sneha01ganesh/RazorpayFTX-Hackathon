import 'package:flutter/material.dart';
import 'package:razorpay_user/Helpers/colors.dart';
import 'package:razorpay_user/Screens/Home/home_tabs.dart';

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
              'Shadow Galley',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkGreen,
                fontSize: width * 0.05,
              ),
            ),
            SizedBox(height: width * 0.05),
            const Expanded(
              child: HomeTabs(),
            ),
          ],
        ),
      ],
    );
  }
}
