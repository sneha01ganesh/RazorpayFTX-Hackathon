import 'package:flutter/material.dart';
import 'package:razorpay_user/Helpers/colors.dart';
import 'package:razorpay_user/Helpers/custom_icons.dart';
import 'package:razorpay_user/Screens/home_screen.dart';

//ignore: must_be_immutable
class HomeScaffold extends StatefulWidget {
  HomeScaffold({
    Key? key,
    @required this.child,
    this.ordersIcon = true,
    this.onDrawerPressed,
  }) : super(key: key);

  Widget? child;
  final bool? ordersIcon;
  final VoidCallback? onDrawerPressed;

  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {},
          child: Container(
            width: width * 0.8,
            height: width * 0.1,
            alignment: Alignment.centerLeft,
            child: Text(
              'Address',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: width * 0.04,
              ),
            ),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.035,
          ),
          child: const Icon(
            CustomIcons.location,
            color: green,
          ),
        ),
        leadingWidth: width * 0.07,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const Home(pgNo: 0),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: width * 0.01),
              child: ClipOval(
                child: Image.asset(
                  'images/Avatar1.png',
                  height: width * 0.01,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          SizedBox(width: width * 0.04),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: width * 0.0015,
          ),
          preferredSize: const Size.fromHeight(0),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: width * 0.015),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    CustomIcons.menu,
                    color: green,
                    size: width * 0.04,
                  ),
                  onPressed: widget.onDrawerPressed,
                ),
              ],
            ),
          ),
          Expanded(child: widget.child ?? Container()),
        ],
      ),
    );
  }
}
