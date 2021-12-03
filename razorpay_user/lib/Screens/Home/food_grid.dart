import 'package:flutter/material.dart';
import 'package:razorpay_user/Models/food_model.dart';
import 'package:razorpay_user/Widgets/food_tile.dart';

class FoodGrid extends StatefulWidget {
  const FoodGrid({Key? key, @required this.type}) : super(key: key);

  final String? type;

  @override
  _FoodGridState createState() => _FoodGridState();
}

class _FoodGridState extends State<FoodGrid> {
  final List _foodList = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(height: width * 0.05),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: width * 0.7,
            ),
            itemCount: 5,
            itemBuilder: (context, index) {
              return FoodTile(
                foodModel: FoodModel(
                  id: '12',
                  title: 'Biriyani',
                  price: 150,
                  combo: false,
                  type: 'Breakfast',
                  availability: 10,
                  description: 'Chicken Biriyani - South Indian Style',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCWMpeGxyNE1jVjX1UfyOBspCrcSvDu0bq4Q&usqp=CAU',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
