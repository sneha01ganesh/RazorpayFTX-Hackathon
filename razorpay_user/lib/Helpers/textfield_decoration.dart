import 'package:flutter/material.dart';
import 'package:razorpay_user/Helpers/colors.dart';
import 'package:razorpay_user/Helpers/style.dart';

class TextFieldDecoration {
  static InputDecoration rRectDecoration({
    final width,
    String? hint,
    String? label,
  }) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      labelStyle: greenText,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          width * 0.018,
        ),
        borderSide: BorderSide(
          width: width * 0.002,
          color: green,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          width * 0.018,
        ),
        borderSide: BorderSide(
          width: width * 0.001,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          width * 0.018,
        ),
        borderSide: BorderSide(
          width: width * 0.002,
          color: Colors.red,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          width * 0.018,
        ),
        borderSide: BorderSide(
          width: width * 0.002,
          color: green,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          width * 0.018,
        ),
        borderSide: BorderSide(
          width: width * 0.002,
          color: Colors.red,
        ),
      ),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        vertical: width * 0.04,
        horizontal: width * 0.045,
      ),
    );
  }
}
