import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Helpers/custom_icons.dart';
import 'package:razorpay_admin/Helpers/style.dart';
import 'package:razorpay_admin/Providers/delivery_orders.dart';
import 'package:razorpay_admin/Screens/DeliveryPartner/delivery_details_page.dart';
import 'package:razorpay_admin/Screens/landing_screen.dart';
import 'package:razorpay_admin/Widgets/appbar_widget.dart';
import 'package:razorpay_admin/Widgets/dialogs.dart';

class DeliveryHome extends StatefulWidget {
  static const pg = 'deliveryHome';

  const DeliveryHome({Key? key}) : super(key: key);

  @override
  _DeliveryHomeState createState() => _DeliveryHomeState();
}

class _DeliveryHomeState extends State<DeliveryHome> {
  Dialogs dialogs = Dialogs();

  void logout() async {
    dialogs.loading(context, content: 'Logging Out...');

    await Future.delayed(const Duration(seconds: 2));

    await FirebaseAuth.instance.signOut().catchError((e) {
      dialogs.error(context: context);
    });

    dialogs.dismiss(context);
    Navigator.pushNamedAndRemoveUntil(
        context, LandingPage.pg, (route) => false);
  }

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit &&
        !Provider.of<DeliveryOrders>(context, listen: false).listFetched) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<DeliveryOrders>(context, listen: false)
          .fetchOrders()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((e) {
        setState(() {
          _isLoading = false;
        });

        dialogs.error(context: context);
      });
    }

    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deliveryData = Provider.of<DeliveryOrders>(context);
    final deliveryOrders = deliveryData.items;

    return Scaffold(
      appBar: AppBarWidget.appBar(
        context: context,
        title: 'Your Alloted Orders (${deliveryOrders.length})',
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
          ),
          SizedBox(width: width * 0.02),
        ],
      ),
      body: ListView.builder(
        itemCount: deliveryOrders.length,
        itemBuilder: (context, index) {
          final details = deliveryOrders[index];

          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                DeliveryOrderPage.pg,
                arguments: details.id,
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  width * 0.05,
                ),
              ),
              elevation: width * 0.007,
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.06,
                vertical: width * 0.02,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  left: width * 0.06,
                  bottom: width * 0.07,
                  top: details.status == 'Delivered' ? 0 : width * 0.07,
                ),
                child: Column(
                  children: [
                    Visibility(
                      visible: details.status == 'Delivered',
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.only(
                            right: width * 0.02,
                            left: width * 0.035,
                            top: width * 0.01,
                            bottom: width * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: lightGreen.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                width * 0.05,
                              ),
                              bottomLeft: Radius.circular(
                                width * 0.05,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Delivered',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: width * 0.01),
                              Icon(
                                CustomIcons.delivered,
                                size: width * 0.035,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.person_sharp,
                          color: green,
                        ),
                        SizedBox(width: width * 0.045),
                        Text(
                          details.name ?? "",
                          style: greenText.copyWith(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              CustomIcons.location,
                              color: green,
                              size: width * 0.05,
                            ),
                            SizedBox(width: width * 0.045),
                            InkWell(
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: width * 0.57,
                                ),
                                child: Text(
                                  details.address ?? "",
                                  style: TextStyle(
                                    fontSize: width * 0.0375,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: width * 0.03,
                          ),
                          child: Icon(
                            Icons.arrow_right_rounded,
                            size: width * 0.1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          CustomIcons.phone,
                          color: green,
                        ),
                        SizedBox(width: width * 0.045),
                        InkWell(
                          child: Text(
                            details.phone ?? "",
                            style: TextStyle(
                              fontSize: width * 0.0375,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
