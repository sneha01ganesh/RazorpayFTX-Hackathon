import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FoodGridShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: width * 0.7,
      ),
      itemBuilder: (context, index) {
        return Stack(
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
                          ShimmContainer(),
                          SizedBox(height: width * 0.03),
                          ShimmContainer(),
                          SizedBox(height: width * 0.03),
                          Shimmer.fromColors(
                            child: Container(
                              color: Colors.yellow,
                              height: width * 0.04,
                              width: width * 0.1,
                            ),
                            baseColor: Colors.grey[100]!,
                            highlightColor: Colors.grey[300]!,
                          ),
                          SizedBox(height: width * 0.03),
                          ShimmContainer(),
                          SizedBox(height: width * 0.06),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                    child: ClipOval(
                      child: Shimmer.fromColors(
                        child: Container(
                          color: Colors.yellow,
                        ),
                        baseColor: Colors.white54,
                        highlightColor: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
                radius: width * 0.135,
                backgroundColor: Colors.grey[300],
              ),
            ),
          ],
        );
      },
    );
  }
}

class RequestsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
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
            padding: EdgeInsets.only(
              left: width * 0.04,
              top: width * 0.06,
              bottom: width * 0.06,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: width * 0.45),
                      child: ShimmContainer(),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[100]!,
                      highlightColor: Colors.grey[300]!,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.035,
                          vertical: width * 0.012,
                        ),
                        height: width * 0.06,
                        width: width * 0.27,
                        decoration: BoxDecoration(
                          color: const Color(0xFF57C99E),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(width * 0.032),
                            bottomLeft: Radius.circular(width * 0.032),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: width * 0.05),
                Padding(
                  padding: EdgeInsets.only(right: width * 0.7),
                  child: ShimmContainer(),
                ),
                SizedBox(height: width * 0.03),
                Padding(
                  padding: EdgeInsets.only(right: width * 0.04),
                  child: ShimmContainer(),
                ),
                SizedBox(height: width * 0.01),
                Padding(
                  padding: EdgeInsets.only(right: width * 0.3),
                  child: ShimmContainer(),
                ),
                SizedBox(height: width * 0.025),
                Padding(
                  padding: EdgeInsets.only(
                    right: width * 0.04,
                    left: width * 0.6,
                  ),
                  child: SizedBox(
                    height: width * 0.03,
                    child: ShimmContainer(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ShimmContainer extends StatelessWidget {
  ShimmContainer({this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      child: Container(
        color: Colors.yellow,
        height: height ?? width * 0.04,
      ),
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[300]!,
    );
  }
}
