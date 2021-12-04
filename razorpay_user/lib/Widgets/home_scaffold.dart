import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_user/Helpers/colors.dart';
import 'package:razorpay_user/Helpers/custom_icons.dart';
import 'package:razorpay_user/Providers/cart.dart';
import 'package:razorpay_user/Screens/home_screen.dart';
import 'package:razorpay_user/Screens/order_summary.dart';

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
              'AMC Enclave, No. 6, Third Cross Street, Sterling Road',
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
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    'https://www.wallpapertip.com/wmimgs/159-1592363_full-hd-girls-hd.jpg',
                    height: width * 0.01,
                    fit: BoxFit.cover,
                  ),
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
                widget.ordersIcon == true
                    ? Consumer<Cart>(
                        builder: (context, cart, child) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrderSummary(),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  child ?? Container(),
                                  cart.totalCartItems > 0
                                      ? Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFE52323),
                                              shape: BoxShape.circle,
                                            ),
                                            height: width * 0.017,
                                            width: width * 0.017,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              const Text('Cart'),
                            ],
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(width * 0.01),
                          child: Icon(
                            CustomIcons.orders,
                            color: green,
                            size: width * 0.047,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Expanded(child: widget.child ?? Container()),
        ],
      ),
    );
  }
}
