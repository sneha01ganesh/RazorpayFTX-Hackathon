import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_admin/Functions/image_upload.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Helpers/textfield_deco.dart';
import 'package:razorpay_admin/Models/food_model.dart';
import 'package:razorpay_admin/Widgets/appbar_widget.dart';
import 'package:razorpay_admin/Widgets/dialogs.dart';
import 'package:razorpay_admin/Widgets/image_input.dart';

class AddCombo extends StatefulWidget {
  static const pg = 'addCombo';

  const AddCombo({
    Key? key,
    this.onSubmit,
    this.onCancelled,
    this.editComboItem = false,
    this.editFood,
  }) : super(key: key);

  final Function? onSubmit;
  final VoidCallback? onCancelled;
  final bool? editComboItem;
  final FoodModel? editFood;

  @override
  _AddComboState createState() => _AddComboState();
}

class _AddComboState extends State<AddCombo> {
  final _formKey = GlobalKey<FormState>();
  Dialogs dialogs = Dialogs();

  final List<String> _foodTypeList = [
    "Type",
    "Breakfast",
    "Lunch",
    "Dinner",
    "Special",
  ];

  final TextEditingController _comboTitleCtrl = TextEditingController(),
      _comboPriceCtrl = TextEditingController(),
      _comboAvailabilityCtrl = TextEditingController(),
      _comboDescriptionCtrl = TextEditingController();

  FocusNode? amountFocus;

  FoodModel _comboDish = FoodModel(
    id: null,
    title: '',
    description: '',
    price: 0,
    availability: 0,
    imageUrl: '',
    type: '',
  );

  String _selectedFoodType = 'Type';
  String? _imageUrl;
  File? _pickedImage;
  var _foodId;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _removeImage() {
    _pickedImage = null;
  }

  _saveCombo() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_pickedImage == null) {
      dialogs.error(context: context, content: 'Please select an image.');
      return;
    }
    dialogs.uploading(context);

    if (_pickedImage != null) {
      await ImageUpload.uploadImage(context, _pickedImage ?? File('')).then(
        (value) {
          _imageUrl = value;
        },
      );
    }

    final _id = FirebaseFirestore.instance.collection('FoodItems').doc().id;
    _comboDish = FoodModel(
      id: _foodId ?? _id,
      title: _comboTitleCtrl.text.trim(),
      description: _comboDescriptionCtrl.text.trim(),
      price: int.parse(_comboPriceCtrl.text.trim()),
      availability: int.parse(_comboAvailabilityCtrl.text.trim()),
      type: _selectedFoodType,
      imageUrl: _imageUrl,
    );
    dialogs.dismiss(context);

    widget.onSubmit!(_comboDish);
  }

  @override
  void initState() {
    super.initState();
    if (mounted && widget.editComboItem!) {
      _comboDish = widget.editFood!;
      _foodId = widget.editFood!.id;
      _comboTitleCtrl.text = widget.editFood!.title!;
      _selectedFoodType = widget.editFood!.type!;
      _comboPriceCtrl.text = widget.editFood!.price.toString();
      _comboAvailabilityCtrl.text = widget.editFood!.availability.toString();
      _imageUrl = widget.editFood!.imageUrl;
      _comboDescriptionCtrl.text = widget.editFood!.description!;
    }

    amountFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    amountFocus!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarWidget.appBar(
        backIcon: widget.editComboItem!,
        context: context,
        title: 'Combo Item',
        icon: const Icon(
          Icons.close,
          color: Colors.black,
        ),
        iconOnPressed: widget.onCancelled,
        actions: [
          IconButton(
            onPressed: _saveCombo,
            icon: const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
          SizedBox(width: width * 0.02),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: width * 0.05),
              TextFormField(
                controller: _comboTitleCtrl,
                decoration: TextFieldDecoration.underLineDecoration(
                  width: width,
                  hint: 'Title of the Item',
                ),
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty || value.length < 3) {
                    return 'Enter a valid Title';
                  }
                  return null;
                },
              ),
              SizedBox(height: width * 0.055),
              DropdownButtonFormField<String>(
                items: _foodTypeList.map(
                  (type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(
                        type.toString(),
                        style: type == "Type"
                            ? const TextStyle(color: grey)
                            : const TextStyle(),
                      ),
                    );
                  },
                ).toList(),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                value: _selectedFoodType,
                onChanged: (value) {
                  setState(() {
                    _selectedFoodType = value ?? "";
                  });
                },
                decoration: TextFieldDecoration.underLineDecoration(
                  hint: 'Type',
                  width: width,
                ),
                validator: (value) {
                  if (value == 'Type') {
                    return 'Enter a valid food type';
                  }
                  return null;
                },
              ),
              SizedBox(height: width * 0.055),
              TextFormField(
                controller: _comboPriceCtrl,
                decoration: TextFieldDecoration.underLineDecoration(
                  width: width,
                  hint: 'Amount',
                ).copyWith(
                  prefixText:
                      amountFocus!.hasFocus || _comboPriceCtrl.text.isNotEmpty
                          ? '₹ '
                          : '',
                  prefixStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: width * 0.04,
                  ),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter the Price';
                  }
                  if (int.parse(value) <= 0) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: width * 0.055),
              TextFormField(
                controller: _comboAvailabilityCtrl,
                decoration: TextFieldDecoration.underLineDecoration(
                  width: width,
                  hint: 'Available Count',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.go,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter the Availability Count';
                  }
                  if (int.parse(value) < 0) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: width * 0.04),
              ImageInput(
                addPage: !widget.editComboItem!,
                editImageUrl: _imageUrl,
                onSelectImage: _selectImage,
                onRemoveImage: _removeImage,
              ),
              SizedBox(height: width * 0.04),
              TextFormField(
                controller: _comboDescriptionCtrl,
                decoration: TextFieldDecoration.rRectDecoration(
                  width: width,
                  hint:
                      'Descriptions\n\n(Add more details such as Quantity of Food served, Package details, etc)',
                ).copyWith(
                  hintStyle: const TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a description';
                  }
                  if (value.length < 4) {
                    return 'Enter a valid description';
                  }
                  return null;
                },
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
