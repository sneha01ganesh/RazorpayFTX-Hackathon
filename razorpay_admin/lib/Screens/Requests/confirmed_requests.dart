import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_admin/Helpers/style.dart';
import 'package:razorpay_admin/Providers/admin_orders.dart';
import 'package:razorpay_admin/Widgets/requests_card.dart';

class ConfirmedRequests extends StatelessWidget {
  const ConfirmedRequests({Key? key}) : super(key: key);

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
                color: const Color(0xFF7b7b7b),
                fontSize: width * 0.045,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
              children: [
                const TextSpan(
                  text: 'Confirmed Requests - ',
                ),
                TextSpan(
                  text: '${order.confirmedItems.length}',
                  style: greenText.copyWith(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: width * 0.02),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: order.confirmedItems.length,
            itemBuilder: (context, index) {
              return RequestsCard(
                key: Key(order.confirmedItems[index].id ?? ""),
                item: order.confirmedItems[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
