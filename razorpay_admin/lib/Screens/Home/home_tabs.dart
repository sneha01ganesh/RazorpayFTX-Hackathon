import 'package:flutter/material.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Helpers/style.dart';
import 'package:razorpay_admin/Screens/Home/food_grid.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({Key? key}) : super(key: key);

  @override
  _HomeTabsState createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 75,
        bottom: PreferredSize(
          preferredSize: Size.zero,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: TabBar(
              labelColor: green,
              unselectedLabelColor: grey,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.symmetric(horizontal: width * 0.0),
              labelStyle: greenBoldText.copyWith(
                fontSize: width * 0.035,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w900,
              ),
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: green,
                    width: width * 0.006,
                  ),
                ),
              ),
              controller: _tabController,
              tabs: const [
                Tab(text: 'Breakfast'),
                Tab(text: 'Lunch'),
                Tab(text: 'Dinner'),
                Tab(text: 'Special Deal'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          FoodGrid(type: 'Breakfast'),
          FoodGrid(type: 'Lunch'),
          FoodGrid(type: 'Dinner'),
          FoodGrid(type: 'Special'),
        ],
      ),
    );
  }
}
