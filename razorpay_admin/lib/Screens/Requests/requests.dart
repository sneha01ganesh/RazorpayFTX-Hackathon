import 'package:flutter/material.dart';
import 'package:razorpay_admin/Screens/Requests/confirmed_requests.dart';
import 'package:razorpay_admin/Screens/Requests/declined_requests.dart';
import 'package:razorpay_admin/Screens/Requests/pending_requests.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          children: const [
            PendingRequests(),
            ConfirmedRequests(),
            DeclinedRequests(),
          ],
        ),
      ),
    );
  }
}
