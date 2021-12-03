import 'package:flutter/material.dart';
import 'package:razorpay_user/Helpers/colors.dart';
import 'package:razorpay_user/Helpers/custom_icons.dart';
import 'package:razorpay_user/Screens/Home/homepage_screen.dart';
import 'package:razorpay_user/Screens/profile_screen.dart';
import 'package:razorpay_user/Screens/recents_screen.dart';
import 'package:razorpay_user/Widgets/drawer_widget.dart';
import 'package:razorpay_user/Widgets/home_scaffold.dart';

class Home extends StatefulWidget {
  static const pg = 'home';

  final int? pgNo;

  const Home({Key? key, this.pgNo}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedNavIcon = 1;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    bool displayFAB = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      key: _scaffoldKey,
      body: HomeScaffold(
        onDrawerPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        child: _selectedNavIcon == 0
            ? const Profile()
            : _selectedNavIcon == 1
                ? const HomeScreen()
                : const Recents(),
      ),
      floatingActionButton: displayFAB
          ? Container(
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
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Icon(
                          _selectedNavIcon == 0
                              ? Icons.account_circle_rounded
                              : _selectedNavIcon == 1
                                  ? CustomIcons.home
                                  : CustomIcons.recents,
                          size: width * 0.05,
                        ),
                      ),
                      Text(
                        _selectedNavIcon == 0
                            ? 'Profile'
                            : _selectedNavIcon == 1
                                ? 'Home'
                                : 'Recents',
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
            )
          : Container(),
      drawer: DrawerWidget(),
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
                Icons.account_circle_rounded,
                size: width * 0.075,
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
                CustomIcons.recents,
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
