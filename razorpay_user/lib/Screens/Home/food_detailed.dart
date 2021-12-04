import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_user/Helpers/style.dart';
import 'package:razorpay_user/Models/food_model.dart';
import 'package:razorpay_user/Providers/cart.dart';
import 'package:razorpay_user/Screens/Home/add_food.dart';
import 'package:razorpay_user/Widgets/drawer_widget.dart';
import 'package:razorpay_user/Widgets/home_scaffold.dart';

class FoodDetailed extends StatefulWidget {
  static const pg = 'foodDetailed';

  const FoodDetailed({Key? key, this.foodModel}) : super(key: key);

  final FoodModel? foodModel;

  @override
  _FoodDetailedState createState() => _FoodDetailedState();
}

class _FoodDetailedState extends State<FoodDetailed> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String infoEndTime(String type) {
    if (type == 'Breakfast') {
      return '09:00 AM';
    }
    if (type == 'Lunch') {
      return '01:30 PM';
    }
    return '09:00 PM';
  }

  String infoStartTime(String type) {
    if (type == 'Lunch') {
      return '09:30 AM';
    }
    if (type == 'Dinner') {
      return '06:00 PM';
    }
    return '07:00 AM';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        if (Provider.of<Cart>(context, listen: false).totalCartItems > 0) {
          Navigator.pop(context);
        }
        Navigator.pop(context);

        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: HomeScaffold(
          onDrawerPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
            ),
            children: [
              SizedBox(height: width * 0.03),
              Center(
                child: Hero(
                  tag: widget.foodModel!.id ?? "",
                  child: SizedBox(
                    width: width * 0.75,
                    height: width * 0.55,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(width * 0.05),
                      child: Image.network(
                        widget.foodModel!.imageUrl ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: width * 0.05),
              Container(
                alignment: Alignment.center,
                child: Text(
                  widget.foodModel!.title ?? "",
                  style: TextStyle(
                    fontSize: width * 0.06,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '₹${widget.foodModel!.price ?? ""}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: width * 0.035),
              Text(
                'Delivery Info',
                style: greenBoldText.copyWith(fontSize: width * 0.04),
              ),
              SizedBox(height: width * 0.01),
              Text(
                'Delivered on all days between ${infoStartTime(widget.foodModel!.type ?? "")} and ${infoEndTime(widget.foodModel!.type ?? "")}. Pleace check for delivery charges if applicable.',
              ),
              SizedBox(height: width * 0.04),
              Text(
                'Description',
                style: greenBoldText.copyWith(fontSize: width * 0.04),
              ),
              SizedBox(height: width * 0.01),
              Text(widget.foodModel!.description ?? ""),
              SizedBox(height: width * 0.04),
              widget.foodModel!.combo == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.foodModel!.title ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.035,
                          ),
                        ),
                        SizedBox(height: width * 0.01),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.04,
                            ),
                            children: [
                              for (int i = 0;
                                  i < widget.foodModel!.comboItems!.length;
                                  i++)
                                TextSpan(
                                  text:
                                      '${widget.foodModel!.comboItems![i].title} x 1${i != widget.foodModel!.comboItems!.length - 1 ? ', ' : ''}',
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: width * 0.04),
                      ],
                    )
                  : Container(),
              SizedBox(height: width * 0.03),
              AddFood(widget.foodModel!.id ?? ""),
            ],
          ),
        ),
        drawer: const DrawerWidget(),
      ),
    );
  }
}
