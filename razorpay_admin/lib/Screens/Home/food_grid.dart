import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_admin/Widgets/dialogs.dart';
import 'package:razorpay_admin/Widgets/food_tile.dart';

class FoodGrid extends StatefulWidget {
  const FoodGrid({Key? key, @required this.type}) : super(key: key);

  final String? type;

  @override
  _FoodGridState createState() => _FoodGridState();
}

class _FoodGridState extends State<FoodGrid> {
  List _foodList = [];
  Dialogs dialogs = Dialogs();

  // var _isInit = true;
  // var _isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   if (_isInit &&
  //       !Provider.of<FoodItems>(context, listen: false).listFetched) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     print('Hello');

  //     Provider.of<FoodItems>(context, listen: false).fetchItems().then((value) {
  //       // checkCartFood();

  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }).catchError((error) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       dialogs.error(context: context);
  //     });
  //   }

  //   _isInit = false;
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final provider = Provider.of<FoodItems>(context);

    // switch (widget.type) {
    //   case 'Breakfast':
    //     {
    //       _foodList = provider.breakfastItems;
    //     }
    //     break;

    //   case 'Lunch':
    //     {
    //       _foodList = provider.lunchItems;
    //     }
    //     break;
    //   case 'Dinner':
    //     {
    //       _foodList = provider.dinnerItems;
    //     }
    //     break;

    //   default:
    //     {
    //       _foodList = provider.specialItems;
    //     }
    //     break;
    // }

    return Column(
      children: [
        SizedBox(height: width * 0.05),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: width * 0.7,
            ),
            itemCount: _foodList.length,
            itemBuilder: (context, index) {
              return FoodTile(
                foodModel: _foodList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
