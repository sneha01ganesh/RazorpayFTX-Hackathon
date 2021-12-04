import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_user/Helpers/colors.dart';
import 'package:razorpay_user/Helpers/custom_icons.dart';
import 'package:razorpay_user/Helpers/date_format.dart';
import 'package:razorpay_user/Helpers/style.dart';
import 'package:razorpay_user/Models/order_item.dart';

class RecentsCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RecentsCard(this.orderItem);

  final OrderItem? orderItem;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool delivered = orderItem!.status == 'Delivered';

    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: width * 0.025,
          horizontal: width * 0.05,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            width * 0.045,
          ),
        ),
        elevation: 3,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: width * 0.06,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: width * 0.5),
                    child: Text(
                      orderItem!.address ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  delivered
                      ? Row(
                          children: [
                            Text(
                              orderItem!.status ?? "",
                              style: const TextStyle(color: lightGreen),
                            ),
                            SizedBox(width: width * 0.01),
                            Icon(
                              CustomIcons.delivered,
                              color: lightGreen,
                              size: width * 0.04,
                            ),
                          ],
                        )
                      : orderItem!.requestStatus == 'Confirmation Pending'
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.035,
                              ),
                              child: const Text(
                                'Confirmation\nPending',
                                style: TextStyle(
                                  color: red,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.035,
                                vertical: width * 0.012,
                              ),
                              decoration: BoxDecoration(
                                color: orderItem!.requestStatus == 'Declined'
                                    ? red
                                    : const Color(0xFF57C99E),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(width * 0.032),
                                  bottomLeft: Radius.circular(width * 0.032),
                                ),
                              ),
                              child: Text(
                                orderItem!.status == 'Partner Alloted'
                                    ? 'Partner Alloted'
                                    : orderItem!.requestStatus != 'Pending'
                                        ? orderItem!.requestStatus ?? ''
                                        : orderItem!.status ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                ],
              ),
              SizedBox(height: width * 0.05),
              Row(
                children: [
                  Text('₹${orderItem!.totalBillAmount}'),
                  const Icon(
                    Icons.arrow_right_rounded,
                  ),
                ],
              ),
              SizedBox(height: width * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.037,
                    ),
                    children: [
                      for (int i = 0; i < orderItem!.foodDetails!.length; i++)
                        TextSpan(
                          text:
                              '${orderItem!.foodDetails![i]['title']} x ${orderItem!.foodDetails![i]['quantity']}${i != orderItem!.foodDetails!.length - 1 ? ', ' : ''}',
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: width * 0.01),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  DateFormat.formatDate(orderItem!.dateTime ?? Timestamp.now()),
                  style: greyText.copyWith(fontSize: width * 0.03),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
