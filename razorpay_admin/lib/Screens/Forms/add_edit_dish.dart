import 'package:flutter/material.dart';
import 'package:razorpay_admin/Helpers/style.dart';
import 'package:razorpay_admin/Models/food_model.dart';
import 'package:razorpay_admin/Screens/Forms/add_edit_form.dart';
import 'package:razorpay_admin/Widgets/appbar_widget.dart';

class AddEditDish extends StatefulWidget {
  static const pg = 'addEditDish';

  // ignore: use_key_in_widget_constructors
  const AddEditDish({
    this.addPage,
    this.editFood,
  });

  final bool? addPage;
  final FoodModel? editFood;

  @override
  _AddEditDishState createState() => _AddEditDishState();
}

class _AddEditDishState extends State<AddEditDish> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarWidget.appBar(
        backIcon: true,
        context: context,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.13,
        ),
        alignment: Alignment.center,
        child: ListView(
          children: [
            SizedBox(height: width * 0.05),
            Text(
              widget.addPage == true ? 'Add New Dish' : 'Edit Dish',
              style: greenBoldText.copyWith(
                fontSize: width * 0.045,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: width * 0.07),

            //.... Add or Edit Form

            AddEditForm(addPage: widget.addPage, editFood: widget.editFood),

            //....

            SizedBox(height: width * 0.07),
          ],
        ),
      ),
    );
  }
}
