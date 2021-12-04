import 'package:flutter/material.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Screens/admin_passcode.dart';
import 'package:razorpay_admin/Screens/home.dart';
import 'package:razorpay_admin/Widgets/dialogs.dart';

//ignore:must_be_immutable
class LandingPage extends StatefulWidget {
  static const pg = 'landing';

  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Dialogs dialogs = Dialogs();

  void navigateAdmin() async {
    try {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminPasscode(),
        ),
      );
    } catch (error) {
      dialogs.error(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: width * 0.8,
            child: Image.asset('images/Logo.png'),
          ),
          SizedBox(height: width * 0.1),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE8FEF5),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  width * 0.08,
                ),
                bottomLeft: Radius.circular(
                  width * 0.08,
                ),
              ),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.08,
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: navigateAdmin,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1,
                        vertical: width * 0.025,
                      ),
                      decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            width * 0.05,
                          ),
                          bottomRight: Radius.circular(
                            width * 0.05,
                          ),
                        ),
                      ),
                      child: Text(
                        'Admin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: width * 0.2),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => LoginScreen(),
                    //   ),
                    // );
                  },
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1,
                        vertical: width * 0.025,
                      ),
                      decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            width * 0.05,
                          ),
                          bottomLeft: Radius.circular(
                            width * 0.05,
                          ),
                        ),
                      ),
                      child: Text(
                        'Delivery',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
