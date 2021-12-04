import 'package:flutter/material.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Helpers/custom_icons.dart';
import 'package:razorpay_admin/Helpers/style.dart';
import 'package:razorpay_admin/Models/order_item.dart';

class AdminDeliveryCard extends StatefulWidget {
  const AdminDeliveryCard({
    Key? key,
    @required this.item,
  }) : super(key: key);

  final OrderItem? item;

  @override
  _AdminDeliveryCardState createState() => _AdminDeliveryCardState();
}

class _AdminDeliveryCardState extends State<AdminDeliveryCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        // Navigator.pushNamed(
        //   context,
        //   AdminDeliveryDetailed.pg,
        //   arguments: widget.item.id,
        // );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            width * 0.05,
          ),
        ),
        elevation: width * 0.007,
        margin: EdgeInsets.symmetric(
          vertical: width * 0.02,
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: width * 0.06,
            bottom: width * 0.05,
            top: width * 0.07,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.person_sharp,
                    color: green,
                  ),
                  SizedBox(width: width * 0.045),
                  Text(
                    widget.item!.name ?? "",
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
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: width * 0.57,
                        ),
                        child: Text(
                          widget.item!.address ?? "",
                          style: TextStyle(
                            fontSize: width * 0.0375,
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
                  Text(
                    widget.item!.phone ?? "",
                    style: TextStyle(
                      fontSize: width * 0.0375,
                    ),
                  ),
                ],
              ),
              SizedBox(height: width * 0.04),
              Text(
                widget.item!.deliveryPartner ?? "",
                style: greenText.copyWith(
                  fontSize: width * 0.0375,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
