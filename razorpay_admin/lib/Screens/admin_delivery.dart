import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_admin/Helpers/style.dart';
import 'package:razorpay_admin/Providers/admin_orders.dart';
import 'package:razorpay_admin/Widgets/admin_delivery_card.dart';
import 'package:razorpay_admin/Widgets/dialogs.dart';

class AdminDelivery extends StatefulWidget {
  static const pg = 'adminDelivery';

  const AdminDelivery({Key? key}) : super(key: key);

  @override
  _AdminDeliveryState createState() => _AdminDeliveryState();
}

class _AdminDeliveryState extends State<AdminDelivery> {
  Dialogs dialogs = Dialogs();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
          ),
          children: [
            PendingDelivery(),
            CompletedDelivery(),
          ],
        ),
      ),
    );
  }
}

class PendingDelivery extends StatelessWidget {
  const PendingDelivery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Consumer<AdminOrders>(
      builder: (context, order, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: width * 0.04),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black87,
                fontSize: width * 0.045,
              ),
              children: [
                const TextSpan(
                  text: 'Pending Delivery - ',
                ),
                TextSpan(
                  text: '${order.deliveryItems.length}',
                  style: greenText.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: width * 0.02),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: order.deliveryItems.length,
            itemBuilder: (context, index) {
              return AdminDeliveryCard(
                key: UniqueKey(),
                item: order.deliveryItems[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

class CompletedDelivery extends StatelessWidget {
  const CompletedDelivery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Consumer<AdminOrders>(
      builder: (context, order, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: width * 0.04),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black87,
                fontSize: width * 0.045,
              ),
              children: [
                const TextSpan(
                  text: 'Delivered - ',
                ),
                TextSpan(
                  text: '${order.deliveredItems.length}',
                  style: greenText.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: width * 0.02),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: order.deliveredItems.length,
            itemBuilder: (context, index) {
              return AdminDeliveryCard(
                key: UniqueKey(),
                item: order.deliveredItems[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
