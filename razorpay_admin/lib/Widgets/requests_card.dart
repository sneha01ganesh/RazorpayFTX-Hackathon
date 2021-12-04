import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Helpers/custom_icons.dart';
import 'package:razorpay_admin/Helpers/style.dart';
import 'package:razorpay_admin/Models/order_item.dart';
import 'package:razorpay_admin/Providers/admin_orders.dart';
import 'package:razorpay_admin/Widgets/dialogs.dart';

class RequestsCard extends StatefulWidget {
  RequestsCard({
    Key? key,
    @required this.item,
  }) : super(key: key);

  final OrderItem? item;

  @override
  _RequestsCardState createState() => _RequestsCardState();
}

class _RequestsCardState extends State<RequestsCard> {
  bool _switchValue = false;
  Dialogs dialogs = Dialogs();

  void declineOrder(String id) {
    dialogs.yesNoDialog(context, content: 'Do you want to decline this order?',
        yesFn: () async {
      dialogs.dismiss(context);

      dialogs.loading(context, content: 'Declining Order...');
      await Provider.of<AdminOrders>(context, listen: false)
          .declineOrder(id)
          .then((_) {
        dialogs.dismiss(context);
      }).catchError((error) {
        dialogs.dismiss(context);
        dialogs.error(context: context);
      });
    });
  }

  void confirmOrder(String id) async {
    dialogs.loading(context, content: 'Confirming Order...');
    await Provider.of<AdminOrders>(context, listen: false)
        .confirmOrder(id)
        .then((_) {
      dialogs.dismiss(context);
    }).catchError((error) {
      dialogs.dismiss(context);
      dialogs.error(context: context);
    });
  }

  @override
  void initState() {
    super.initState();
    _switchValue = widget.item!.requestStatus == 'Confirmed';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {},
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
            bottom: width * 0.07,
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
                  Container(
                    constraints: BoxConstraints(maxWidth: width * 0.45),
                    child: Text(
                      widget.item!.name!,
                      style: greenText.copyWith(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  widget.item!.requestStatus == 'Confirmation Pending'
                      ? Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.02),
                          child: Text(
                            'Confirmation\nPending',
                            style: TextStyle(
                              fontSize: width * 0.035,
                              color: red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container(),
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
                          widget.item!.address!,
                          style: TextStyle(
                            fontSize: width * 0.0375,
                          ),
                        ),
                      ),
                    ],
                  ),
                  widget.item!.requestStatus == 'Declined'
                      ? SizedBox(
                          height: width * 0.1,
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                            right: width * 0.03,
                          ),
                          child: Transform.scale(
                            scale: 0.9,
                            child: CupertinoSwitch(
                              value: _switchValue,
                              activeColor: green,
                              onChanged: (value) {
                                if (value) {
                                  _switchValue = true;
                                  confirmOrder(widget.item!.id!);
                                } else if (value == false) {
                                  _switchValue = false;
                                  declineOrder(widget.item!.id!);
                                }
                              },
                            ),
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
                    widget.item!.phone!,
                    style: TextStyle(
                      fontSize: width * 0.0375,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
