import 'dart:async';

import 'package:flutter/material.dart';
import 'package:razorpay_user/Helpers/style.dart';
import 'package:razorpay_user/Screens/home_screen.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({Key? key}) : super(key: key);

  @override
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  late Timer timer;

  exit() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (ctx) => const Home(),
      ),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 10), () => exit());
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => exit(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: width * 0.27,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Text(
                    'Your order has been placed successfully!!!',
                    style: TextStyle(
                      fontSize: width * 0.04,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: width * 0.25),
                InkWell(
                  onTap: exit,
                  child: const Text(
                    'Go back to Home Screen',
                    style: greenText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
