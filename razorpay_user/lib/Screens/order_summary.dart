import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_user/Helpers/buttons.dart';
import 'package:razorpay_user/Helpers/colors.dart';
import 'package:razorpay_user/Helpers/custom_icons.dart';
import 'package:razorpay_user/Helpers/style.dart';
import 'package:razorpay_user/Providers/cart.dart';
import 'package:razorpay_user/Providers/food_items.dart';
import 'package:razorpay_user/Screens/home_screen.dart';
import 'package:razorpay_user/Widgets/drawer_widget.dart';
import 'package:razorpay_user/Widgets/home_scaffold.dart';

class OrderSummary extends StatefulWidget {
  static const pg = 'order_summary';

  const OrderSummary({Key? key}) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool? cod = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items;

    return Scaffold(
      key: _scaffoldKey,
      body: HomeScaffold(
        onDrawerPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        ordersIcon: false,
        child: cartItems.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Cart is Empty'),
                ],
              )
            : ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                ),
                children: [
                  Text(
                    'Your Order Summary',
                    style: greenBoldText.copyWith(
                      fontSize: width * 0.0475,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: width * 0.1),
                  for (var itemId in cartItems.keys)
                    Padding(
                      padding: EdgeInsets.only(bottom: width * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${cartItems[itemId]!.title}',
                              ),
                              Text(
                                '+${cartItems[itemId]!.price}',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Consumer<FoodItems>(
                                builder: (context, food, child) => AddButton(
                                  value: cart.itemCount(itemId),
                                  onAddTap: () {
                                    cart.addItem(
                                      itemId,
                                      cartItems[itemId]!.title ?? "",
                                      cartItems[itemId]!.price ?? 0,
                                    );
                                  },
                                  onRemoveTap: () {
                                    cart.removeItem(itemId);
                                  },
                                ),
                              ),
                              SizedBox(width: width * 0.05),
                              Text(
                                  '₹${cartItems[itemId]!.price! * cartItems[itemId]!.quantity!.toInt()}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Delivery Charges'),
                      Text('₹30'),
                    ],
                  ),
                  SizedBox(height: width * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('To Pay'),
                      SizedBox(width: width * 0.06),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              bottom: width * 0.02,
                            ),
                            width: width * 0.15,
                            decoration: BoxDecoration(
                              color: green,
                              border: Border.all(color: green),
                            ),
                          ),
                          Text('₹ ${cart.totalAmount + 30}'),
                          Container(
                            margin: EdgeInsets.only(
                              top: width * 0.02,
                            ),
                            width: width * 0.15,
                            decoration: BoxDecoration(
                              color: green,
                              border: Border.all(color: green),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: width * 0.04),
                  const Text('Deliver to'),
                  SizedBox(height: width * 0.015),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          CustomIcons.location,
                          color: green,
                        ),
                        SizedBox(width: width * 0.03),
                        Container(
                          child: const Text('Address'),
                          constraints: BoxConstraints(maxWidth: width * 0.615),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_right_rounded,
                            color: green,
                            size: width * 0.085,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CheckboxListTile(
                    title: Text(
                      'Pay via Cash on Delivery',
                      style: TextStyle(
                        fontSize: width * 0.035,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: cod,
                    onChanged: (value) {
                      setState(() {
                        cod = value;
                      });
                    },
                  ),
                  SizedBox(height: width * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SolidButton(
                        name: 'Cancel',
                        color: red,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: width * 0.05),
                      SolidButton(
                        name: cod == true ? 'Proceed' : 'Proceed to Pay',
                        onPressed: () async {},
                      ),
                    ],
                  ),
                  SizedBox(height: width * 0.04),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        cart.clearItems();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const Home(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Clear Orders',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      drawer: const DrawerWidget(),
    );
  }
}
