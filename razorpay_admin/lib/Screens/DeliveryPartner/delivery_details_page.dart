import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_admin/Helpers/button.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Helpers/style.dart';
import 'package:razorpay_admin/Providers/delivery_orders.dart';
import 'package:razorpay_admin/Widgets/appbar_widget.dart';
import 'package:razorpay_admin/Widgets/dialogs.dart';

class DeliveryOrderPage extends StatelessWidget {
  static const pg = 'deliveryDetailed';

  const DeliveryOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final orderId = ModalRoute.of(context)!.settings.arguments as String;
    final provider = Provider.of<DeliveryOrders>(context);
    final order = provider.findById(orderId);
    final foodDetails = order.foodDetails;

    return Scaffold(
      appBar: AppBarWidget.appBar(
        context: context,
        title: order.name,
        backIcon: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.075,
        ),
        child: ListView(
          children: [
            SizedBox(height: width * 0.075),
            InkWell(
              onTap: () async {},
              child: Text(
                order.address ?? "",
                style: TextStyle(
                  fontSize: width * 0.037,
                ),
              ),
            ),
            SizedBox(height: width * 0.04),
            InkWell(
              onTap: () {},
              child: Text(
                '+91 ${order.phone}',
                style: TextStyle(
                  fontSize: width * 0.037,
                ),
              ),
            ),
            SizedBox(height: width * 0.075),
            Text(
              'Bill Amount',
              style: greenBoldText.copyWith(
                fontSize: width * 0.05,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: width * 0.075),
            ListView.builder(
              itemCount: foodDetails!.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Container(
                  margin: EdgeInsets.only(bottom: width * 0.07),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(foodDetails[i]['title']),
                      Text('₹${foodDetails[i]['price']}'),
                    ],
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery Charges'),
                Text('₹${order.deliveryCharges}'),
              ],
            ),
            SizedBox(height: width * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Bill Total'),
                SizedBox(width: width * 0.05),
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
                    Text('₹ ${order.totalBillAmount}'),
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
            Text(
              order.paymentStatus == 'Paid'
                  ? 'Paid via ${order.paymentType}'
                  : 'Pay on Delivery',
              style: order.paymentStatus == 'Paid'
                  ? const TextStyle()
                  : const TextStyle(color: Colors.red),
            ),
            SizedBox(height: width * 0.07),
            Align(
              child: order.status == 'Delivered'
                  ? Text(
                      'Delivered',
                      style: greenBoldText.copyWith(
                        fontSize: width * 0.05,
                      ),
                    )
                  : SolidButton(
                      name: 'Deliver',
                      onPressed: () {
                        Dialogs dialogs = Dialogs();

                        dialogs
                            .deliveryConfirmation(context)
                            .then((value) async {
                          if (value) {
                            dialogs.loading(context);

                            await provider.orderDelivered(orderId).then((_) {
                              dialogs.dismiss(context);
                            }).catchError((e) {
                              dialogs.dismiss(context);
                              dialogs.error(context: context);
                            });
                          }
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
