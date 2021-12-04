import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_admin/Providers/admin_orders.dart';
import 'package:razorpay_admin/Providers/delivery_persons.dart';
import 'package:razorpay_admin/Screens/Requests/confirmed_requests.dart';
import 'package:razorpay_admin/Screens/Requests/declined_requests.dart';
import 'package:razorpay_admin/Screens/Requests/pending_requests.dart';
import 'package:razorpay_admin/Widgets/dialogs.dart';
import 'package:razorpay_admin/Widgets/shimmer.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  Dialogs dialogs = Dialogs();

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final orderProvider = Provider.of<AdminOrders>(context, listen: false);
    final deliveryPersonProvider =
        Provider.of<DeliveryPersons>(context, listen: false);

    if (_isInit && !orderProvider.listFetched) {
      setState(() {
        _isLoading = true;
      });

      orderProvider.fetchOrders().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
        dialogs.error(context: context);
      });
    }

    if (_isInit && !deliveryPersonProvider.listFetched) {
      deliveryPersonProvider.fetchItems().catchError((error) {
        dialogs.error(context: context);
      });
    }

    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _isLoading
          ? RequestsShimmer()
          : Container(
              alignment: Alignment.center,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                children: const [
                  PendingRequests(),
                  ConfirmedRequests(),
                  DeclinedRequests(),
                ],
              ),
            ),
    );
  }
}
