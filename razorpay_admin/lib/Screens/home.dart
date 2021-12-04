import 'package:flutter/material.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Helpers/custom_icons.dart';
import 'package:razorpay_admin/Screens/Home/home_screen.dart';
import 'package:razorpay_admin/Screens/admin_delivery.dart';
import 'package:razorpay_admin/Screens/requests.dart';
import 'package:razorpay_admin/Widgets/appbar_widget.dart';
import 'package:razorpay_admin/Widgets/drawer_widget.dart';

class Home extends StatefulWidget {
  static const pg = 'home';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedNavIcon = 1;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget.appBar(
        context: context,
        title: _selectedNavIcon == 0
            ? 'Delivery'
            : _selectedNavIcon == 1
                ? ''
                : 'Requests',
        icon: Icon(
          CustomIcons.menu,
          size: width * 0.04,
          color: green,
        ),
        iconOnPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
      ),
      body: _selectedNavIcon == 0
          ? const AdminDelivery()
          : _selectedNavIcon == 1
              ? const HomeScreen()
              : const Requests(),
      drawer: const DrawerWidget(),
      floatingActionButton: Container(
        padding: _selectedNavIcon == 0
            ? EdgeInsets.only(left: width * 0.09)
            : _selectedNavIcon == 1
                ? EdgeInsets.zero
                : EdgeInsets.only(right: width * 0.09),
        height: width * 0.165,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: lightGreen.withOpacity(0.98),
            isExtended: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: _selectedNavIcon == 0
                      ? EdgeInsets.only(right: width * 0.025)
                      : _selectedNavIcon == 1
                          ? EdgeInsets.only(right: width * 0.005)
                          : EdgeInsets.zero,
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      _selectedNavIcon == 0
                          ? CustomIcons.delivery
                          : _selectedNavIcon == 1
                              ? CustomIcons.home
                              : CustomIcons.requests,
                      size: width * 0.05,
                    ),
                  ),
                ),
                Text(
                  _selectedNavIcon == 0
                      ? 'Delivery'
                      : _selectedNavIcon == 1
                          ? 'Home'
                          : 'Request',
                  style: TextStyle(
                    fontSize: width * 0.0175,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            onPressed: () {},
          ),
        ),
      ),
      floatingActionButtonLocation: _selectedNavIcon == 0
          ? FloatingActionButtonLocation.miniStartDocked
          : _selectedNavIcon == 1
              ? FloatingActionButtonLocation.miniCenterDocked
              : FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: Container(
        color: green,
        padding: EdgeInsets.symmetric(
          vertical: width * 0.009,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _selectedNavIcon == 0
                  ? null
                  : () {
                      setState(() {
                        _selectedNavIcon = 0;
                      });
                    },
              icon: Icon(
                CustomIcons.delivery,
                size: width * 0.055,
                color: _selectedNavIcon == 0 ? green : Colors.white,
              ),
            ),
            SizedBox(width: width * 0.175),
            IconButton(
              onPressed: _selectedNavIcon == 1
                  ? null
                  : () {
                      setState(() {
                        _selectedNavIcon = 1;
                      });
                    },
              icon: Icon(
                CustomIcons.home,
                size: width * 0.07,
                color: _selectedNavIcon == 1 ? green : Colors.white,
              ),
            ),
            SizedBox(width: width * 0.175),
            IconButton(
              onPressed: _selectedNavIcon == 2
                  ? null
                  : () {
                      setState(() {
                        _selectedNavIcon = 2;
                      });
                    },
              icon: Icon(
                CustomIcons.requests,
                size: width * 0.075,
                color: _selectedNavIcon == 2 ? green : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
