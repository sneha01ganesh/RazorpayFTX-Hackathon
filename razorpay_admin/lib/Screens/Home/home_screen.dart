import 'package:flutter/material.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Screens/Forms/add_edit_dish.dart';
import 'package:razorpay_admin/Screens/Home/home_tabs.dart';

class HomeScreen extends StatefulWidget {
  static const pg = 'adminHome';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          ListView(),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: width * 0.08),
                Text(
                  'Shadow Galley',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                    fontSize: width * 0.055,
                  ),
                ),
                SizedBox(height: width * 0.07),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddEditDish(addPage: true),
                      ),
                    );
                  },
                  child: Material(
                    shape: const CircleBorder(side: BorderSide.none),
                    elevation: width * 0.015,
                    child: Container(
                      alignment: Alignment.center,
                      width: width * 0.23,
                      height: width * 0.23,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: green,
                            size: width * 0.053,
                          ),
                          const Text(
                            'Add Dish',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: width * 0.03),
                const Expanded(
                  child: HomeTabs(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
