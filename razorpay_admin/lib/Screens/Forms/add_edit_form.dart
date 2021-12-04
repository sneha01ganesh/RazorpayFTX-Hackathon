import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_admin/Functions/image_upload.dart';
import 'package:razorpay_admin/Helpers/button.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Helpers/textfield_deco.dart';
import 'package:razorpay_admin/Models/food_model.dart';
import 'package:razorpay_admin/Providers/food_items.dart';
import 'package:razorpay_admin/Screens/Forms/add_combo.dart';
import 'package:razorpay_admin/Widgets/custom_check_box.dart';
import 'package:razorpay_admin/Widgets/dialogs.dart';
import 'package:razorpay_admin/Widgets/image_input.dart';

class AddEditForm extends StatefulWidget {
  AddEditForm({Key? key, this.addPage, this.editFood}) : super(key: key);

  final bool? addPage;
  final FoodModel? editFood;

  @override
  _AddEditFormState createState() => _AddEditFormState();
}

class _AddEditFormState extends State<AddEditForm> {
  final TextEditingController _titleCtrl = TextEditingController(),
      _priceCtrl = TextEditingController(),
      _availableCtrl = TextEditingController(),
      _descriptionCtrl = TextEditingController();

  FocusNode? amountFocus;

  File? _pickedImage;
  String _selectedFoodType = 'Type';
  String? _imageUrl;
  bool _combo = false;
  List<FoodModel> _comboItem = [];
  List<dynamic> _comboDocs = [];
  var _foodId;

  FoodModel _editedDish = FoodModel(
    id: null,
    title: '',
    description: '',
    price: 0,
    availability: 0,
    imageUrl: '',
    type: '',
  );

  final List<String> _foodTypeList = [
    "Type",
    "Breakfast",
    "Lunch",
    "Dinner",
    "Special",
  ];

  final _formKey = GlobalKey<FormState>();
  Dialogs dialogs = Dialogs();

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _removeImage() {
    _pickedImage = null;
  }

  void _addCombo() {
    setState(() {
      _combo = !_combo;

      if (_combo == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => AddCombo(
              onSubmit: () => _saveComboItem,
              onCancelled: _cancelComboItem,
            ),
          ),
        );
      } else {
        _comboItem = [];
      }
    });
  }

  _saveComboItem(FoodModel comboFood) {
    _comboItem.add(comboFood);
    setState(() {});
    Navigator.pop(context);
  }

  void _updateComboItem(FoodModel comboFood) {
    final index = _comboItem.indexWhere((food) => food.id == comboFood.id);
    _comboItem[index] = comboFood;
    setState(() {});
    Navigator.pop(context);
  }

  void _cancelComboItem() {
    setState(() {
      if (_comboItem.isEmpty || _comboItem == []) {
        _combo = false;
      }
    });
    Navigator.pop(context);
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    if (_pickedImage == null && _imageUrl!.isEmpty) {
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

    _editedDish = FoodModel(
      id: _foodId,
      title: _titleCtrl.text.trim(),
      description: _descriptionCtrl.text.trim(),
      price: int.parse(_priceCtrl.text.trim()),
      availability: int.parse(_availableCtrl.text.trim()),
      type: _selectedFoodType,
      imageUrl: _imageUrl,
      combo: _combo,
      comboItems: _comboItem,
      comboDocs: _comboDocs,
    );

    if (widget.addPage == true) {
      Provider.of<FoodItems>(context, listen: false).addFood(_editedDish);
    } else {
      Provider.of<FoodItems>(context, listen: false).updateFood(_editedDish);
    }
    dialogs.dismiss(context);
    dialogs.dismiss(context);
  }

  @override
  void initState() {
    super.initState();
    if (mounted && widget.addPage == false) {
      _editedDish = widget.editFood!;
      _foodId = widget.editFood!.id;
      _titleCtrl.text = widget.editFood!.title!;
      _selectedFoodType = widget.editFood!.type!;
      _priceCtrl.text = widget.editFood!.price.toString();
      _availableCtrl.text = widget.editFood!.availability.toString();
      _imageUrl = widget.editFood!.imageUrl!;
      _descriptionCtrl.text = widget.editFood!.description!;
      _combo = widget.editFood!.combo ?? false;
      _comboItem = widget.editFood!.comboItems!;
      _comboDocs = widget.editFood!.comboDocs!;
    }

    amountFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    amountFocus!.dispose();

    _titleCtrl.clear();
    _titleCtrl.clear();
    _selectedFoodType = 'Type';
    _imageUrl = null;
    _pickedImage = null;
    _priceCtrl.clear();
    _availableCtrl.clear();
    _descriptionCtrl.clear();
    _combo = false;
    _comboItem = [];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleCtrl,
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
            controller: _priceCtrl,
            focusNode: amountFocus,
            decoration: TextFieldDecoration.underLineDecoration(
              width: width,
              hint: 'Amount',
            ).copyWith(
              prefixText: amountFocus!.hasFocus || _priceCtrl.text.isNotEmpty
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
            controller: _availableCtrl,
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
            addPage: widget.addPage,
            editImageUrl: _imageUrl,
            onSelectImage: _selectImage,
            onRemoveImage: _removeImage,
          ),
          SizedBox(height: width * 0.04),
          TextFormField(
            controller: _descriptionCtrl,
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
          SizedBox(height: width * 0.04),
          widget.addPage == true
              ? Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
                  ),
                  child: InkWell(
                    onTap: _addCombo,
                    splashColor: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: width * 0.01,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Combo',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: _combo ? green : Colors.black45,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          CustomCheckbox(
                            checked: _combo,
                            onTap: _addCombo,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          _combo && widget.addPage == true
              ? Column(
                  children: [
                    SizedBox(height: width * 0.055),
                    for (int i = 0; i < _comboItem.length; i++)
                      ListTile(
                        title: Text(
                          'Combo Item ${i + 1}',
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: width * 0.045,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => AddCombo(
                                editComboItem: true,
                                editFood: _comboItem[i],
                                onSubmit: () => _updateComboItem,
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                )
              : Container(),
          _combo && widget.addPage == true
              ? TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => AddCombo(
                          onSubmit: () => _saveComboItem,
                          onCancelled: _cancelComboItem,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Add Another Item',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : Container(),
          SizedBox(height: width * 0.055),
          Align(
            child: SolidButton(
              name: widget.addPage == true ? 'Post' : 'Update',
              onPressed: _saveForm,
            ),
          ),
        ],
      ),
    );
  }
}
