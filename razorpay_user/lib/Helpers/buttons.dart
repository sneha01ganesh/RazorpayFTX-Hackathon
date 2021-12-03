import 'package:flutter/material.dart';
import 'package:razorpay_user/Helpers/colors.dart';

class SolidButton extends StatelessWidget {
  const SolidButton({
    Key? key,
    this.name,
    this.color,
    this.onPressed,
  }) : super(key: key);

  final String? name;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return TextButton(
      onPressed: onPressed,
      child: Text(
        name ?? "",
        style: TextStyle(
          color: Colors.white,
          fontSize: width * 0.04,
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: width * 0.03,
          horizontal: width * 0.07,
        ),
        backgroundColor: color == null ? green : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            width * 0.028,
          ),
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
    this.onAddTap,
    this.onRemoveTap,
    this.value,
  }) : super(key: key);

  final VoidCallback? onAddTap;
  final VoidCallback? onRemoveTap;
  final int? value;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Material(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(width * 0.025),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: onRemoveTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.015,
                  vertical: width * 0.01,
                ),
                child: Icon(
                  Icons.remove,
                  size: width * 0.035,
                  color: Colors.red,
                ),
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                color: darkBlue,
                fontSize: width * 0.04,
              ),
            ),
            InkWell(
              onTap: onAddTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.015,
                  vertical: width * 0.01,
                ),
                child: Icon(
                  Icons.add,
                  size: width * 0.035,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
