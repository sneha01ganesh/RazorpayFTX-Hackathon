import 'package:flutter/material.dart';
import 'package:razorpay_admin/Helpers/colors.dart';

//ignore: must_be_immutable
class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({Key? key, this.checked, this.onTap});

  bool? checked = false;
  VoidCallback? onTap;

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Material(
      elevation: width * 0.01,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          width * 0.012,
        ),
      ),
      child: SizedBox(
        width: Checkbox.width + width * 0.01,
        height: Checkbox.width + width * 0.01,
        child: Theme(
          data: ThemeData(unselectedWidgetColor: Colors.transparent),
          child: Checkbox(
            value: widget.checked,
            onChanged: (value) {
              widget.onTap!();
            },
            activeColor: Colors.transparent,
            checkColor: green,
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
        ),
      ),
    );
  }
}
