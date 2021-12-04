import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ImageUpload {
  static Future<String> uploadImage(BuildContext context, File _image) async {
    String fileName = basename(_image.path);

    final snap =
        await FirebaseStorage.instance.ref().child(fileName).putFile(_image);
    final url = await snap.ref.getDownloadURL();

    return url;
  }
}
