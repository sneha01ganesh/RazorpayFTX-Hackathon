import 'package:flutter/material.dart';
import 'package:razorpay_admin/Helpers/colors.dart';

class TextFieldDecoration {
  static InputDecoration rRectDecoration({
    final width,
    String? hint,
  }) {
    return InputDecoration(
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          width * 0.018,
        ),
        borderSide: BorderSide(
          width: width * 0.002,
          color: green,
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
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          width * 0.018,
        ),
        borderSide: BorderSide(
          width: width * 0.002,
          color: Colors.black38,
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

  static InputDecoration underLineDecoration({
    final width,
    final String? hint,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: width * 0.02,
      ),
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: width * 0.04,
        fontWeight: FontWeight.w500,
        color: Colors.black45,
      ),
      isDense: true,
    );
  }
}
