import 'package:flutter/material.dart';
import 'package:razorpay_user/Helpers/colors.dart';
import 'package:razorpay_user/Screens/home_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.8,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: width * 0.03,
              ),
              margin: EdgeInsets.only(
                right: width * 0.02,
                top: width * 0.02,
              ),
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    width * 0.02,
                  ),
                  bottomRight: Radius.circular(
                    width * 0.02,
                  ),
                ),
              ),
              child: const Text(
                'Welcome',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              margin: EdgeInsets.only(top: width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: width * 0.02),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: width * 0.02),
                    child: InkWell(
                      child: Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: width * 0.042,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(height: width * 0.03),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: width * 0.02),
                    child: InkWell(
                      child: Text(
                        'Your Orders',
                        style: TextStyle(
                          fontSize: width * 0.042,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const Home(pgNo: 2),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: width * 0.03),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: width * 0.02),
                    child: InkWell(
                      child: Text(
                        'Your Account',
                        style: TextStyle(
                          fontSize: width * 0.042,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const Home(pgNo: 0),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: width * 0.03),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: width * 0.02),
                    child: InkWell(
                      child: Text(
                        'Feedbacks',
                        style: TextStyle(
                          fontSize: width * 0.042,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(height: width * 0.03),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: width * 0.02),
                    child: InkWell(
                      child: Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          fontSize: width * 0.042,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(height: width * 0.03),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: width * 0.02),
                    child: InkWell(
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: width * 0.042,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(height: width * 0.03),
                  InkWell(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: width * 0.02),
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: width * 0.042,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(height: width * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
