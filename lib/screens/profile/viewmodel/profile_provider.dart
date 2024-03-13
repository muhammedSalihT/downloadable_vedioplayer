import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController dobCtr = TextEditingController();
  File? fileImage;
  final formKey = GlobalKey<FormState>();

  void saveUserData() {
    try {
      if (formKey.currentState!.validate()) {}
    } catch (e) {}
  }

  void takeImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? data = await picker.pickImage(source: ImageSource.gallery);

      if (data != null) {
        fileImage = File(data.path);
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
