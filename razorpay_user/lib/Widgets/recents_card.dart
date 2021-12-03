import 'package:flutter/material.dart';
import 'package:razorpay_user/Helpers/colors.dart';
import 'package:razorpay_user/Helpers/custom_icons.dart';
import 'package:razorpay_user/Helpers/style.dart';

class RecentsCard extends StatelessWidget {
  const RecentsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                    child: const Text(
                      'address',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Delivered',
                        style: TextStyle(color: lightGreen),
                      ),
                      SizedBox(width: width * 0.01),
                      Icon(
                        CustomIcons.delivered,
                        color: lightGreen,
                        size: width * 0.04,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: width * 0.05),
              Row(
                children: const [
                  Text('₹100'),
                  Icon(
                    Icons.arrow_right_rounded,
                  ),
                ],
              ),
              SizedBox(height: width * 0.03),
              SizedBox(height: width * 0.01),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '02 Dec 2021',
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
