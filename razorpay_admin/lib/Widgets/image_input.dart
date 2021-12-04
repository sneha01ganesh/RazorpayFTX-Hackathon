import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razorpay_admin/Helpers/colors.dart';

class ImageInput extends StatefulWidget {
  ImageInput({
    this.addPage,
    this.editImageUrl,
    this.onSelectImage,
    this.onRemoveImage,
  });

  final bool? addPage;
  final String? editImageUrl;
  final Function? onSelectImage;
  final Function? onRemoveImage;

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile? _pickedImage;
  final _picker = ImagePicker();

  void _addImage() {
    if (_pickedImage == null) {
      _newImage = false;
      final width = MediaQuery.of(context).size.width;

      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              width * 0.06,
            ),
            topRight: Radius.circular(
              width * 0.06,
            ),
          ),
        ),
        builder: (context) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: width * 0.04),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                  borderRadius: BorderRadius.circular(width * 0.02),
                  splashColor: green.withOpacity(0.3),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: width * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_library,
                          color: green,
                          size: width * 0.1,
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            fontSize: width * 0.038,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                  borderRadius: BorderRadius.circular(width * 0.02),
                  splashColor: green.withOpacity(0.3),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: width * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_camera,
                          color: green,
                          size: width * 0.1,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontSize: width * 0.038,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void _pickImage(ImageSource source) async {
    _pickedImage = await _picker.pickImage(source: source, imageQuality: 75);
    setState(() {});
    widget.onSelectImage!(File(_pickedImage!.path));
  }

  bool _newImage = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: _addImage,
      child: Card(
        elevation: width * 0.007,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            width * 0.04,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: width * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: width * 0.04),
              Text(
                widget.addPage == true ? 'Upload Image' : 'Update New Image',
                style: TextStyle(
                  fontSize: width * 0.045,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: width * 0.02,
              ),
              (_pickedImage != null || widget.addPage == false) && (!_newImage)
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          child: SizedBox(
                            height: width * 0.3,
                            width: width * 0.3,
                            child: _pickedImage != null
                                ? Image.file(
                                    File(_pickedImage!.path),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    widget.editImageUrl ?? "",
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: width * 0.03,
                            child: FittedBox(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _pickedImage = null;
                                    _newImage = true;
                                  });
                                  widget.onRemoveImage!();
                                },
                                icon: Icon(
                                  Icons.close_rounded,
                                  size: width * 0.07,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: width * 0.07),
                      child: Icon(
                        Icons.photo_camera_rounded,
                        color: green,
                        size: width * 0.125,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
