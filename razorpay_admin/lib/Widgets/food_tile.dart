import 'package:flutter/material.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Models/food_model.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({
    Key? key,
    this.foodModel,
  }) : super(key: key);

  final FoodModel? foodModel;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => FoodDetailed(
        //       foodModel: foodModel,
        //     ),
        //   ),
        // );
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.045,
            ),
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: width * 0.143),
                Card(
                  elevation: width * 0.009,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      width * 0.07,
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: width * 0.2),
                        Text(
                          foodModel!.title ?? "",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: width * 0.03),
                        Text(
                          foodModel!.description ?? "",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: width * 0.03),
                        Text(
                          '₹${foodModel!.price}',
                          style: const TextStyle(
                            color: green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: width * 0.03),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.037,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Available: ',
                              ),
                              TextSpan(
                                text: foodModel!.availability! <= 0
                                    ? '0'
                                    : '${foodModel!.availability}',
                                style: const TextStyle(
                                  color: green,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: width * 0.06),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Hero(
            tag: foodModel!.id ?? "",
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(
                vertical: width * 0.02,
              ),
              child: CircleAvatar(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        width,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: width * 0.04,
                          color: Colors.black26,
                          offset: Offset(0, width * 0.015),
                        )
                      ],
                    ),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: ClipOval(
                        child: ColorFiltered(
                          colorFilter: foodModel!.availability == 0
                              ? ColorFilter.mode(
                                  Colors.grey[100] ?? Colors.grey,
                                  BlendMode.saturation,
                                )
                              : const ColorFilter.mode(
                                  Colors.transparent,
                                  BlendMode.multiply,
                                ),
                          child: Image.network(
                            foodModel!.imageUrl ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                radius: width * 0.135,
                backgroundColor: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
