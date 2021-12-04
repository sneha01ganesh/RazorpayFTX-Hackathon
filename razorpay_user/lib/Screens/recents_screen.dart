import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_user/Helpers/colors.dart';
import 'package:razorpay_user/Providers/orders.dart';
import 'package:razorpay_user/Widgets/recents_card.dart';

class Recents extends StatefulWidget {
  static const pg = 'recents';

  const Recents({Key? key}) : super(key: key);

  @override
  _RecentsState createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  List _recentsList = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<Orders>(context);
    _recentsList = provider.items;

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            'Your Recent Orders',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: green,
                ),
          ),
        ),
        SizedBox(height: width * 0.03),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            shrinkWrap: true,
            itemCount: _recentsList.length,
            itemBuilder: (context, index) {
              return RecentsCard(_recentsList[index]);
            },
          ),
        ),
      ],
    );
  }
}
