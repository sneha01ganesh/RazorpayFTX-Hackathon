import 'package:flutter/material.dart';
import 'package:razorpay_admin/Helpers/colors.dart';

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
          vertical: width * 0.035,
          horizontal: width * 0.12,
        ),
        backgroundColor: color ?? green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            width * 0.05,
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, this.text, this.onPressed}) : super(key: key);

  final String? text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text ?? '',
        style: TextStyle(
          color: Colors.black,
          fontSize: width * 0.036,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
          vertical: width * 0.025,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            width * 0.03,
          ),
        ),
        elevation: width * 0.01,
      ),
    );
  }
}
