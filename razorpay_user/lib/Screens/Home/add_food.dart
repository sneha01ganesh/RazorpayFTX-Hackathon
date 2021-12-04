import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_user/Helpers/buttons.dart';
import 'package:razorpay_user/Helpers/colors.dart';
import 'package:razorpay_user/Helpers/custom_icons.dart';
import 'package:razorpay_user/Helpers/style.dart';
import 'package:razorpay_user/Models/food_model.dart';
import 'package:razorpay_user/Providers/cart.dart';
import 'package:razorpay_user/Providers/food_items.dart';
import 'package:razorpay_user/Screens/order_summary.dart';
import 'package:razorpay_user/Widgets/dialogs.dart';

class AddFood extends StatefulWidget {
  static const pg = 'addFood';

  final String foodId;

  AddFood(this.foodId);

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  int foodPrice = 180;
  bool _orderBottomSheetOpen = false;

  Dialogs dialogs = Dialogs();

  _checkBottomSheet() {
    final totalItems = Provider.of<Cart>(context, listen: false).totalCartItems;

    if (_orderBottomSheetOpen == false && totalItems > 0) {
      _orderBottomSheet();
    } else if (_orderBottomSheetOpen == true && totalItems == 0) {
      Navigator.pop(context);
      _orderBottomSheetOpen = false;
    }
  }

  _orderBottomSheet() {
    final width = MediaQuery.of(context).size.width;

    _orderBottomSheetOpen = true;
    Scaffold.of(context).showBottomSheet((context) {
      return GestureDetector(
        onVerticalDragStart: (details) {},
        onTap: () {
          Navigator.pushNamed(context, OrderSummary.pg);
        },
        child: Container(
          height: width * 0.15,
          width: double.infinity,
          color: green.withOpacity(0.44),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: width * 0.1),
              Icon(
                CustomIcons.orders,
                size: width * 0.06,
              ),
              SizedBox(width: width * 0.1),
              Text(
                'View Orders (${Provider.of<Cart>(context).totalCartItems})',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.043,
                ),
              ),
              SizedBox(width: width * 0.25),
              Icon(
                Icons.arrow_right_rounded,
                size: width * 0.09,
              ),
            ],
          ),
        ),
      );
    });
  }

  var _isInit = true;
  var _sheetInit = true;
  FoodModel? food;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      food = Provider.of<FoodItems>(context, listen: false)
          .findById(widget.foodId);
    }
    _isInit = false;
  }

  Future<void>? _initBottomSheetOpen() {
    if (mounted) {
      if (Provider.of<Cart>(context, listen: false).totalCartItems > 0) {
        _orderBottomSheet();
      }
    } else {
      Future.delayed(
          const Duration(milliseconds: 100), () => _initBottomSheetOpen());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cart = Provider.of<Cart>(context);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_sheetInit) {
        _initBottomSheetOpen();
      }
      _sheetInit = false;
    });

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
      ),
      child: food!.availability! <= 0
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: width * 0.01),
              child: Text(
                'Currently Unavailable',
                style: TextStyle(
                  color: red,
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AddButton(
                      value: cart.itemCount(widget.foodId),
                      onAddTap: () {
                        if (cart.itemCount(widget.foodId) <
                            food!.availability!.toInt()) {
                          cart.addItem(food!.id ?? "", food!.title ?? "",
                              food!.price ?? 0);
                          _checkBottomSheet();
                        } else {
                          dialogs.error(
                            context: context,
                            content:
                                'You have reached the maximum available food count',
                          );
                        }
                      },
                      onRemoveTap: () {
                        cart.removeItem(food!.id ?? "");
                        _checkBottomSheet();
                      },
                    ),
                    SizedBox(width: width * 0.05),
                    Text(
                        '₹${cart.itemCount(food!.id ?? "") * food!.price!.toInt()}'),
                  ],
                ),
                SizedBox(height: width * 0.04),
                food!.combo == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Ons',
                            style:
                                greenBoldText.copyWith(fontSize: width * 0.04),
                          ),
                          SizedBox(height: width * 0.04),
                          for (var comboItems in food!.comboItems ?? [])
                            Padding(
                              padding: EdgeInsets.only(bottom: width * 0.04),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    constraints:
                                        BoxConstraints(maxWidth: width * 0.45),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${comboItems.title}'),
                                        SizedBox(height: width * 0.01),
                                        Text('+${comboItems.price}'),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      AddButton(
                                        value:
                                            cart.itemCount(comboItems.id ?? ""),
                                        onAddTap: () {
                                          if (cart.itemCount(
                                                  comboItems.id ?? "") <
                                              comboItems.availability!
                                                  .toInt()) {
                                            cart.addItem(
                                                comboItems.id ?? "",
                                                comboItems.title ?? "",
                                                comboItems.price ?? 0);
                                            _checkBottomSheet();
                                          } else {
                                            dialogs.error(
                                              context: context,
                                              content:
                                                  'You have reached the maximum available food count',
                                            );
                                          }
                                        },
                                        onRemoveTap: () {
                                          cart.removeItem(comboItems.id ?? "");
                                          _checkBottomSheet();
                                        },
                                      ),
                                      SizedBox(width: width * 0.05),
                                      Text(
                                        '₹${cart.itemCount(comboItems.id ?? "") * comboItems.price!.toInt()}',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(
                            height: _orderBottomSheetOpen
                                ? width * 0.15
                                : width * 0.06,
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
    );
  }
}
